# MSX2 and MSX1 for MiST, SiDi, SiDi128, Calypso and Poseidon, with OSD menu

*[Leer en español](README_es.md) · [Leggi in italiano](README_it.md)*

Fork by Shaeon (Carlos Palmero) of [ivan0174-hue/MSX_MiST](https://github.com/ivan0174-hue/MSX_MiST), which turns
gyurco's OneChipMSX core for MiST ([gyurco/MSX_MiST](https://github.com/gyurco/MSX_MiST)) into two cores that behave
like real MSX computers and are used from the board's OSD menu.

- **MSX2-OSD**: MAIN-ROM, SUB-ROM, memory mapper 64 KB–4 MB, RTC, VDP V9938/V9958, organised like a Philips NMS 8245.
- **MSX1-OSD**: an original MSX1 by default (64 KB of RAM, no mapper, disk interface like a VY-0010 cartridge in
  slot 2), with an optional mapper of 128/256/512 KB as a RAM expansion cartridge.

The cores are called `MSX1-OSD` and `MSX2-OSD`, so their files (`MSX2-OSD.ROM`, `.R01`–`.R04`, `.VHD`, `.CFG`)
do not clash with other MSX cores on the same SD card.

## Features

- Cartridges (`.ROM`) in slots 1 and 2 with automatic mapper detection (Konami, Konami SCC, ASCII 8K/16K, Generic 8K).
- Drive A: with 360/720 KB `.DSK` images (Philips-type WD2793 controller).
- Cassette (`.CAS`) loaded with `BLOAD"CAS:",R`, `RUN"CAS:"` and `CLOAD`, with an on-screen progress bar.
- Optional hard disk through an emulated MegaSD (OneChipMSX) with Nextor: `MSX2-OSD.VHD` / `MSX1-OSD.VHD`,
  enabled in *System → Hard disk (MegaSD)*.
- CPU speed, PSG/SCC/FM volumes, 50/60 Hz, 15 kHz or VGA output.
- Keyboard: US (default), Spanish, Italian or Japanese.

## Boards

| Board | FPGA | Project | Quartus |
|---|---|---|---|
| MiST | Cyclone III EP3C25 | `mist/msx2_mist.qpf`, `mist/msx1_mist.qpf` | 13.1 |
| SiDi | Cyclone IV EP4CE22 | `mist/msx2_sidi.qpf`, `mist/msx1_sidi.qpf` | 17.0 |
| SiDi128 | Cyclone 10 LP 10CL120 | `extra_sidi128/*` (copied into `mist/`) | 17.0 |
| Calypso | Cyclone 10 LP 10CL025 | `calypso/msx2_calypso.qpf`, `calypso/msx1_calypso.qpf` | 17.0 |
| Poseidon | Cyclone IV GX EP4CGX150 | `poseidon/msx2_poseidon.qpf`, `poseidon/msx1_poseidon.qpf` | 17.0 |

On Calypso (16 MB of SDRAM) each cartridge can be up to 4 MB.

Every push builds all versions with GitHub Actions; the `.rbf` files are in the run's artifacts and, for the `v*`
tags, in the [releases](../../releases).

## System ROMs

The Philips system ROMs are copyrighted and are not included: see [ROMS.md](ROMS.md) ([español](ROMS_es.md)) to build
`MSX2-OSD.ROM` / `MSX1-OSD.ROM` from your own ROMs, and to prepare the hard disk. The releases include C-BIOS
(`CBIOS_ROMs.zip`), which only starts cartridges.

The menu and the original MiST instructions are described in Italian in [LEGGIMI.md](LEGGIMI.md) (MSX2) and
[LEGGIMI_MSX1.md](LEGGIMI_MSX1.md) (MSX1).

## Building

The submodules `T80` and `mist/mist-modules` must be downloaded before building:

```
git clone --recursive https://github.com/shaeon/MSX_MiST_OSD.git
```

## Licences

The OCM components (ESE Artists' factory, KdL, t.hara and others) keep their BSD-style licence.
T80 is by Daniel Wallner. `rtl/wd1793.sv` is by Sorgelig and Viacheslav Slavinsky (GPL). The MiST modules are by
Till Harbaum and others. The rest is distributed under the GPL v2 or later. C-BIOS: BSD licence (`cbios/LICENSE.txt`).
