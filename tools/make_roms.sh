#!/bin/sh
# Builds MSX2.ROM and MSX1.ROM from the openMSX system ROM files (see ROMS.md)
# Usage: ./make_roms.sh [rom_folder]   (openMSX system ROM file names)
D="${1:-.}"
chk() { [ -f "$D/$1" ] || { echo "Missing $1"; return 1; }
        s=$(wc -c < "$D/$1"); [ "$s" -eq "$2" ] || { echo "$1 is $s bytes, expected $2"; return 1; }; }
FM="${FMBIOS:-}"   # optional: FMBIOS=fmbios.rom ./make_roms.sh roms
fm_ok=0; [ -n "$FM" ] && chk "$FM" 16384 && fm_ok=1

# MSX2: MAIN 32K + SUB 16K + DISK Philips 16K (+ FM 16K)
if chk nms8245_basic-bios2.rom 32768 && chk nms8245_msx2sub.rom 16384 && chk nms8245_disk.rom 16384; then
  cat "$D/nms8245_basic-bios2.rom" "$D/nms8245_msx2sub.rom" "$D/nms8245_disk.rom" > MSX2.ROM
  [ $fm_ok = 1 ] && cat "$D/$FM" >> MSX2.ROM
  echo "MSX2.ROM created ($(wc -c < MSX2.ROM) bytes)"
fi
# MSX1: MAIN 32K + DISK VY-0010 16K (+ FM 16K)
if chk vg8020_basic-bios1.rom 32768 && chk vy0010.rom 16384; then
  cat "$D/vg8020_basic-bios1.rom" "$D/vy0010.rom" > MSX1.ROM
  [ $fm_ok = 1 ] && cat "$D/$FM" >> MSX1.ROM
  echo "MSX1.ROM created ($(wc -c < MSX1.ROM) bytes)"
fi
