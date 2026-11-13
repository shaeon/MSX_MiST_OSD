@echo off
rem Builds MSX2-OSD.ROM and MSX1-OSD.ROM from the openMSX system ROM files (see ROMS.md)
rem Usage: make_roms.bat [carpeta_con_las_roms] [fmbios_opcional.rom]
setlocal
set "D=%~1"
if "%D%"=="" set "D=."
set "FM=%~2"

call :chk nms8245_basic-bios2.rom 32768 || goto msx1
call :chk nms8245_msx2sub.rom 16384 || goto msx1
call :chk nms8245_disk.rom 16384 || goto msx1
copy /b "%D%\nms8245_basic-bios2.rom" + "%D%\nms8245_msx2sub.rom" + "%D%\nms8245_disk.rom" MSX2-OSD.ROM >nul
if not "%FM%"=="" call :chk "%FM%" 16384 && copy /b MSX2-OSD.ROM + "%D%\%FM%" MSX2-OSD.ROM >nul
for %%F in (MSX2-OSD.ROM) do echo MSX2-OSD.ROM created (%%~zF bytes)

:msx1
call :chk vg8020_basic-bios1.rom 32768 || goto fin
call :chk vy0010.rom 16384 || goto fin
copy /b "%D%\vg8020_basic-bios1.rom" + "%D%\vy0010.rom" MSX1-OSD.ROM >nul
if not "%FM%"=="" call :chk "%FM%" 16384 && copy /b MSX1-OSD.ROM + "%D%\%FM%" MSX1-OSD.ROM >nul
for %%F in (MSX1-OSD.ROM) do echo MSX1-OSD.ROM created (%%~zF bytes)
:fin
endlocal
exit /b 0

:chk
if not exist "%D%\%~1" (echo Missing %~1 & exit /b 1)
for %%F in ("%D%\%~1") do if not "%%~zF"=="%~2" (echo %~1: %%~zF bytes, expected %~2 & exit /b 1)
exit /b 0
