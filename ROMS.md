# System ROMs (MSX2-OSD.ROM / MSX1-OSD.ROM)

*[Leer en español](ROMS_es.md) · [Main page](README.md)*

When the core starts, the board firmware (MiST, SiDi, SiDi128, Calypso, Poseidon) loads
`MSX2-OSD.ROM` (MSX2 core) or `MSX1-OSD.ROM` (MSX1 core) by itself, from the root of the SD card or
from the core's folder. Without a valid file the screen stays black.

The Philips system ROMs are copyrighted and are **not** included in this repository or in the
releases: you have to build the file from your own ROMs. The releases only include C-BIOS
(`CBIOS_ROMs.zip`, see option C).

## Summary: which files go on the SD card

All of them go in the **root of the SD card** or in the **same folder as the core's `.rbf`**, with these exact
names. The firmware loads them by itself when the core starts.

| File on the SD card | What it is | Required? |
|---|---|---|
| `MSX2-OSD.ROM` | The MSX2 system ROMs joined (option A), **or** a renamed copy of `OCM-BIOS.DAT` (option B), **or** C-BIOS (option C) | yes |
| `MSX2-OSD.R02` | 16 KB Philips DISK-ROM, only if `MSX2-OSD.ROM` is `OCM-BIOS.DAT` and you want disks | no |
| `MSX2-OSD.R04` | Hard disk driver: **a renamed copy of `OCM-BIOS.DAT`** (or a Nextor ROM for the OCM) | only for the hard disk |
| `MSX2-OSD.VHD` | Hard disk image | only for the hard disk |
| `MSX1-OSD.ROM` | The MSX1 system ROMs joined, or C-BIOS | yes |
| `MSX1-OSD.R03` | Hard disk driver: **a renamed copy of `OCM-BIOS.DAT`** (or a Nextor ROM for the OCM) | only for the hard disk |
| `MSX1-OSD.VHD` | Hard disk image | only for the hard disk |

`OCM-BIOS.DAT` is never used with its original name: it is always **copied and renamed** to the name in the
table. The same file can be copied several times with different names (for example as `MSX1-OSD.R03` and as
`MSX2-OSD.R04`). If you don't have it as a separate file, it is usually inside the VHD image of the OCM/ZEMMIX cores.

## MSX2: `MSX2-OSD.ROM`

There are three ways to prepare it.

**A) ROMs from a real MSX2 (recommended).** The file is these ROMs joined, in this order:

| Offset | Size | Contents | Required |
|---|---|---|---|
| 0x00000 | 32 KB | MAIN-ROM (BIOS + MSX-BASIC) | yes |
| 0x08000 | 16 KB | SUB-ROM (MSX2 extended BIOS) | yes |
| 0x0C000 | 16 KB | **Philips**-type DISK-ROM (WD2793 at 7FF8h) | to use disks |
| 0x10000 | 16 KB | MSX-MUSIC (FM-BIOS) | optional |

A handy choice is the **Philips NMS 8245**, which has the same disk controller the core emulates.
With the file names of the openMSX system ROM sets:

Windows (command prompt):
```
copy /b nms8245_basic-bios2.rom + nms8245_msx2sub.rom + nms8245_disk.rom MSX2-OSD.ROM
```
Linux / macOS:
```
cat nms8245_basic-bios2.rom nms8245_msx2sub.rom nms8245_disk.rom > MSX2-OSD.ROM
```

The DISK-ROMs of the Philips NMS 8250/8255/8280, VG-8235 and VY-0010 also work, as they use the same
controller. Those of other brands (Sony, Panasonic, Toshiba…) use different registers and do **not** work.
For MSX-MUSIC, append a 16 KB FM-BIOS at the end (for example, the one of a Panasonic FS-A1WX).

The ROMs can also be in separate files: `MSX2-OSD.ROM` with only the 32 KB MAIN-ROM, then `MSX2-OSD.R01` = SUB-ROM,
`MSX2-OSD.R02` = DISK-ROM, `MSX2-OSD.R03` = MSX-MUSIC. The firmware loads all of them at start-up.

**B) The BIOS you already use with the current MSX core.** Make a copy of the file `OCM-BIOS.DAT` (KdL's MSX2+
BIOS) named `MSX2-OSD.ROM`: the core takes its MAIN-ROM, SUB-ROM and MSX-MUSIC. That BIOS has no DISK-ROM
for the Philips controller, so for disks you also need the file `MSX2-OSD.R02` with a 16 KB Philips DISK-ROM.
With this BIOS set *System → VDP ID → V9958 (MSX2+)*.
It is a handy way to start, but KdL's BIOS is made for the OneChipMSX: with a real MSX2 BIOS the core is more
faithful.

**C) Without original ROMs** you can use `cbios/MSX2_CBIOS.ROM` (or `MSX2-OSD.ROM` from `CBIOS_ROMs.zip` in the
releases), renamed `MSX2-OSD.ROM`. It is C-BIOS, a free BIOS that only starts cartridges: no BASIC, no disks and
no tapes.

## MSX1: `MSX1-OSD.ROM`

The file is these ROMs joined:

| Offset | Size | Contents | Required |
|---|---|---|---|
| 0x0000 | 32 KB | MAIN-ROM of an MSX1 (BIOS + MSX-BASIC) | yes |
| 0x8000 | 16 KB | **Philips**-type DISK-ROM (WD2793 at 7FF8h), for example the one of the **VY-0010** | to use disks |
| 0xC000 | 16 KB | MSX-MUSIC (FM-BIOS) | optional |

Example with the ROMs of a Philips VG-8020 and of the VY-0010 disk interface (the file names depend on where
you got them), on Windows:
```
copy /b vg8020_basic-bios1.rom + vy0010.rom MSX1-OSD.ROM
```
Linux / macOS:
```
cat vg8020_basic-bios1.rom vy0010.rom > MSX1-OSD.ROM
```

Alternatively: `MSX1-OSD.ROM` with only the 32 KB MAIN-ROM, `MSX1-OSD.R01` = DISK-ROM, `MSX1-OSD.R02` = MSX-MUSIC.

The DISK-ROM must be a Philips one (VY-0010, VG-8230/8235, NMS 8245/8250/8280): the Sony, Panasonic,
Toshiba etc. ones do not work. On an MSX1 the most faithful choice is the VY-0010, which was precisely a
disk interface for MSX1.

**Without original ROMs** you can try the core with `cbios/MSX1_CBIOS.ROM` (or `MSX1-OSD.ROM` from
`CBIOS_ROMs.zip`) renamed `MSX1-OSD.ROM`: it is C-BIOS, a free BIOS that only starts cartridges (no BASIC, disks
or tapes).

With `MSX1-OSD.ROM` missing or without a MAIN-ROM the screen stays black.

## Hard disk: `MSX2-OSD.R04` / `MSX1-OSD.R03` and `MSX2-OSD.VHD` / `MSX1-OSD.VHD`

The MSX2 core can use a hard disk image through an emulated MegaSD (the SD interface of the OneChipMSX).
It needs two files next to the core:

- `MSX2-OSD.R04`: the MegaSD driver, up to 512 KB, loaded into the internal ESE-RAM. The easiest way is a copy
  of `OCM-BIOS.DAT` named `MSX2-OSD.R04` (its first 128 KB are the MegaSD driver). A Nextor ROM built for the
  OCM/MegaSD also works.
- `MSX2-OSD.VHD`: the hard disk image (FAT12/FAT16). The firmware mounts it by itself at start-up as SD image 0;
  another image can be chosen in the OSD.

Then enable *System → Hard disk (MegaSD) → On*. The MegaSD sits in slot 3-0 (3-2 when the RAM is in 3-0).
With the option Off, or without `MSX2-OSD.R04`, the core behaves as before and the image is ignored.

**MSX1:** the same with `MSX1-OSD.R03` (the driver: a copy of `OCM-BIOS.DAT` with that name) and `MSX1-OSD.VHD`. With *Hard disk → On* the slot 3 is expanded
(RAM in 3-2, as in the Philips VG-8020) and the MegaSD goes to 3-0. With 64 KB, Nextor starts in MSX-DOS 1
mode; for MSX-DOS 2 (NEXTOR.SYS, COMMAND2.COM) choose *System → RAM → 128/256/512 KB (mapper)*, like a RAM
expansion cartridge. By default the MSX1 is still an original one: 64 KB, no mapper, no hard disk.

## Script

`tools/make_roms.bat` (Windows) and `tools/make_roms.sh` (Linux / macOS) build both files from a folder with
the openMSX file names above, and check the size of every ROM before joining them:
```
tools\make_roms.bat C:\roms [fmbios.rom]
FMBIOS=fmbios.rom ./tools/make_roms.sh ~/roms
```
