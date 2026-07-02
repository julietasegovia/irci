# 1. ADD
## Descripción
Sumar los contenidos de dos registros y guardar el resultado en un tercer registro
## Instrucctions:
> ADD r1, r2, r3
## Precondiciones: 
Setear los registros que quiero sumar con sus valores arbitrarios
> set pc 0 s r2 1 s r3 2
## Code
- Opcode : 00000
- rs : 00010
- rt : 00011
- rd : 00001
- aux : 00000
- funct : 011100 


Binario: 0000 0000 1000 0110 0001 0000 0001 1100

Hexa:    0     0     8     6     1     0     1     C

> s [0x0] 0x0086101C 00000 opcode 00010 $2 00011 $3 00001 $1 000000 aux funct 011100

## Postcondiciones: 
- r1 = 0x00000000
- r2 = 0x00000001
- r3 = 0x00000002

1 + 2 = 3 = 0x00000003

## Conclusiones:

La operacion funciona, suma efectivamente a r2 con r3 y lo guarda en r1

# 2. ADDI

## Descripción

Sumar el contenido de un registro con un valor inmediato con signo y guardar el resultado en un segundo registro.

## Instrucctions:

> ADDI r1, r2, imm

## Precondiciones: 

Setear el registro que quiero sumar con su valor arbitrario y posicionar el PC.

> set pc 0 s r2 6

## Code

- Opcode : 00001

- rs : 00010

- rt : 00001

- imm : 00000000000001100

Binario: 0000 1000 1000 0010 0000 0000 0000 1010

Hexa:    0    8    8    2    0    0    0    A

> s [0x0] 0x0882000A 00001 opcode 00010 $2 00001 $1 00000000000001010 imm


## Postcondiciones: 

- r2 = 0x00000006

- imm = 0x0000000C

6 + 12 = 0x00000012

## Conclusiones:

La operación funciona, suma efectivamente el contenido de r2 con el valor inmediato imm y guarda el resultado en r1.

# 3. AND

## Descripción
Realizar una operación lógica AND bit a bit entre los contenidos de dos registros y guardar el resultado en un tercer registro.

## Instrucctions:
> AND r1, r2, r3

## Precondiciones: 
Setear los registros que quiero operar con sus valores arbitrarios
> set pc 0 s r2 0x0000FFFF s r3 0x000000FF

## Code
- Opcode : 00000
- rs : 00010
- rt : 00011
- rd : 00001
- aux : 00000
- funct : 011101

Binario: 0000 0000 1000 0110 0001 0000 0001 1101

Hexa:    0     0     8     6     1     0     1     D

> s [0x0] 0x0086101D 00000 opcode 00010 $2 00011 $3 00001 $1 000000 aux funct 011101

## Postcondiciones: 
- r2 = 0x0000FFFF
- r3 = 0x000000FF

0x0000FFFF & 0x000000FF = 0x000000FF

## Conclusiones:
La operación funciona, realiza efectivamente el AND bit a bit entre r2 y r3, guardando el resultado filtrado en r1.

# 4. ANDI

## Descripción
Realizar una operación lógica AND bit a bit entre el contenido de un registro y un valor inmediato extendido con ceros, guardando el resultado en un segundo registro.

## Instrucctions:
> ANDI r1, r2, ims

## Precondiciones: 
Setear el registro base con una máscara o valor arbitrario para evaluar la operación lógica y posicionar el PC.
> set pc 0 s r2 0x0000FFFF

## Code
- Opcode : 00100
- rs : 00010
- rt : 00001
- ims : 0000000011111111  (Valor hexadecimal: 0x00FF, con h=0 para parte inferior)

Binario: 0010 0000 1000 0100 0000 0000 1111 1111

Hexa:    2    0    8    4    0    0    F    F

> s [0x0] 0x208400FF 00100 opcode 00010 $2 00001 $1 0000000011111111 ims

## Postcondiciones: 
- r2 = 0x0000FFFF
- ims = 0x000000FF

0x0000FFFF & 0x000000FF = 0x000000FF

## Conclusiones:
La operación funciona, realiza efectivamente el AND bit a bit entre r2 y el inmediato ims, guardando el resultado filtrado en r1.

# 5. OR

## Descripción
Realizar una operación lógica OR bit a bit entre los contenidos de dos registros y guardar el resultado en un tercer registro.

## Instrucctions:
> OR r1, r2, r3

## Precondiciones: 
Setear los registros que quiero operar con sus valores arbitrarios
> set pc 0 s r2 0x55550000 s r3 0x00005555

## Code
- Opcode : 00000
- rs : 00010
- rt : 00011
- rd : 00001
- aux : 00000
- funct : 011110

Binario: 0000 0000 1000 0110 0001 0000 0001 1110

Hexa:    0     0     8     6     1     0     1     E

> s [0x0] 0x0086101E 00000 opcode 00010 $2 00011 $3 00001 $1 000000 aux funct 011110

## Postcondiciones: 
- r2 = 0x55550000
- r3 = 0x00005555

0x55550000 | 0x00005555 = 0x55555555

## Conclusiones:
La operación funciona, combina efectivamente mediante un OR lógico los bits de r2 con los de r3 y almacena la unión en r1.

# 6. ORI

## Descripción
Realizar una operación lógica OR bit a bit entre el contenido de un registro y un valor inmediato extendido con ceros, guardando el resultado en un segundo registro.

## Instrucctions:
> ORI r1, r2, ims

## Precondiciones: 
Setear el registro base con el valor que se desea alterar mediante la combinación de bits y posicionar el PC.
> set pc 0 s r2 0x55550000

## Code
- Opcode : 00101
- rs : 00010
- rt : 00001
- ims : 0101010101010101  (Valor hexadecimal: 0x5555, con h=0)

Binario: 0010 1000 1000 0101 0101 0101 0101 0101

Hexa:    2    8    8    5    5    5    5    5

> s [0x0] 0x28855555 00101 opcode 00010 $2 00001 $1 0101010101010101 ims

## Postcondiciones: 
- r2 = 0x55550000
- ims = 0x00005555

0x55550000 | 0x00005555 = 0x55555555

## Conclusiones:
La operación funciona, combina efectivamente mediante un OR lógico los bits de r2 con los del inmediato ims y almacena la unión en r1.


# 7. XOR

## Descripción
Realizar una operación lógica XOR (OR exclusivo) bit a bit entre los contenidos de dos registros y guardar el resultado en un tercer registro.

## Instrucctions:
> XOR r1, r2, r3

## Precondiciones: 
Setear los registros que quiero operar con sus valores arbitrarios
> set pc 0 s r2 0xAA55AA55 s r3 0x000000FF

## Code
- Opcode : 00000
- rs : 00010
- rt : 00011
- rd : 00001
- aux : 00000
- funct : 011111

Binario: 0000 0000 1000 0110 0001 0000 0001 1111

Hexa:    0     0     8     6     1     0     1     F

> s [0x0] 0x0086101F 00000 opcode 00010 $2 00011 $3 00001 $1 000000 aux funct 011111

## Postcondiciones: 
- r2 = 0xAA55AA55
- r3 = 0x000000FF

0xAA55AA55 ^ 0x000000FF = 0xAA55A9AA

## Conclusiones:
La operación funciona, aplica efectivamente el XOR bit a bit entre r2 y r3, invirtiendo los bits correspondientes y guardando el nuevo patrón en r1.

# 8. XORI

## Descripción
Realizar una operación lógica XOR (OR exclusivo) bit a bit entre el contenido de un registro y un valor inmediato extendido con ceros, guardando el resultado en un segundo registro.

## Instrucctions:
> XORI r1, r2, ims

## Precondiciones: 
Setear el registro base con un valor arbitrario cuyos bits se deseen invertir o comparar y posicionar el PC.
> set pc 0 s r2 0xAA55AA55

## Code
- Opcode : 00110
- rs : 00010
- rt : 00001
- ims : 0000000011111111  (Valor hexadecimal: 0x00FF, con h=0)

Binario: 0011 0000 1000 0100 0000 0000 1111 1111

Hexa:    3    0    8    4    0    0    F    F

> s [0x0] 0x308400FF 00110 opcode 00010 $2 00001 $1 0000000011111111 ims

## Postcondiciones: 
- r2 = 0xAA55AA55
- ims = 0x000000FF

0xAA55AA55 ^ 0x000000FF = 0xAA55A9AA

## Conclusiones:
La operación funciona, aplica efectivamente el XOR bit a bit entre r2 y el inmediato ims, invirtiendo los bits correspondientes y guardando el nuevo patrón en r1.


# 9. NOR

## Descripción
Realizar una operación lógica NOR (OR negado) bit a bit entre los contenidos de dos registros y guardar el resultado en un tercer registro.

## Instrucctions:
> NOR r1, r2, r3

## Precondiciones: 
Setear los registros que quiero operar con sus valores arbitrarios
> set pc 0 s r2 0x55555555 s r3 0x00000000

## Code
- Opcode : 00000
- rs : 00010
- rt : 00011
- rd : 00001
- aux : 00000
- funct : 100000

Binario: 0000 0000 1000 0110 0001 0000 0010 0000

Hexa:    0     0     8     6     1     0     2     0

> s [0x0] 0x00861020 00000 opcode 00010 $2 00011 $3 00001 $1 000000 aux funct 100000

## Postcondiciones: 
- r2 = 0x55555555
- r3 = 0x00000000

~(0x55555555 | 0x00000000) = ~0x55555555 = 0xAAAAAAAA

## Conclusiones:
La operación funciona, aplica efectivamente el NOR bit a bit entre r2 y r3, negando el resultado del OR y guardando el patrón complementario en r1.

# 10. SUB
## Descripcion
Operar una resta entre r2 y r3 y almacenarla en r1

## Instructions
> SUB r1, r2, r3

## Precondiciones
Setear los registros que quiero restar con sus valores arbitrarios

> set pc 0 r2 0x00000005 r3 0x00000002

## Code
- Opcode : 000000
- rs : 00010
- rt : 00011
- rd : 00001
- aux : 000000
- funct : 100001

Binario: 0000 0000 1000 0110 0001 0000 0010 0001

Hexa: 0 0 8 6 1 0 2 1

> s [0x0] 0x00861021 00000 opcode 00010 $2 00011 $3 00001 $1 000000 aux funct 100001

## Postcondiciones
- r2 = 0x00000005
- r3 = 0x00000002

5 - 2 = 3 = 0x00000003

## Conclusiones

La operación funciona, resta efectivamente r3 de r2 y lo guarda en r1.

# 10.5 SUB (a valores negativos) 

## Descripcion
Restar los contenidos de dos registros cuando el resultado es negativo, demostrando el comportamiento en complemento a dos.

## Instructions
> SUB r1, r2, r3

## Precondiciones
Setear los registros que quiero restar con sus valores arbitrarios

> set pc 0 s r2 0x00000003 s r3 0x00000007

## Code
- Opcode : 00000
- rs : 00010
- rt : 00011
- rd : 00001
- aux : 000000
- funct : 100001

Binario: 0000 0000 1000 0110 0001 0000 0010 0001

Hexa: 0 0 8 6 1 0 2 1

>s [0x0] 0x00861021 00000 opcode 00010 $2 00011 $3 00001 $1 000000 aux funct 100001
## Postcondiciones
- r2 = 0x00000003
- r3 = 0x00000007

3 - 7 = -4 = 0xFFFFFFFC (en complemento a dos)

## Conclucion
La operación funciona correctamente con números negativos, representando el resultado en complemento a dos. La resta de r3 a r2 se realiza mediante la suma del complemento a dos de r3, produciendo el resultado esperado de -4 (0xFFFFFFFC).

# 11. SLT

## Descripcion

Comparar dos registros con signo y establecer el registro destino a 1 si el primer registro es menor que el segundo, o 0 en caso contrario.

## Instructions

> SLT r1, r2, r3

## Precondiciones

Setear los registros que quiero comparar con sus valores arbitrarios (con signo)

> set pc 0 s r2 0x00000003 s r3 0x00000007

## Code

- Opcode : 00000
- rs : 00010
- rt : 00011
- rd : 00001
- aux : 000000
- funct : 100001

Binario: 0000 0000 1000 0110 0001 0000 0010 0011

Hexa: 0 0 8 6 1 0 2 3

> s [0x0] 0x00861023 00000 opcode 00010 $2 00011 $3 00001 $1 000000 aux funct 100011

## Postcondiciones
- r2 = 0x00000003
- r3 = 0x00000007

3 < 7 = Verdadero, por lo tanto r1 = 0x00000001

## Conclusion

SLT funciona para signed.
La operación SLT considera correctamente el signo en complemento a dos. -1 (0xFFFFFFFF) es menor que 1 (0x00000001), por lo tanto el resultado es 1.

# 12. SLTU

## Descripcion
Comparar dos registros sin signo y establecer el registro destino a 1 si el primero es menor que el segundo, si no 0

## Instructios
> SLTU r1, r2, r3

## Precondiciones
Setear los registros que quiero comparar con sus valores arbitrarios (sin signo)

>set pc 0 s r2 0x00000003 s r3 0x00000007

## Code
- Opcode : 00000

- rs : 00010

- rt : 00011

- rd : 00001

- aux : 00000

- funct : 100011

Binario: 0000 0000 1000 0110 0001 0000 0010 0011

Hexa: 0 0 8 6 1 0 2 3

> s [0x0] 0x00861023 00000 opcode 00010 $2 00011 $3 00001 $1 000000 aux funct 100011

## Postcondiciones
- r2 = 0x00000003

- r3 = 0x00000007

3 < 7 = Verdadero, por lo tanto r1 = 0x00000001

## Conclusiones:
La operación funciona, compara correctamente los registros sin signo y guarda 1 en r1 si r2 < r3, o 0 en caso contrario.

# 13. SLTI

## Descripción
Comparar el contenido de un registro con signo con un valor inmediato y establecer el registro destino a 1 si el registro es menor que el inmediato, o 0 en caso contrario.

## Instrucctions:
> SLTI r1, r2, imm

## Precondiciones: 
Setear el registro base con un valor con signo y posicionar el PC.
> set pc 0 s r2 0x00000003

## Code
- Opcode : 00111
- rs : 00010
- rt : 00001
- imm : 0000000000000111

Binario: 0011 1000 1000 0010 0000 0000 0000 0111

Hexa:    3    8    8    2    0    0    0    7

> s [0x0] 0x38820007 00111 opcode 00010 $2 00001 $1 0000000000000111 imm

## Postcondiciones: 
- r2 = 0x00000003
- imm = 0x00000007

3 < 7 = Verdadero, por lo tanto r1 = 0x00000001

## Conclusiones:
La operación funciona, compara correctamente el registro con signo con el inmediato y guarda 1 en r1 si r2 < imm, o 0 en caso contrario.

# 14. SLTIU

## Descripción
Comparar el contenido de un registro sin signo con un valor inmediato y establecer el registro destino a 1 si el registro es menor que el inmediato, o 0 en caso contrario.

## Instrucctions:
> SLTIU r1, r2, imm

## Precondiciones: 
Setear el registro base con un valor sin signo y posicionar el PC.
> set pc 0 s r2 0xFFFFFFFF

## Code
- Opcode : 01000
- rs : 00010
- rt : 00001
- imm : 0000000000000001

Binario: 0100 0000 1000 0010 0000 0000 0000 0001

Hexa:    4    0    8    2    0    0    0    1

> s [0x0] 0x40820001 01000 opcode 00010 $2 00001 $1 0000000000000001 imm

## Postcondiciones: 
- r2 = 0xFFFFFFFF (4,294,967,295 en sin signo)
- imm = 0x00000001 (1)

4,294,967,295 < 1 = Falso, por lo tanto r1 = 0x00000000

## Conclusiones:
La operación SLTIU interpreta el registro como sin signo, por lo que 0xFFFFFFFF es considerado un número muy grande, no menor que 1. Guarda 0 en r1.

# 15. SLL

## Descripción
Desplazar lógicamente a la izquierda los bits de un registro por una cantidad especificada por un valor inmediato, llenando los bits menos significativos con ceros.

## Instrucctions:
> SLL r1, r2, shamt

## Precondiciones: 
Setear el registro base con un valor arbitrario y posicionar el PC.
> set pc 0 s r2 0x00000001

## Code
- Opcode : 00000
- rs : 00000 (no utilizado)
- rt : 00010
- rd : 00001
- shamt : 00101
- funct : 000000

Binario: 0000 0000 0001 0000 1000 1010 0000 0000

Hexa:    0    0    1    0    8    A    0    0

> s [0x0] 0x00108A00 00000 opcode 00000 $0 00010 $2 00001 $1 00101 shamt 000000 funct

## Postcondiciones: 
- r2 = 0x00000001
- shamt = 5 (desplazamiento de 5 bits)

1 << 5 = 32 = 0x00000020

## Conclusiones:
La operación funciona, desplaza lógicamente a la izquierda el contenido de r2 por 5 posiciones, llenando con ceros y guardando el resultado en r1.

# 16. SRL

## Descripción
Desplazar lógicamente a la derecha los bits de un registro por una cantidad especificada por un valor inmediato, llenando los bits más significativos con ceros.

## Instrucctions:
> SRL r1, r2, shamt

## Precondiciones: 
Setear el registro base con un valor arbitrario y posicionar el PC.
> set pc 0 s r2 0x00000020

## Code
- Opcode : 00000
- rs : 00000 (no utilizado)
- rt : 00010
- rd : 00001
- shamt : 00101
- funct : 000010

Binario: 0000 0000 0001 0000 1000 1010 0000 0010

Hexa:    0    0    1    0    8    A    0    2

> s [0x0] 0x00108A02 00000 opcode 00000 $0 00010 $2 00001 $1 00101 shamt 000010 funct

## Postcondiciones: 
- r2 = 0x00000020
- shamt = 5 (desplazamiento de 5 bits)

32 >> 5 = 1 = 0x00000001

## Conclusiones:
La operación funciona, desplaza lógicamente a la derecha el contenido de r2 por 5 posiciones, llenando con ceros y guardando el resultado en r1.

# 17. SRA

## Descripción
Desplazar aritméticamente a la derecha los bits de un registro por una cantidad especificada por un valor inmediato, preservando el bit de signo (extensión de signo).

## Instrucctions:
> SRA r1, r2, shamt

## Precondiciones: 
Setear el registro base con un valor negativo y posicionar el PC.
> set pc 0 s r2 0xFFFFFFF0

## Code
- Opcode : 00000
- rs : 00000 (no utilizado)
- rt : 00010
- rd : 00001
- shamt : 00010
- funct : 000011

Binario: 0000 0000 0001 0000 1000 0100 0000 0011

Hexa:    0    0    1    0    8    4    0    3

> s [0x0] 0x00108403 00000 opcode 00000 $0 00010 $2 00001 $1 00010 shamt 000011 funct

## Postcondiciones: 
- r2 = 0xFFFFFFF0 (-16 en complemento a dos)
- shamt = 2 (desplazamiento de 2 bits)

-16 >> 2 = -4 = 0xFFFFFFFC

## Conclusiones:
La operación funciona, desplaza aritméticamente a la derecha el contenido de r2 por 2 posiciones, preservando el bit de signo (extensión de signo) y guardando el resultado en r1.

# 18. SLLR

## Descripción
Desplazar lógicamente a la izquierda los bits de un registro por una cantidad especificada por el contenido de otro registro.

## Instrucctions:
> SLLR r1, r2, r3

## Precondiciones: 
Setear los registros con un valor base y una cantidad de desplazamiento.
> set pc 0 s r2 0x00000001 s r3 0x00000005

## Code
- Opcode : 00000
- rs : 00011
- rt : 00010
- rd : 00001
- aux : 00000
- funct : 001000

Binario: 0000 0000 1100 0010 0001 0000 0010 0000

Hexa:    0    0    C    2    1    0    2    0

> s [0x0] 0x00C21020 00000 opcode 00011 $3 00010 $2 00001 $1 000000 aux 001000 funct

## Postcondiciones: 
- r2 = 0x00000001
- r3 = 0x00000005

1 << 5 = 32 = 0x00000020

## Conclusiones:
La operación funciona, desplaza lógicamente a la izquierda r2 por la cantidad especificada en r3, llenando con ceros y guardando el resultado en r1.

# 19. SRLR

## Descripción
Desplazar lógicamente a la derecha los bits de un registro por una cantidad especificada por el contenido de otro registro.

## Instrucctions:
> SRLR r1, r2, r3

## Precondiciones: 
Setear los registros con un valor base y una cantidad de desplazamiento.
> set pc 0 s r2 0x00000020 s r3 0x00000005

## Code
- Opcode : 00000
- rs : 00011
- rt : 00010
- rd : 00001
- aux : 00000
- funct : 001001

Binario: 0000 0000 1100 0010 0001 0000 0010 0100

Hexa:    0    0    C    2    1    0    2    4

> s [0x0] 0x00C21024 00000 opcode 00011 $3 00010 $2 00001 $1 000000 aux 001001 funct

## Postcondiciones: 
- r2 = 0x00000020
- r3 = 0x00000005

32 >> 5 = 1 = 0x00000001

## Conclusiones:
La operación funciona, desplaza lógicamente a la derecha r2 por la cantidad especificada en r3, llenando con ceros y guardando el resultado en r1.

# 20. SRAR

## Descripción
Desplazar aritméticamente a la derecha los bits de un registro por una cantidad especificada por el contenido de otro registro, preservando el bit de signo.

## Instrucctions:
> SRAR r1, r2, r3

## Precondiciones: 
Setear los registros con un valor negativo y una cantidad de desplazamiento.
> set pc 0 s r2 0xFFFFFFF0 s r3 0x00000002

## Code
- Opcode : 00000
- rs : 00011
- rt : 00010
- rd : 00001
- aux : 00000
- funct : 001010

Binario: 0000 0000 1100 0010 0001 0000 0010 1000

Hexa:    0    0    C    2    1    0    2    8

> s [0x0] 0x00C21028 00000 opcode 00011 $3 00010 $2 00001 $1 000000 aux 001010 funct

## Postcondiciones: 
- r2 = 0xFFFFFFF0 (-16 en complemento a dos)
- r3 = 0x00000002

-16 >> 2 = -4 = 0xFFFFFFFC

## Conclusiones:
La operación funciona, desplaza aritméticamente a la derecha r2 por la cantidad especificada en r3, preservando el bit de signo mediante extensión de signo y guardando el resultado en r1.

# 21. LW

## Descripción
Cargar una palabra (32 bits) desde la memoria a un registro, utilizando una dirección base y un offset inmediato.

## Instrucctions:
> LW r1, offset(r2)

## Precondiciones: 
Setear el registro base con una dirección de memoria válida y posicionar el PC.
> set pc 0 s r2 0x00001000

## Code
- Opcode : 10001
- rs : 00010
- rt : 00001
- offset : 0000000000000100

Binario: 1000 1000 1000 0010 0000 0000 0000 0100

Hexa:    8    8    8    2    0    0    0    4

> s [0x0] 0x88820004 10001 opcode 00010 $2 00001 $1 0000000000000100 offset

## Precondiciones de memoria:
> s [0x1004] 0x12345678

## Postcondiciones: 
- r2 = 0x00001000
- offset = 0x00000004
- Memoria[0x1004] = 0x12345678

r1 = Memoria[r2 + offset] = 0x12345678

## Conclusiones:
La operación funciona, carga correctamente la palabra desde la dirección de memoria calculada (r2 + offset) y la guarda en r1.

# 22. SW 

## Descripción
Guardar una palabra (32 bits) desde un registro a la memoria, utilizando una dirección base y un offset inmediato.

## Instrucctions:
> SW r1, offset(r2)

## Precondiciones: 
Setear el registro base con una dirección de memoria válida y el registro fuente con un valor a guardar.
> set pc 0 s r2 0x00001000 s r1 0x12345678

## Code
- Opcode : 10010
- rs : 00010
- rt : 00001
- offset : 0000000000000100

Binario: 1001 0000 1000 0010 0000 0000 0000 0100

Hexa:    9    0    8    2    0    0    0    4

> s [0x0] 0x90820004 10010 opcode 00010 $2 00001 $1 0000000000000100 offset

## Postcondiciones: 
- r1 = 0x12345678
- r2 = 0x00001000
- offset = 0x00000004

Memoria[0x1004] = 0x12345678

## Conclusiones:
La operación funciona, guarda correctamente la palabra de r1 en la dirección de memoria calculada (r2 + offset).

# 23. J

## Descripción
Saltar incondicionalmente a una dirección objetivo dentro del espacio de direcciones.

## Instrucctions:
> J target

## Precondiciones: 
Posicionar el PC y cargar la instrucción de salto.
> set pc 0

## Code
- Opcode : 00010
- target : 00000000000000000000010000

Binario: 0000 1000 0000 0000 0000 0000 0001 0000

Hexa:    0    8    0    0    0    0    1    0

> s [0x0] 0x08000010 00010 opcode 00000000000000000000010000 target

## Postcondiciones: 
- PC = 0x00000010 (dirección de destino)

## Conclusiones:
La operación funciona, salta incondicionalmente a la dirección target, actualizando el PC.

# 24. JR

## Descripción
Saltar incondicionalmente a la dirección contenida en un registro.

## Instrucctions:
> JR r1

## Precondiciones: 
Setear el registro con la dirección de destino.
> set pc 0 s r1 0x00001000

## Code
- Opcode : 00000
- rs : 00001
- rt : 00000 (no utilizado)
- rd : 00000 (no utilizado)
- aux : 00000
- funct : 001000

Binario: 0000 0000 0000 1000 0000 0000 0010 0000

Hexa:    0    0    0    8    0    0    2    0

> s [0x0] 0x00080020 00000 opcode 00001 $1 00000 $0 00000 $0 000000 aux 001000 funct

## Postcondiciones: 
- r1 = 0x00001000
- PC = 0x00001000

## Conclusiones:
La operación funciona, salta a la dirección almacenada en r1, actualizando el PC.

# 25. JAL

## Descripción
Saltar a una dirección objetivo y guardar la dirección de retorno (PC + 4) en el registro r31.

## Instrucctions:
> JAL target

## Precondiciones: 
Posicionar el PC.
> set pc 0

## Code
- Opcode : 00011
- target : 00000000000000000000010000

Binario: 0000 1100 0000 0000 0000 0000 0001 0000

Hexa:    0    C    0    0    0    0    1    0

> s [0x0] 0x0C000010 00011 opcode 00000000000000000000010000 target

## Postcondiciones: 
- PC = 0x00000010 (dirección de destino)
- r31 = 0x00000004 (PC + 4, dirección de retorno)

## Conclusiones:
La operación funciona, salta a la dirección target y guarda la dirección de retorno en r31 para poder regresar después de la subrutina.

# 26. JALR

## Descripción
Saltar a la dirección contenida en un registro y guardar la dirección de retorno (PC + 4) en otro registro.

## Instrucctions:
> JALR r1, r2

## Precondiciones: 
Setear el registro con la dirección de destino.
> set pc 0 s r2 0x00001000

## Code
- Opcode : 00000
- rs : 00010
- rt : 00000 (no utilizado)
- rd : 00001
- aux : 00000
- funct : 001001

Binario: 0000 0000 1000 0000 0001 0000 0010 0100

Hexa:    0    0    8    0    1    0    2    4

> s [0x0] 0x00801024 00000 opcode 00010 $2 00000 $0 00001 $1 000000 aux 001001 funct

## Postcondiciones: 
- r2 = 0x00001000
- PC = 0x00001000
- r1 = 0x00000004 (PC + 4, dirección de retorno)

## Conclusiones:
La operación funciona, salta a la dirección en r2 y guarda la dirección de retorno en r1 para poder regresar después de la subrutina.

# 27. LUI 

## Descripción
Cargar un valor inmediato de 16 bits en los bits superiores (16-31) de un registro, llenando los bits inferiores con ceros.

## Instrucctions:
> LUI r1, imm

## Precondiciones: 
Posicionar el PC.
> set pc 0

## Code
- Opcode : 00100
- rs : 00000 (no utilizado)
- rt : 00001
- imm : 0000000000000101

Binario: 0010 0000 0000 0001 0000 0000 0000 0101

Hexa:    2    0    0    1    0    0    0    5

> s [0x0] 0x20010005 00100 opcode 00000 $0 00001 $1 0000000000000101 imm

## Postcondiciones: 
- imm = 0x00000005
- r1 = imm << 16 = 0x00050000

## Conclusiones:
La operación funciona, carga el valor inmediato en los bits superiores del registro, llenando los bits inferiores con ceros.

# 28. ANDIH

## Descripción
Realizar una operación lógica AND bit a bit entre el contenido de un registro y un valor inmediato colocado en la parte alta (bits superiores), extendido con ceros.

## Instrucctions:
> ANDIH r1, r2, ims

## Precondiciones: 
Setear el registro base con una máscara y posicionar el PC.
> set pc 0 s r2 0xFFFF0000

## Code
- Opcode : 00101
- rs : 00010
- rt : 00001
- ims : 0000000011111111  (Valor hexadecimal: 0x00FF, colocado en parte alta)

Binario: 0010 1000 1000 0100 0000 0000 1111 1111

Hexa:    2    8    8    4    0    0    F    F

> s [0x0] 0x288400FF 00101 opcode 00010 $2 00001 $1 0000000011111111 ims

## Postcondiciones: 
- r2 = 0xFFFF0000
- ims = 0x00FF0000 (colocado en parte alta)

0xFFFF0000 & 0x00FF0000 = 0x00FF0000

## Conclusiones:
La operación funciona, realiza AND bit a bit entre r2 y el inmediato ims colocado en la parte alta, guardando el resultado filtrado en r1.

# 29. ORIH

## Descripción
Realizar una operación lógica OR bit a bit entre el contenido de un registro y un valor inmediato colocado en la parte alta (bits superiores), extendido con ceros.

## Instrucctions:
> ORIH r1, r2, ims

## Precondiciones: 
Setear el registro base con un valor y posicionar el PC.
> set pc 0 s r2 0x00000000

## Code
- Opcode : 00110
- rs : 00010
- rt : 00001
- ims : 0000000011111111  (Valor hexadecimal: 0x00FF, colocado en parte alta)

Binario: 0011 0000 1000 0100 0000 0000 1111 1111

Hexa:    3    0    8    4    0    0    F    F

> s [0x0] 0x308400FF 00110 opcode 00010 $2 00001 $1 0000000011111111 ims

## Postcondiciones: 
- r2 = 0x00000000
- ims = 0x00FF0000 (colocado en parte alta)

0x00000000 | 0x00FF0000 = 0x00FF0000

## Conclusiones:
La operación funciona, realiza OR bit a bit entre r2 y el inmediato ims colocado en la parte alta, combinando los bits y guardando el resultado en r1.

# 30. XORIH

## Descripción
Realizar una operación lógica XOR (OR exclusivo) bit a bit entre el contenido de un registro y un valor inmediato colocado en la parte alta (bits superiores), extendido con ceros.

## Instrucctions:
> XORIH r1, r2, ims

## Precondiciones: 
Setear el registro base con un valor arbitrario y posicionar el PC.
> set pc 0 s r2 0xAA550000

## Code
- Opcode : 00111
- rs : 00010
- rt : 00001
- ims : 0000000011111111  (Valor hexadecimal: 0x00FF, colocado en parte alta)

Binario: 0011 1000 1000 0100 0000 0000 1111 1111

Hexa:    3    8    8    4    0    0    F    F

> s [0x0] 0x388400FF 00111 opcode 00010 $2 00001 $1 0000000011111111 ims

## Postcondiciones: 
- r2 = 0xAA550000
- ims = 0x00FF0000 (colocado en parte alta)

0xAA550000 ^ 0x00FF0000 = 0xAAAA0000

## Conclusiones:
La operación funciona, aplica XOR bit a bit entre r2 y el inmediato ims colocado en la parte alta, invirtiendo los bits correspondientes y guardando el nuevo patrón en r1.

# 31. BEQ

## Descripción
Comparar dos registros y saltar a una dirección objetivo si son iguales. El salto es relativo al PC (PC + 4 + (offset << 2)).

## Instrucctions:
> BEQ r1, r2, offset

## Precondiciones: 
Setear los registros con valores iguales y posicionar el PC.
> set pc 0 s r1 0x00000005 s r2 0x00000005

## Code
- Opcode : 00100
- rs : 00001
- rt : 00010
- offset : 0000000000000010

Binario: 0010 0000 1000 0100 0000 0000 0000 1010

Hexa:    2    0    8    4    0    0    0    A

> s [0x0] 0x2084000A 00100 opcode 00001 $1 00010 $2 0000000000000010 offset

## Postcondiciones: 
- r1 = 0x00000005
- r2 = 0x00000005
- offset = 0x00000010 (desplazado 2 bits: 0x00000010 << 2 = 0x00000040)

r1 == r2 (5 == 5) = Verdadero
PC = PC + 4 + (offset << 2) = 0x00000000 + 4 + 0x40 = 0x00000044

## Conclusiones:
La operación funciona, compara r1 y r2, y al ser iguales, salta a la dirección calculada (PC + 4 + offset*4).

# 32. BEQ (caso falso)

## Descripción
Comparar dos registros y saltar a una dirección objetivo si son iguales. Demostración del caso donde no se cumple la condición.

## Instrucctions:
> BEQ r1, r2, offset

## Precondiciones: 
Setear los registros con valores diferentes y posicionar el PC.
> set pc 0 s r1 0x00000005 s r2 0x00000007

## Code
- Opcode : 00100
- rs : 00001
- rt : 00010
- offset : 0000000000000010

Binario: 0010 0000 1000 0100 0000 0000 0000 1010

Hexa:    2    0    8    4    0    0    0    A

> s [0x0] 0x2084000A 00100 opcode 00001 $1 00010 $2 0000000000000010 offset

## Postcondiciones: 
- r1 = 0x00000005
- r2 = 0x00000007
- offset = 0x00000010

r1 == r2 (5 == 7) = Falso
PC = PC + 4 = 0x00000004 (ejecuta la siguiente instrucción)

## Conclusiones:
La operación funciona correctamente, al no ser iguales los registros, no realiza el salto y continúa con la siguiente instrucción.

# 33. BNE

## Descripción
Comparar dos registros y saltar a una dirección objetivo si son diferentes. El salto es relativo al PC (PC + 4 + (offset << 2)).

## Instrucctions:
> BNE r1, r2, offset

## Precondiciones: 
Setear los registros con valores diferentes y posicionar el PC.
> set pc 0 s r1 0x00000005 s r2 0x00000007

## Code
- Opcode : 00101
- rs : 00001
- rt : 00010
- offset : 0000000000000010

Binario: 0010 1000 1000 0100 0000 0000 0000 1010

Hexa:    2    8    8    4    0    0    0    A

> s [0x0] 0x2884000A 00101 opcode 00001 $1 00010 $2 0000000000000010 offset

## Postcondiciones: 
- r1 = 0x00000005
- r2 = 0x00000007
- offset = 0x00000010 (desplazado 2 bits: 0x00000010 << 2 = 0x00000040)

r1 != r2 (5 != 7) = Verdadero
PC = PC + 4 + (offset << 2) = 0x00000000 + 4 + 0x40 = 0x00000044

## Conclusiones:
La operación funciona, compara r1 y r2, y al ser diferentes, salta a la dirección calculada (PC + 4 + offset*4).

# 34. BNE (caso falso)

## Descripción
Comparar dos registros y saltar a una dirección objetivo si son diferentes. Demostración del caso donde no se cumple la condición.

## Instrucctions:
> BNE r1, r2, offset

## Precondiciones: 
Setear los registros con valores iguales y posicionar el PC.
> set pc 0 s r1 0x00000005 s r2 0x00000005

## Code
- Opcode : 00101
- rs : 00001
- rt : 00010
- offset : 0000000000000010

Binario: 0010 1000 1000 0100 0000 0000 0000 1010

Hexa:    2    8    8    4    0    0    0    A

> s [0x0] 0x2884000A 00101 opcode 00001 $1 00010 $2 0000000000000010 offset

## Postcondiciones: 
- r1 = 0x00000005
- r2 = 0x00000005
- offset = 0x00000010

r1 != r2 (5 != 5) = Falso
PC = PC + 4 = 0x00000004 (ejecuta la siguiente instrucción)

## Conclusiones:
La operación funciona correctamente, al ser iguales los registros, no realiza el salto y continúa con la siguiente instrucción.

# 35. BLT

## Descripción
Comparar dos registros con signo y saltar a una dirección objetivo si el primer registro es menor que el segundo. El salto es relativo al PC (PC + 4 + (offset << 2)).

## Instrucctions:
> BLT r1, r2, offset

## Precondiciones: 
Setear los registros con valores donde r1 sea menor que r2 y posicionar el PC.
> set pc 0 s r1 0x00000003 s r2 0x00000007

## Code
- Opcode : 00110
- rs : 00001
- rt : 00010
- offset : 0000000000000010

Binario: 0011 0000 1000 0100 0000 0000 0000 1010

Hexa:    3    0    8    4    0    0    0    A

> s [0x0] 0x3084000A 00110 opcode 00001 $1 00010 $2 0000000000000010 offset

## Postcondiciones: 
- r1 = 0x00000003
- r2 = 0x00000007
- offset = 0x00000010 (desplazado 2 bits: 0x00000010 << 2 = 0x00000040)

r1 < r2 (3 < 7) = Verdadero
PC = PC + 4 + (offset << 2) = 0x00000000 + 4 + 0x40 = 0x00000044

## Conclusiones:
La operación funciona, compara con signo r1 y r2, y al ser r1 menor que r2, salta a la dirección calculada (PC + 4 + offset*4).

# 36. BLT (caso negativo)

## Descripción
Comparar dos registros con signo donde uno es negativo, demostrando la comparación con signo.

## Instrucctions:
> BLT r1, r2, offset

## Precondiciones: 
Setear los registros con valores con signo donde r1 sea negativo y r2 positivo.
> set pc 0 s r1 0xFFFFFFF0 s r2 0x00000001

## Code
- Opcode : 00110
- rs : 00001
- rt : 00010
- offset : 0000000000000010

Binario: 0011 0000 1000 0100 0000 0000 0000 1010

Hexa:    3    0    8    4    0    0    0    A

> s [0x0] 0x3084000A 00110 opcode 00001 $1 00010 $2 0000000000000010 offset

## Postcondiciones: 
- r1 = 0xFFFFFFF0 (-16 en complemento a dos)
- r2 = 0x00000001 (1)

-16 < 1 = Verdadero
PC = PC + 4 + (offset << 2) = 0x00000044

## Conclusiones:
La operación BLT considera correctamente el signo en complemento a dos. -16 es menor que 1, por lo tanto realiza el salto.

# 37. BGT 
## Descripción
Comparar dos registros con signo y saltar a una dirección objetivo si el primer registro es mayor que el segundo. El salto es relativo al PC (PC + 4 + (offset << 2)).

## Instrucctions:
> BGT r1, r2, offset

## Precondiciones: 
Setear los registros con valores donde r1 sea mayor que r2 y posicionar el PC.
> set pc 0 s r1 0x00000007 s r2 0x00000003

## Code
- Opcode : 00111
- rs : 00001
- rt : 00010
- offset : 0000000000000010

Binario: 0011 1000 1000 0100 0000 0000 0000 1010

Hexa:    3    8    8    4    0    0    0    A

> s [0x0] 0x3884000A 00111 opcode 00001 $1 00010 $2 0000000000000010 offset

## Postcondiciones: 
- r1 = 0x00000007
- r2 = 0x00000003
- offset = 0x00000010 (desplazado 2 bits: 0x00000010 << 2 = 0x00000040)

r1 > r2 (7 > 3) = Verdadero
PC = PC + 4 + (offset << 2) = 0x00000000 + 4 + 0x40 = 0x00000044

## Conclusiones:
La operación funciona, compara con signo r1 y r2, y al ser r1 mayor que r2, salta a la dirección calculada (PC + 4 + offset*4).

# 38. SH 

## Descripción
Guardar una media palabra (16 bits) desde un registro a la memoria, utilizando una dirección base y un offset inmediato. Solo se guardan los 16 bits menos significativos.

## Instrucctions:
> SH r1, offset(r2)

## Precondiciones: 
Setear el registro base con una dirección de memoria válida y el registro fuente con un valor a guardar.
> set pc 0 s r2 0x00001000 s r1 0x12345678

## Code
- Opcode : 10011
- rs : 00010
- rt : 00001
- offset : 0000000000000100

Binario: 1001 1000 1000 0010 0000 0000 0000 0100

Hexa:    9    8    8    2    0    0    0    4

> s [0x0] 0x98820004 10011 opcode 00010 $2 00001 $1 0000000000000100 offset

## Postcondiciones: 
- r1 = 0x12345678
- r2 = 0x00001000
- offset = 0x00000004

Memoria[0x1004] = 0x00005678 (solo los 16 bits menos significativos)

## Conclusiones:
La operación funciona, guarda la media palabra (16 bits menos significativos) de r1 en la dirección de memoria calculada (r2 + offset).

# 39. SB 

## Descripción
Guardar un byte (8 bits) desde un registro a la memoria, utilizando una dirección base y un offset inmediato. Solo se guarda el byte menos significativo.

## Instrucctions:
> SB r1, offset(r2)

## Precondiciones: 
Setear el registro base con una dirección de memoria válida y el registro fuente con un valor a guardar.
> set pc 0 s r2 0x00001000 s r1 0x12345678

## Code
- Opcode : 10100
- rs : 00010
- rt : 00001
- offset : 0000000000000100

Binario: 1010 0000 1000 0010 0000 0000 0000 0100

Hexa:    A    0    8    2    0    0    0    4

> s [0x0] 0xA0820004 10100 opcode 00010 $2 00001 $1 0000000000000100 offset

## Postcondiciones: 
- r1 = 0x12345678
- r2 = 0x00001000
- offset = 0x00000004

Memoria[0x1004] = 0x00000078 (solo el byte menos significativo)

## Conclusiones:
La operación funciona, guarda el byte (8 bits menos significativos) de r1 en la dirección de memoria calculada (r2 + offset).

# 40. LH 
## Descripción
Cargar una media palabra (16 bits) desde la memoria a un registro, con extensión de signo a 32 bits.

## Instrucctions:
> LH r1, offset(r2)

## Precondiciones: 
Setear el registro base con una dirección de memoria válida y posicionar el PC.
> set pc 0 s r2 0x00001000

## Code
- Opcode : 10101
- rs : 00010
- rt : 00001
- offset : 0000000000000100

Binario: 1010 1000 1000 0010 0000 0000 0000 0100

Hexa:    A    8    8    2    0    0    0    4

> s [0x0] 0xA8820004 10101 opcode 00010 $2 00001 $1 0000000000000100 offset

## Precondiciones de memoria:
> s [0x1004] 0xFFFF8765

## Postcondiciones: 
- r2 = 0x00001000
- offset = 0x00000004
- Memoria[0x1004] = 0xFFFF8765 (los 16 bits inferiores son 0x8765)

r1 = extensión de signo de 0x8765 = 0xFFFF8765

## Conclusiones:
La operación funciona, carga la media palabra desde la dirección de memoria calculada, la extiende con signo a 32 bits y la guarda en r1.

# 41. LBU 

## Descripción
Cargar un byte (8 bits) desde la memoria a un registro, extendido con ceros a 32 bits.

## Instrucctions:
> LBU r1, offset(r2)

## Precondiciones: 
Setear el registro base con una dirección de memoria válida y posicionar el PC.
> set pc 0 s r2 0x00001000

## Code
- Opcode : 10110
- rs : 00010
- rt : 00001
- offset : 0000000000000100

Binario: 1011 0000 1000 0010 0000 0000 0000 0100

Hexa:    B    0    8    2    0    0    0    4

> s [0x0] 0xB0820004 10110 opcode 00010 $2 00001 $1 0000000000000100 offset

## Precondiciones de memoria:
> s [0x1004] 0xFFFFFF78

## Postcondiciones: 
- r2 = 0x00001000
- offset = 0x00000004
- Memoria[0x1004] = 0xFFFFFF78 (el byte menos significativo es 0x78)

r1 = extensión con ceros de 0x78 = 0x00000078

## Conclusiones:
La operación funciona, carga el byte desde la dirección de memoria calculada, lo extiende con ceros a 32 bits y lo guarda en r1.

# 42. LIUH 

## Descripción
Cargar un valor inmediato de 16 bits en los bits superiores (16-31) de un registro, similar a LUI pero con un formato de instrucción diferente.

## Instrucctions:
> LIUH r1, imm

## Precondiciones: 
Posicionar el PC.
> set pc 0

## Code
- Opcode : 01001
- rs : 00000 (no utilizado)
- rt : 00001
- imm : 0000000000000101

Binario: 0100 1000 0000 0001 0000 0000 0000 0101

Hexa:    4    8    0    1    0    0    0    5

> s [0x0] 0x48010005 01001 opcode 00000 $0 00001 $1 0000000000000101 imm

## Postcondiciones: 
- imm = 0x00000005
- r1 = imm << 16 = 0x00050000

## Conclusiones:
La operación funciona, carga el valor inmediato en los bits superiores del registro, llenando los bits inferiores con ceros.

# 43. LB

## Descripción
Cargar un byte (8 bits) desde la memoria a un registro, con extensión de signo a 32 bits.

## Instrucctions:
> LB r1, offset(r2)

## Precondiciones: 
Setear el registro base con una dirección de memoria válida y posicionar el PC.
> set pc 0 s r2 0x00001000

## Code
- Opcode : 10111
- rs : 00010
- rt : 00001
- offset : 0000000000000100

Binario: 1011 1000 1000 0010 0000 0000 0000 0100

Hexa:    B    8    8    2    0    0    0    4

> s [0x0] 0xB8820004 10111 opcode 00010 $2 00001 $1 0000000000000100 offset

## Precondiciones de memoria:
> s [0x1004] 0xFFFFFF87

## Postcondiciones: 
- r2 = 0x00001000
- offset = 0x00000004
- Memoria[0x1004] = 0xFFFFFF87 (el byte es 0x87)

r1 = extensión de signo de 0x87 = 0xFFFFFF87

## Conclusiones:
La operación funciona, carga el byte desde la dirección de memoria calculada, lo extiende con signo a 32 bits y lo guarda en r1.

# 44. LBU (Load Byte Unsigned)

## Descripción
Cargar un byte (8 bits) desde la memoria a un registro, extendido con ceros a 32 bits.

## Instrucctions:
> LBU r1, offset(r2)

## Precondiciones: 
Setear el registro base con una dirección de memoria válida y posicionar el PC.
> set pc 0 s r2 0x00001000

## Code
- Opcode : 10110
- rs : 00010
- rt : 00001
- offset : 0000000000000100

Binario: 1011 0000 1000 0010 0000 0000 0000 0100

Hexa:    B    0    8    2    0    0    0    4

> s [0x0] 0xB0820004 10110 opcode 00010 $2 00001 $1 0000000000000100 offset

## Precondiciones de memoria:
> s [0x1004] 0xFFFFFF87

## Postcondiciones: 
- r2 = 0x00001000
- offset = 0x00000004
- Memoria[0x1004] = 0xFFFFFF87 (el byte es 0x87)

r1 = extensión con ceros de 0x87 = 0x00000087

## Conclusiones:
La operación funciona, carga el byte desde la dirección de memoria calculada, lo extiende con ceros a 32 bits y lo guarda en r1.

# 45. LWX

## Descripción
Cargar una palabra (32 bits) desde la memoria a un registro, utilizando la suma de dos registros como dirección base.

## Instrucctions:
> LWX r1, r2, r3

## Precondiciones: 
Setear los registros con una dirección base y un índice.
> set pc 0 s r2 0x00001000 s r3 0x00000004

## Code
- Opcode : 00000
- rs : 00010
- rt : 00011
- rd : 00001
- aux : 00000
- funct : 001011

Binario: 0000 0000 1000 0110 0001 0000 0010 1011

Hexa:    0    0    8    6    1    0    2    B

> s [0x0] 0x0086102B 00000 opcode 00010 $2 00011 $3 00001 $1 000000 aux 001011 funct

## Precondiciones de memoria:
> s [0x1004] 0x12345678

## Postcondiciones: 
- r2 = 0x00001000
- r3 = 0x00000004
- Dirección = r2 + r3 = 0x00001004
- Memoria[0x1004] = 0x12345678

r1 = 0x12345678

## Conclusiones:
La operación funciona, calcula la dirección sumando los dos registros y carga la palabra desde esa posición en memoria.

# 46. LHX

## Descripción
Cargar una media palabra (16 bits) desde la memoria a un registro con extensión de signo, utilizando la suma de dos registros como dirección base.

## Instrucctions:
> LHX r1, r2, r3

## Precondiciones: 
Setear los registros con una dirección base y un índice.
> set pc 0 s r2 0x00001000 s r3 0x00000004

## Code
- Opcode : 00000
- rs : 00010
- rt : 00011
- rd : 00001
- aux : 00000
- funct : 001100

Binario: 0000 0000 1000 0110 0001 0000 0011 0000

Hexa:    0    0    8    6    1    0    3    0

> s [0x0] 0x00861030 00000 opcode 00010 $2 00011 $3 00001 $1 000000 aux 001100 funct

## Precondiciones de memoria:
> s [0x1004] 0x87654321

## Postcondiciones: 
- r2 = 0x00001000
- r3 = 0x00000004
- Dirección = r2 + r3 = 0x00001004
- Memoria[0x1004] = 0x87654321 (la media palabra es 0x4321)

r1 = extensión de signo de 0x4321 = 0x00004321

## Conclusiones:
La operación funciona, calcula la dirección sumando los dos registros, carga la media palabra con extensión de signo desde esa posición en memoria.

# 47. LHUX

## Descripción
Cargar una media palabra (16 bits) desde la memoria a un registro con extensión con ceros, utilizando la suma de dos registros como dirección base.

## Instrucctions:
> LHUX r1, r2, r3

## Precondiciones: 
Setear los registros con una dirección base y un índice.
> set pc 0 s r2 0x00001000 s r3 0x00000004

## Code
- Opcode : 00000
- rs : 00010
- rt : 00011
- rd : 00001
- aux : 00000
- funct : 001101

Binario: 0000 0000 1000 0110 0001 0000 0011 0100

Hexa:    0    0    8    6    1    0    3    4

> s [0x0] 0x00861034 00000 opcode 00010 $2 00011 $3 00001 $1 000000 aux 001101 funct

## Precondiciones de memoria:
> s [0x1004] 0x87654321

## Postcondiciones: 
- r2 = 0x00001000
- r3 = 0x00000004
- Dirección = r2 + r3 = 0x00001004
- Memoria[0x1004] = 0x87654321 (la media palabra es 0x4321)

r1 = extensión con ceros de 0x4321 = 0x00004321

## Conclusiones:
La operación funciona, calcula la dirección sumando los dos registros, carga la media palabra con extensión con ceros desde esa posición en memoria.

# 48. LBX

## Descripción
Cargar un byte (8 bits) desde la memoria a un registro con extensión de signo, utilizando la suma de dos registros como dirección base.

## Instrucctions:
> LBX r1, r2, r3

## Precondiciones: 
Setear los registros con una dirección base y un índice.
> set pc 0 s r2 0x00001000 s r3 0x00000004

## Code
- Opcode : 00000
- rs : 00010
- rt : 00011
- rd : 00001
- aux : 00000
- funct : 001110

Binario: 0000 0000 1000 0110 0001 0000 0011 1000

Hexa:    0    0    8    6    1    0    3    8

> s [0x0] 0x00861038 00000 opcode 00010 $2 00011 $3 00001 $1 000000 aux 001110 funct

## Precondiciones de memoria:
> s [0x1004] 0x87654321

## Postcondiciones: 
- r2 = 0x00001000
- r3 = 0x00000004
- Dirección = r2 + r3 = 0x00001004
- Memoria[0x1004] = 0x87654321 (el byte es 0x21)

r1 = extensión de signo de 0x21 = 0x00000021

## Conclusiones:
La operación funciona, calcula la dirección sumando los dos registros, carga el byte con extensión de signo desde esa posición en memoria.

# 49. LBUX

## Descripción
Cargar un byte (8 bits) desde la memoria a un registro con extensión con ceros, utilizando la suma de dos registros como dirección base.

## Instrucctions:
> LBUX r1, r2, r3

## Precondiciones: 
Setear los registros con una dirección base y un índice.
> set pc 0 s r2 0x00001000 s r3 0x00000004

## Code
- Opcode : 00000
- rs : 00010
- rt : 00011
- rd : 00001
- aux : 00000
- funct : 001111

Binario: 0000 0000 1000 0110 0001 0000 0011 1100

Hexa:    0    0    8    6    1    0    3    C

> s [0x0] 0x0086103C 00000 opcode 00010 $2 00011 $3 00001 $1 000000 aux 001111 funct

## Precondiciones de memoria:
> s [0x1004] 0x87654321

## Postcondiciones: 
- r2 = 0x00001000
- r3 = 0x00000004
- Dirección = r2 + r3 = 0x00001004
- Memoria[0x1004] = 0x87654321 (el byte es 0x21)

r1 = extensión con ceros de 0x21 = 0x00000021

## Conclusiones:
La operación funciona, calcula la dirección sumando los dos registros, carga el byte con extensión con ceros desde esa posición en memoria.

# 50. MUL

## Descripción
Multiplicar dos registros de 32 bits con signo y guardar los 32 bits menos significativos del resultado en un tercer registro.

## Instrucctions:
> MUL r1, r2, r3

## Precondiciones: 
Setear los registros con valores a multiplicar.
> set pc 0 s r2 0x00000005 s r3 0x00000003

## Code
- Opcode : 00000
- rs : 00010
- rt : 00011
- rd : 00001
- aux : 00000
- funct : 010000

Binario: 0000 0000 1000 0110 0001 0000 0100 0000

Hexa:    0    0    8    6    1    0    4    0

> s [0x0] 0x00861040 00000 opcode 00010 $2 00011 $3 00001 $1 000000 aux 010000 funct

## Postcondiciones: 
- r2 = 0x00000005
- r3 = 0x00000003

5 * 3 = 15 = 0x0000000F

r1 = 0x0000000F

## Conclusiones:
La operación funciona, multiplica r2 por r3 y guarda los 32 bits menos significativos del resultado en r1.

# 51. MULH

## Descripción
Multiplicar dos registros de 32 bits con signo y guardar los 32 bits más significativos del resultado en un tercer registro.

## Instrucctions:
> MULH r1, r2, r3

## Precondiciones: 
Setear los registros con valores que produzcan un resultado de 64 bits.
> set pc 0 s r2 0x00010000 s r3 0x00010000

## Code
- Opcode : 00000
- rs : 00010
- rt : 00011
- rd : 00001
- aux : 00000
- funct : 010001

Binario: 0000 0000 1000 0110 0001 0000 0100 0001

Hexa:    0    0    8    6    1    0    4    1

> s [0x0] 0x00861041 00000 opcode 00010 $2 00011 $3 00001 $1 000000 aux 010001 funct

## Postcondiciones: 
- r2 = 0x00010000 (65536)
- r3 = 0x00010000 (65536)

65536 * 65536 = 4,294,967,296 = 0x100000000

Los 32 bits más significativos son 0x00000001

r1 = 0x00000001

## Conclusiones:
La operación funciona, multiplica r2 por r3 y guarda los 32 bits más significativos del resultado de 64 bits en r1.

# 52. MULHU

## Descripción
Multiplicar dos registros de 32 bits sin signo y guardar los 32 bits más significativos del resultado en un tercer registro.

## Instrucctions:
> MULHU r1, r2, r3

## Precondiciones: 
Setear los registros con valores sin signo que produzcan un resultado de 64 bits.
> set pc 0 s r2 0xFFFFFFFF s r3 0xFFFFFFFF

## Code
- Opcode : 00000
- rs : 00010
- rt : 00011
- rd : 00001
- aux : 00000
- funct : 010010

Binario: 0000 0000 1000 0110 0001 0000 0100 0010

Hexa:    0    0    8    6    1    0    4    2

> s [0x0] 0x00861042 00000 opcode 00010 $2 00011 $3 00001 $1 000000 aux 010010 funct

## Postcondiciones: 
- r2 = 0xFFFFFFFF (4,294,967,295)
- r3 = 0xFFFFFFFF (4,294,967,295)

4,294,967,295 * 4,294,967,295 = 18,446,744,065,119,617,025 = 0xFFFFFFFE00000001

Los 32 bits más significativos son 0xFFFFFFFE

r1 = 0xFFFFFFFE

## Conclusiones:
La operación funciona, multiplica r2 por r3 sin signo y guarda los 32 bits más significativos del resultado en r1.

# 53. DIV

## Descripción
Dividir un registro de 32 bits con signo (dividendo) entre otro registro con signo (divisor) y guardar el cociente en un tercer registro.

## Instrucctions:
> DIV r1, r2, r3

## Precondiciones: 
Setear los registros con valores a dividir.
> set pc 0 s r2 0x0000000F s r3 0x00000003

## Code
- Opcode : 00000
- rs : 00010
- rt : 00011
- rd : 00001
- aux : 00000
- funct : 010011

Binario: 0000 0000 1000 0110 0001 0000 0100 0011

Hexa:    0    0    8    6    1    0    4    3

> s [0x0] 0x00861043 00000 opcode 00010 $2 00011 $3 00001 $1 000000 aux 010011 funct

## Postcondiciones: 
- r2 = 0x0000000F (15)
- r3 = 0x00000003 (3)

15 / 3 = 5 = 0x00000005

r1 = 0x00000005

## Conclusiones:
La operación funciona, divide r2 entre r3 con signo y guarda el cociente en r1.

# 54. DIVU

## Descripción
Dividir un registro de 32 bits sin signo (dividendo) entre otro registro sin signo (divisor) y guardar el cociente en un tercer registro.

## Instrucctions:
> DIVU r1, r2, r3

## Precondiciones: 
Setear los registros con valores sin signo a dividir.
> set pc 0 s r2 0x0000000F s r3 0x00000003

## Code
- Opcode : 00000
- rs : 00010
- rt : 00011
- rd : 00001
- aux : 00000
- funct : 010100

Binario: 0000 0000 1000 0110 0001 0000 0101 0000

Hexa:    0    0    8    6    1    0    5    0

> s [0x0] 0x00861050 00000 opcode 00010 $2 00011 $3 00001 $1 000000 aux 010100 funct

## Postcondiciones: 
- r2 = 0x0000000F (15)
- r3 = 0x00000003 (3)

15 / 3 = 5 = 0x00000005

r1 = 0x00000005

## Conclusiones:
La operación funciona, divide r2 entre r3 sin signo y guarda el cociente en r1.

# 55. REST (Remainder)

## Descripción
Dividir un registro de 32 bits con signo (dividendo) entre otro registro con signo (divisor) y guardar el resto en un tercer registro.

## Instrucctions:
> REST r1, r2, r3

## Precondiciones: 
Setear los registros con valores a dividir.
> set pc 0 s r2 0x0000000F s r3 0x00000006

## Code
- Opcode : 00000
- rs : 00010
- rt : 00011
- rd : 00001
- aux : 00000
- funct : 010101

Binario: 0000 0000 1000 0110 0001 0000 0101 0001

Hexa:    0    0    8    6    1    0    5    1

> s [0x0] 0x00861051 00000 opcode 00010 $2 00011 $3 00001 $1 000000 aux 010101 funct

## Postcondiciones: 
- r2 = 0x0000000F (15)
- r3 = 0x00000006 (6)

15 / 6 = 2 con resto 3 = 0x00000003

r1 = 0x00000003

## Conclusiones:
La operación funciona, divide r2 entre r3 con signo y guarda el resto en r1.

# 56. RESTU

## Descripción
Dividir un registro de 32 bits sin signo (dividendo) entre otro registro sin signo (divisor) y guardar el resto en un tercer registro.

## Instrucctions:
> RESTU r1, r2, r3

## Precondiciones: 
Setear los registros con valores sin signo a dividir.
> set pc 0 s r2 0x0000000F s r3 0x00000006

## Code
- Opcode : 00000
- rs : 00010
- rt : 00011
- rd : 00001
- aux : 00000
- funct : 010110

Binario: 0000 0000 1000 0110 0001 0000 0101 0010

Hexa:    0    0    8    6    1    0    5    2

> s [0x0] 0x00861052 00000 opcode 00010 $2 00011 $3 00001 $1 000000 aux 010110 funct

## Postcondiciones: 
- r2 = 0x0000000F (15)
- r3 = 0x00000006 (6)

15 / 6 = 2 con resto 3 = 0x00000003

r1 = 0x00000003

## Conclusiones:
La operación funciona, divide r2 entre r3 sin signo y guarda el resto en r1.