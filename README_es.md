# MSX2 y MSX1 para MiST, SiDi, SiDi128, Calypso y Poseidon, con menú OSD

*[Read in English](README.md) · [Leggi in italiano](README_it.md)*

Fork de Shaeon (Carlos Palmero) de [ivan0174-hue/MSX_MiST](https://github.com/ivan0174-hue/MSX_MiST), que convierte
el core OneChipMSX para MiST de gyurco ([gyurco/MSX_MiST](https://github.com/gyurco/MSX_MiST)) en dos cores que se
comportan como ordenadores MSX reales y se usan desde el menú OSD de la placa.

- **MSX2-OSD**: MAIN-ROM, SUB-ROM, memory mapper de 64 KB a 4 MB, RTC, VDP V9938/V9958, organizado como un Philips NMS 8245.
- **MSX1-OSD**: por defecto un MSX1 original (64 KB de RAM, sin mapper, interfaz de disco como un cartucho VY-0010
  en el slot 2), con mapper opcional de 128/256/512 KB como un cartucho de ampliación de RAM.

Los cores se llaman `MSX1-OSD` y `MSX2-OSD`, así que sus ficheros (`MSX2-OSD.ROM`, `.R01`–`.R04`, `.VHD`, `.CFG`)
no chocan con los de otros cores MSX en la misma SD.

## Características

- Cartuchos (`.ROM`) en los slots 1 y 2 con detección automática del mapper (Konami, Konami SCC, ASCII 8K/16K, Generic 8K).
- Unidad A: con imágenes `.DSK` de 360/720 KB (controladora WD2793 de tipo Philips).
- Cinta (`.CAS`) cargada con `BLOAD"CAS:",R`, `RUN"CAS:"` y `CLOAD`, con barra de progreso en pantalla.
- Disco duro opcional mediante una MegaSD emulada (OneChipMSX) con Nextor: `MSX2-OSD.VHD` / `MSX1-OSD.VHD`,
  activable en *System → Hard disk (MegaSD)*.
- Velocidad de la CPU, volúmenes de PSG/SCC/FM, 50/60 Hz, salida de 15 kHz o VGA.
- Teclado: US (por defecto), español, italiano o japonés.

## Placas

| Placa | FPGA | Proyecto | Quartus |
|---|---|---|---|
| MiST | Cyclone III EP3C25 | `mist/msx2_mist.qpf`, `mist/msx1_mist.qpf` | 13.1 |
| SiDi | Cyclone IV EP4CE22 | `mist/msx2_sidi.qpf`, `mist/msx1_sidi.qpf` | 17.0 |
| SiDi128 | Cyclone 10 LP 10CL120 | `extra_sidi128/*` (se copian a `mist/`) | 17.0 |
| Calypso | Cyclone 10 LP 10CL025 | `calypso/msx2_calypso.qpf`, `calypso/msx1_calypso.qpf` | 17.0 |
| Poseidon | Cyclone IV GX EP4CGX150 | `poseidon/msx2_poseidon.qpf`, `poseidon/msx1_poseidon.qpf` | 17.0 |

En la Calypso (16 MB de SDRAM) cada cartucho puede ocupar hasta 4 MB.

Cada push compila todas las versiones con GitHub Actions; los `.rbf` están en los artefactos de la ejecución y,
para las etiquetas `v*`, en las [releases](../../releases).

## ROMs de sistema

Las ROMs de sistema de Philips tienen copyright y no se incluyen: en [ROMS_es.md](ROMS_es.md) ([English](ROMS.md))
se explica cómo montar `MSX2-OSD.ROM` / `MSX1-OSD.ROM` con tus propias ROMs y cómo preparar el disco duro. Las
releases incluyen C-BIOS (`CBIOS_ROMs.zip`), que solo arranca cartuchos.

El menú y las instrucciones originales para MiST están descritos en italiano en [LEGGIMI.md](LEGGIMI.md) (MSX2) y
[LEGGIMI_MSX1.md](LEGGIMI_MSX1.md) (MSX1).

## Compilar

Antes de compilar hay que descargar los submódulos `T80` y `mist/mist-modules`:

```
git clone --recursive https://github.com/shaeon/MSX_MiST_OSD.git
```

## Licencias

Los componentes de OCM (ESE Artists' factory, KdL, t.hara y otros) mantienen su licencia de tipo BSD.
T80 es de Daniel Wallner. `rtl/wd1793.sv` es de Sorgelig y Viacheslav Slavinsky (GPL). Los módulos de MiST son de
Till Harbaum y otros. El resto se distribuye bajo GPL v2 o posterior. C-BIOS: licencia BSD (`cbios/LICENSE.txt`).
