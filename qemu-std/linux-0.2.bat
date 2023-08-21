@ECHO OFF
REM ##############################################################################
REM (c) Eric Lassauge - June 2012
REM <lassauge {AT} users {DOT} sourceforge {DOT} net >
REM
REM ##############################################################################
REM    This program is free software: you can redistribute it and/or modify
REM    it under the terms of the GNU General Public License as published by
REM    the Free Software Foundation, either version 3 of the License, or
REM    (at your option) any later version.
REM
REM    This program is distributed in the hope that it will be useful,
REM    but WITHOUT ANY WARRANTY; without even the implied warranty of
REM    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
REM    GNU General Public License for more details.
REM
REM    You should have received a copy of the GNU General Public License
REM    along with this program.  If not, see <http://www.gnu.org/licenses/>
REM ##############################################################################
REM Exemple BAT script for starting qemu-system-i386.exe on windows host with a
REM small Linux disk image containing a 2.6.20 Linux kernel, X11 and various utilities
REM to test QEMU (See http://wiki.qemu.org/Testing)

REM Start qemu on windows.

REM SDL_VIDEODRIVER=directx is faster than windib. But keyboard cannot work well.
SET SDL_VIDEODRIVER=directx

REM QEMU_AUDIO_DRV=dsound or fmod or sdl or none can be used. See qemu -audio-help.
SET QEMU_AUDIO_DRV=dsound

REM SDL_AUDIODRIVER=waveout or dsound can be used. Only if QEMU_AUDIO_DRV=sdl.
SET SDL_AUDIODRIVER=dsound

REM QEMU_AUDIO_LOG_TO_MONITOR=1 displays log messages in QEMU monitor.
SET QEMU_AUDIO_LOG_TO_MONITOR=1

REM ################################################
REM # Boot disk image
REM # Adapt "-k fr" to you keyboard
REM # X11, nic and soundhw were tested and are working!
REM # try madplay 20thfull.mp2 or xinit
REM ################################################
START qemu-system-i386w.exe -L Bios -k fr -vga std -soundhw es1370 ^
-boot menu=on,splash=./bootsplash.bmp,splash-time=3000 ^
-rtc base=localtime,clock=host ^
-name linux-0.2 -drive file=linux-0.2.img,media=disk,cache=writeback ^
-net nic,model=ne2k_pci -net user ^
-no-acpi -no-hpet -no-reboot 

REM ################################################
REM # Extended example: works on a Fedora14+ image
REM ################################################
REM # Boot disk image + use eth0 + Video Display Device = std + ssh remap
REM # Use the new syntax for drive/netcard on virtio
REM # Use VNC to display output:   -usbdevice tablet -k fr -vnc 127.0.0.1:0 ^
REM ################################################
REM qemu-system-i386.exe -name Fedora ^
REM   -L Bios -m 1G -vga std -soundhw es1370 -rtc base=localtime,clock=host ^
REM   -boot menu=on,splash=bootsplash.bmp,splash-time=5000 ^
REM   -k fr -usbdevice tablet -vnc 127.0.0.1:0 ^
REM   -net nic,model=virtio -net user,hostfwd=tcp::5555-:22 -no-acpi -no-hpet ^
REM   -drive file=fedora.qcow2,format=qcow2,if=virtio,media=disk,cache=writeback 