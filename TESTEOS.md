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