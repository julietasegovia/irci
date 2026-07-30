/* ============================================================
 * rtm32_rom_device.c
 *
 * Modelo del periférico ROM del sistema RTM32.
 *
 * Cumple las reglas de la especificación de arquitectura:
 *   - Base fija en 0xF0000000 (Boot ROM Mapping / Cold Boot Vector).
 *     No es reubicable ni configurable por software ni por --load.
 *   - Tamaño configurable al inicio (parámetro del emulador, --rom).
 *   - Contenido inmutable durante toda la ejecución: no hay
 *     mecanismo arquitectónico para reprogramarla.
 *   - Little-Endian en todos los accesos.
 *   - La alineación (16/32 bits) la valida el bus/CPU antes de
 *     despachar el acceso; este módulo asume que ya llegó alineado.
 *
 * Integración: registrar rom_device_init() en el descriptor de
 * bus del emulador (bus_region_t o equivalente) junto a RAM y MMIO.
 * ============================================================ */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#define ROM_BASE_ADDR   0xF0000000u   /* Fijo por arquitectura. No cambiar. */
#define ROM_MAX_SIZE    (16u * 1024u * 1024u) /* límite razonable de emulador */

typedef struct {
    uint32_t base;      /* siempre ROM_BASE_ADDR */
    uint32_t size;      /* tamaño real cargado, en bytes */
    uint8_t *data;      /* buffer inmutable tras la carga */
    int      loaded;    /* 1 si hay imagen cargada */
} rom_device_t;

/* Excepciones que el módulo puede señalizar al bus/CPU.
 * Ajustar a los códigos reales que use tu manejador de excepciones
 * (Capítulo 8 del manual, aún pendiente de completar). */
typedef enum {
    ROM_OK = 0,
    ROM_ERR_UNMAPPED,     /* dirección fuera de rango de la ROM */
    ROM_ERR_WRITE_DENIED, /* intento de escritura sobre ROM */
} rom_access_status_t;

/* --------------------------------------------------------------
 * Inicialización / carga de imagen
 * -------------------------------------------------------------- */

/* Carga la imagen indicada por 'path' en la ROM. Debe llamarse
 * ANTES de iniciar la secuencia de reset del procesador (según
 * spec: "su contenido se carga al iniciar el emulador"). */
int rom_device_load(rom_device_t *rom, const char *path)
{
    FILE *f = fopen(path, "rb");
    if (!f) {
        fprintf(stderr, "rom: no se pudo abrir '%s'\n", path);
        return -1;
    }

    fseek(f, 0, SEEK_END);
    long fsize = ftell(f);
    fseek(f, 0, SEEK_SET);

    if (fsize <= 0 || (uint32_t)fsize > ROM_MAX_SIZE) {
        fprintf(stderr, "rom: tamaño de imagen inválido (%ld bytes)\n", fsize);
        fclose(f);
        return -1;
    }

    rom->data = malloc((size_t)fsize);
    if (!rom->data) {
        fclose(f);
        return -1;
    }

    if (fread(rom->data, 1, (size_t)fsize, f) != (size_t)fsize) {
        fprintf(stderr, "rom: error de lectura en '%s'\n", path);
        free(rom->data);
        rom->data = NULL;
        fclose(f);
        return -1;
    }
    fclose(f);

    rom->base   = ROM_BASE_ADDR;
    rom->size   = (uint32_t)fsize;
    rom->loaded = 1;
    return 0;
}

void rom_device_destroy(rom_device_t *rom)
{
    if (rom->data) {
        free(rom->data);
        rom->data = NULL;
    }
    rom->loaded = 0;
}

/* --------------------------------------------------------------
 * Acceso a memoria (llamado desde el dispatcher del bus)
 * -------------------------------------------------------------- */

static inline int rom_contains(const rom_device_t *rom, uint32_t addr, uint32_t width)
{
    if (!rom->loaded) return 0;
    if (addr < rom->base) return 0;
    uint64_t end = (uint64_t)addr + width;
    return end <= (uint64_t)rom->base + rom->size;
}

/* Lecturas: Little-Endian explícito, sin asumir el endianness del host. */

rom_access_status_t rom_read8(const rom_device_t *rom, uint32_t addr, uint8_t *out)
{
    if (!rom_contains(rom, addr, 1)) return ROM_ERR_UNMAPPED;
    *out = rom->data[addr - rom->base];
    return ROM_OK;
}

rom_access_status_t rom_read16(const rom_device_t *rom, uint32_t addr, uint16_t *out)
{
    if (!rom_contains(rom, addr, 2)) return ROM_ERR_UNMAPPED;
    uint32_t off = addr - rom->base;
    *out = (uint16_t)(rom->data[off] | (rom->data[off + 1] << 8));
    return ROM_OK;
}

rom_access_status_t rom_read32(const rom_device_t *rom, uint32_t addr, uint32_t *out)
{
    if (!rom_contains(rom, addr, 4)) return ROM_ERR_UNMAPPED;
    uint32_t off = addr - rom->base;
    *out = (uint32_t)rom->data[off]
         | ((uint32_t)rom->data[off + 1] << 8)
         | ((uint32_t)rom->data[off + 2] << 16)
         | ((uint32_t)rom->data[off + 3] << 24);
    return ROM_OK;
}

/* Escrituras: la arquitectura no define reprogramación por software.
 * Se señaliza como acceso denegado; el bus/CPU decide si eso se
 * traduce en una excepción de acceso inválido. */

rom_access_status_t rom_write8(rom_device_t *rom, uint32_t addr, uint8_t val)
{
    (void)val;
    if (!rom_contains(rom, addr, 1)) return ROM_ERR_UNMAPPED;
    return ROM_ERR_WRITE_DENIED;
}

rom_access_status_t rom_write16(rom_device_t *rom, uint32_t addr, uint16_t val)
{
    (void)val;
    if (!rom_contains(rom, addr, 2)) return ROM_ERR_UNMAPPED;
    return ROM_ERR_WRITE_DENIED;
}

rom_access_status_t rom_write32(rom_device_t *rom, uint32_t addr, uint32_t val)
{
    (void)val;
    if (!rom_contains(rom, addr, 4)) return ROM_ERR_UNMAPPED;
    return ROM_ERR_WRITE_DENIED;
}

/* --------------------------------------------------------------
 * Ejemplo de integración con el bus (adaptar a tu dispatcher real)
 * -------------------------------------------------------------- */
#if 0
bus_region_t rom_region = {
    .base    = ROM_BASE_ADDR,
    .limit   = ROM_BASE_ADDR + rom.size,  /* calcular tras rom_device_load() */
    .ctx     = &rom,
    .read8   = (bus_read8_fn)rom_read8,
    .read16  = (bus_read16_fn)rom_read16,
    .read32  = (bus_read32_fn)rom_read32,
    .write8  = (bus_write8_fn)rom_write8,
    .write16 = (bus_write16_fn)rom_write16,
    .write32 = (bus_write32_fn)rom_write32,
};
bus_register_region(&system_bus, &rom_region);
#endif
