; ============================================================
; boot_rom.s — Firmware de la Boot ROM (First Stage) para RTM32/STX4
;
; Reside en 0xF0000000 (Cold Boot Vector). Es lo primero que
; ejecuta la CPU tras un Reset. En ese punto, según la spec:
;   PC   = 0xF0000000
;   PSW  = M:1 (Kernel), I:0 (IRQ off), T:1 (Traps on)
;   VBR  = 0xF0000000  (coincide con este mismo bloque de código)
;   GPR  = todos en 0x00000000
;
; DECISIÓN DE DISEÑO (Cap. 8 "Excepciones" está pendiente en el
; manual, así que se define acá):
;   - El código de arranque es directo, NO una tabla de punteros.
;   - Antes de habilitar traps/interrupciones se reubica $vbr a
;     una tabla de vectores separada (0xF0010000), para que
;     TRAP/IRQ nunca lean instrucciones de boot como si fueran
;     punteros de handler.
;   - Cada entrada de la tabla es un WORD con la DIRECCIÓN del
;     handler (no el código del handler en sí), consistente con
;     "PC = M[$vbr + TV(param)]".
; ============================================================

VECTOR_TABLE_BASE   equ 0xF0010000   ; nueva base de $vbr (ajustar a tu mapa real)
VECTOR_TABLE_COUNT  equ 32           ; cantidad de entradas a inicializar
KERNEL_STACK_TOP    equ 0x80100000   ; ejemplo: ajustar al tamaño real de Kernel RAM
GLOBAL_DATA_BASE    equ 0x80000000   ; ejemplo: base de datos globales del kernel

; SFR indices (según Tabla 3.x del manual — ajustar a los índices reales)
PSW  equ 0
ECR  equ 1
EPC  equ 2
ESR  equ 3
BVA  equ 4
VBR  equ 5
PIR  equ 6

; --------------------------------------------------------
; org 0xF0000000
; --------------------------------------------------------
reset_entry:
    ; 1) Reubicar la tabla de vectores ANTES de habilitar nada
    lci   $t0, $zero, 0xF001         ; $t0 = 0xF0010000
    cts   $t0, VBR

    ; 2) Configurar stack y puntero global
    lci   $sp, $zero, 0x8010         ; $sp = 0x80100000
    lci   $gp, $zero, 0x8000         ; $gp = 0x80000000

    ; 3) Instalar handlers por defecto en la tabla de vectores
    jal   install_vector_table

    ; 4) Recién ahora habilitar interrupciones (bit I del PSW)
    cfs   $t0, PSW
    ori   $t0, $t0, 0x0002           ; bit 1 = I
    cts   $t0, PSW

    ; 5) Cargar el second-stage bootloader desde almacenamiento externo
    jal   load_second_stage          ; devuelve dirección de carga en $v0

    ; 6) Transferir control al second stage (sin retorno esperado)
    jr    $v0, 0

halt:
    j     halt                       ; nunca debería llegarse acá


; --------------------------------------------------------
; install_vector_table
;   Llena VECTOR_TABLE_COUNT entradas de 4 bytes en
;   VECTOR_TABLE_BASE con la dirección de default_handler.
;   Reemplazar entradas puntuales luego (ej: entrada de TRAP
;   de syscall, IRQ del timer, etc.) según lo necesites.
; --------------------------------------------------------
install_vector_table:
    lci   $s0, $zero, 0xF001         ; $s0 = base de la tabla
    addi  $s1, $zero, 0              ; $s1 = offset actual (bytes)
    lci   $s2, $zero, hi(default_handler)
    ori   $s2, $s2, lo(default_handler)  ; $s2 = &default_handler
    addi  $s3, $zero, VECTOR_TABLE_COUNT ; $s3 = contador de entradas

fill_loop:
    swx   $s2, $s0, $s1              ; tabla[offset] = default_handler
    addi  $s1, $s1, 4
    addi  $s3, $s3, -1
    bne   $s3, $zero, fill_loop

    jr    $ra, 0


; --------------------------------------------------------
; default_handler
;   Handler genérico de excepción/interrupción no configurada.
;   Por ahora sólo retorna. Reemplazar por manejo real una vez
;   definido el Capítulo 8 (Excepciones) del manual.
; --------------------------------------------------------
default_handler:
    ; $ecr / $epc / $esr ya están seteados por el hardware
    ; acá se podría loggear, contar, o hacer panic según ecr
    rft


; --------------------------------------------------------
; load_second_stage
;   Carga el bloque de "second stage" desde el dispositivo de
;   almacenamiento externo (disc) y devuelve su dirección de
;   entrada en $v0.
;
;   NOTA: el Capítulo 9 (Entrada/Salida) del manual está
;   marcado como "PRONTO..." — el layout MMIO del controlador
;   de disco todavía no está especificado formalmente. Este
;   driver es un ESQUELETO con offsets de ejemplo; hay que
;   reemplazarlos cuando definas el registro de control real
;   (probablemente algo tipo STATUS/CMD/LBA/BUFFER/COUNT,
;   estilo controlador simple polling, dado el resto del ISA).
; --------------------------------------------------------
DISC_MMIO_BASE   equ 0xFFFFF000   ; bloque MMIO por defecto (spec 1.4.1)
DISC_REG_STATUS  equ 0x00
DISC_REG_CMD     equ 0x04
DISC_REG_LBA     equ 0x08
DISC_REG_DEST    equ 0x0C         ; dirección RAM destino
DISC_REG_COUNT   equ 0x10         ; cantidad de sectores/bloques
DISC_CMD_READ    equ 0x01
DISC_STATUS_BUSY equ 0x01
DISC_STATUS_ERR  equ 0x02

SECOND_STAGE_LOAD_ADDR equ 0x00001000   ; ejemplo: inicio de User Space
SECOND_STAGE_LBA        equ 1            ; ejemplo: bloque 1 del disco
SECOND_STAGE_BLOCKS      equ 32           ; ejemplo: tamaño a leer

load_second_stage:
    lci   $t0, $zero, hi(DISC_MMIO_BASE)
    ori   $t0, $t0, lo(DISC_MMIO_BASE)   ; $t0 = base MMIO del disco

    lci   $t1, $zero, hi(SECOND_STAGE_LOAD_ADDR)
    ori   $t1, $t1, lo(SECOND_STAGE_LOAD_ADDR)
    sw    $t1, DISC_REG_DEST($t0)        ; destino de carga

    addi  $t2, $zero, SECOND_STAGE_LBA
    sw    $t2, DISC_REG_LBA($t0)         ; bloque inicial

    addi  $t3, $zero, SECOND_STAGE_BLOCKS
    sw    $t3, DISC_REG_COUNT($t0)       ; cantidad de bloques

    addi  $t4, $zero, DISC_CMD_READ
    sw    $t4, DISC_REG_CMD($t0)         ; dispara la lectura

poll_status:
    lw    $t5, DISC_REG_STATUS($t0)
    andi  $t6, $t5, DISC_STATUS_BUSY
    bne   $t6, $zero, poll_status        ; esperar fin de operación

    andi  $t6, $t5, DISC_STATUS_ERR
    beq   $t6, $zero, load_ok
    j     disc_error                     ; error de lectura: panic/reintento

load_ok:
    lci   $v0, $zero, hi(SECOND_STAGE_LOAD_ADDR)
    ori   $v0, $v0, lo(SECOND_STAGE_LOAD_ADDR)
    jr    $ra, 0

disc_error:
    j     disc_error                     ; placeholder: definir manejo de error
