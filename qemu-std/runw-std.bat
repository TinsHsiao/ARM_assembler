qemu-system-arm.exe -M versatilepb -cpu arm1176 -hda 2012-07-15-wheezy-raspbian-std.img -kernel kernel-qemu -m 256 -append "root=/dev/sda2" -net nic -net user,hostfwd=tcp::22-:22 -clock dynticks
