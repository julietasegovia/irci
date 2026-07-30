# rtm32_rom_device.c

Modelo del periférico ROM del sistema RTM32/STX4. Implementa la memoria
de arranque mapeada en el bus de 32 bits, según la especificación de
arquitectura del manual RTM32 (Boot ROM Mapping, Kernel Space).

## Propiedades garantizadas

- **Base fija**: `0xF0000000` (`ROM_BASE_ADDR`). No configurable ni
  reubicable, ni siquiera por línea de comandos.
- **Tamaño variable**: determinado por el archivo cargado, hasta
  `ROM_MAX_SIZE` (16 MiB por defecto).
- **Inmutable**: toda escritura dentro de rango se rechaza
  (`ROM_ERR_WRITE_DENIED`); el contenido nunca cambia en ejecución.
- **Little-Endian**: los reads de 16/32 bits arman el valor a mano,
  sin depender del endianness del host.
- **Sin validación de alineación**: se asume que el bus/CPU ya
  verificó alineación antes de invocar estas funciones.

## API

| Función | Descripción |
|---|---|
| `rom_device_load(rom, path)` | Carga un archivo binario en la ROM. Debe llamarse antes del reset de la CPU. Devuelve `0` en éxito, `-1` en error. |
| `rom_device_destroy(rom)` | Libera el buffer y resetea el estado. |
| `rom_read8/16/32(rom, addr, *out)` | Lectura por ancho. Devuelve `ROM_OK` o `ROM_ERR_UNMAPPED`. |
| `rom_write8/16/32(rom, addr, val)` | Escritura por ancho. Devuelve `ROM_ERR_UNMAPPED` o `ROM_ERR_WRITE_DENIED` (nunca escribe realmente). |

## Estructura principal

```c
typedef struct {
    uint32_t base;   // siempre ROM_BASE_ADDR
    uint32_t size;   // bytes cargados
    uint8_t *data;   // contenido, inmutable tras la carga
    int      loaded; // 1 si hay imagen cargada
} rom_device_t;
```

## Códigos de estado (`rom_access_status_t`)

- `ROM_OK` — acceso válido.
- `ROM_ERR_UNMAPPED` — dirección fuera del rango `[base, base+size)`.
- `ROM_ERR_WRITE_DENIED` — dirección válida, pero es escritura sobre ROM.

## Integración

Este archivo no depende de ningún bus concreto. El bloque `#if 0` al
final es un ejemplo de cómo registrar las funciones como callbacks en
un dispatcher de bus (`bus_region_t` o equivalente) — hay que
adaptarlo a la estructura real del emulador.

## Pendientes / decisiones abiertas

- Los códigos de excepción son provisorios: el Cap. 8 (Excepciones)
  del manual RTM32 todavía no define el mapeo formal error → excepción
  de hardware.
- No implementa límite de alineación; esa responsabilidad queda
  explícitamente en la capa que llama a estas funciones.
