# ROMs de sistema (MSX2.ROM / MSX1.ROM)

*[Read in English](ROMS.md)*

Al arrancar el core, el firmware de la placa (MiST, SiDi, SiDi128, Calypso, Poseidon) carga por sí solo
`MSX2.ROM` (core MSX2) o `MSX1.ROM` (core MSX1), de la raíz de la SD o de la carpeta del core. Sin un
fichero válido la pantalla se queda en negro.

Las ROMs de sistema de Philips tienen copyright y **no** se incluyen ni en este repositorio ni en las
releases: hay que montar el fichero con tus propias ROMs. Las releases solo incluyen C-BIOS
(`CBIOS_ROMs.zip`, ver la opción C).

## MSX2: `MSX2.ROM`

Hay tres formas de prepararlo.

**A) ROMs de un MSX2 real (recomendado).** El fichero es la unión de estas ROMs, en este orden:

| Offset | Tamaño | Contenido | Obligatoria |
|---|---|---|---|
| 0x00000 | 32 KB | MAIN-ROM (BIOS + MSX-BASIC) | sí |
| 0x08000 | 16 KB | SUB-ROM (BIOS extendida de MSX2) | sí |
| 0x0C000 | 16 KB | DISK-ROM de tipo **Philips** (WD2793 en 7FF8h) | para usar discos |
| 0x10000 | 16 KB | MSX-MUSIC (FM-BIOS) | opcional |

Una elección cómoda es el **Philips NMS 8245**, que tiene la misma controladora de disco que emula el core.
Con los nombres de fichero de los juegos de ROMs de sistema de openMSX:

Windows (símbolo del sistema):
```
copy /b nms8245_basic-bios2.rom + nms8245_msx2sub.rom + nms8245_disk.rom MSX2.ROM
```
Linux / macOS:
```
cat nms8245_basic-bios2.rom nms8245_msx2sub.rom nms8245_disk.rom > MSX2.ROM
```

También valen las DISK-ROM de los Philips NMS 8250/8255/8280, VG-8235 y VY-0010, que usan la misma
controladora. Las de otras marcas (Sony, Panasonic, Toshiba…) usan otros registros y **no** funcionan.
Para tener MSX-MUSIC, añade al final una FM-BIOS de 16 KB (por ejemplo, la de un Panasonic FS-A1WX).

Las ROMs también pueden ir en ficheros separados: `MSX2.ROM` solo con la MAIN-ROM de 32 KB, y después
`MSX2.R01` = SUB-ROM, `MSX2.R02` = DISK-ROM, `MSX2.R03` = MSX-MUSIC. El firmware los carga todos al arrancar.

**B) La BIOS que ya usas con el core MSX actual.** Puedes copiar el fichero `OCM-BIOS.DAT` (la BIOS MSX2+ de
KdL) y renombrarlo a `MSX2.ROM`: el core toma de ella la MAIN-ROM, la SUB-ROM y el MSX-MUSIC. Esa BIOS no
tiene una DISK-ROM para la controladora Philips, así que para los discos hace falta además el fichero
`MSX2.R02` con una DISK-ROM Philips de 16 KB. Con esta BIOS pon *System → VDP ID → V9958 (MSX2+)*.
Es una forma cómoda de empezar, pero la BIOS de KdL está pensada para la OneChipMSX: con una BIOS de un MSX2
real el core es más fiel.

**C) Sin ROMs originales** puedes usar `cbios/MSX2_CBIOS.ROM` (o el `MSX2.ROM` de `CBIOS_ROMs.zip` de las
releases), renombrado a `MSX2.ROM`. Es C-BIOS, una BIOS libre que solo arranca cartuchos: sin BASIC, sin
discos y sin cintas.

## MSX1: `MSX1.ROM`

El fichero es la unión de:

| Offset | Tamaño | Contenido | Obligatoria |
|---|---|---|---|
| 0x0000 | 32 KB | MAIN-ROM de un MSX1 (BIOS + MSX-BASIC) | sí |
| 0x8000 | 16 KB | DISK-ROM de tipo **Philips** (WD2793 en 7FF8h), por ejemplo la del **VY-0010** | para usar discos |
| 0xC000 | 16 KB | MSX-MUSIC (FM-BIOS) | opcional |

Ejemplo con las ROMs de un Philips VG-8020 y de la interfaz de disco VY-0010 (los nombres de los ficheros
dependen de dónde las hayas sacado), en Windows:
```
copy /b vg8020_basic-bios1.rom + vy0010.rom MSX1.ROM
```
Linux / macOS:
```
cat vg8020_basic-bios1.rom vy0010.rom > MSX1.ROM
```

Como alternativa: `MSX1.ROM` solo con la MAIN-ROM de 32 KB, `MSX1.R01` = DISK-ROM, `MSX1.R02` = MSX-MUSIC.

La DISK-ROM tiene que ser Philips (VY-0010, VG-8230/8235, NMS 8245/8250/8280): las de Sony, Panasonic,
Toshiba, etc. no funcionan. En un MSX1 la opción más fiel es la VY-0010, que era precisamente una interfaz de
disco para MSX1.

**Sin ROMs originales** puedes probar el core con `cbios/MSX1_CBIOS.ROM` (o el `MSX1.ROM` de
`CBIOS_ROMs.zip`) renombrado a `MSX1.ROM`: es C-BIOS, una BIOS libre que solo arranca cartuchos (sin BASIC,
discos ni cintas).

Si falta `MSX1.ROM` o no tiene MAIN-ROM, la pantalla se queda en negro.

## Disco duro (MSX2): `MSX2.R04` y `MSX2.VHD`

El core MSX2 puede usar una imagen de disco duro a través de una MegaSD emulada (la interfaz SD de la
OneChipMSX). Necesita dos ficheros junto al core:

- `MSX2.R04`: el driver de la MegaSD, de hasta 512 KB, que se carga en la ESE-RAM interna. Puede ser una
  copia de `OCM-BIOS.DAT` (sus primeros 128 KB son el driver de la MegaSD) o una ROM de Nextor compilada
  para OCM/MegaSD.
- `MSX2.VHD`: la imagen del disco duro (FAT12/FAT16). El firmware la monta solo al arrancar como imagen SD 0;
  se puede elegir otra desde el OSD.

Después activa *System → Hard disk (MegaSD) → On*. La MegaSD va en el slot 3-0 (3-2 si la RAM está en 3-0).
Con la opción en Off, o sin `MSX2.R04`, el core se comporta como antes y la imagen se ignora.

## Script

`tools/make_roms.bat` (Windows) y `tools/make_roms.sh` (Linux / macOS) montan los dos ficheros a partir de
una carpeta con los nombres de openMSX de arriba, y comprueban el tamaño de cada ROM antes de unirlas:
```
tools\make_roms.bat C:\roms [fmbios.rom]
FMBIOS=fmbios.rom ./tools/make_roms.sh ~/roms
```
