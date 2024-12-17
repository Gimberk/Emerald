run:
	mkdir -p build
	nasm -felf32 src/boot.s -o build/boot.o
	i686-elf-gcc -c src/kernel/kernel.c -o build/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
	i686-elf-gcc -T src/linker.ld -o build/kernel.bin -ffreestanding -O2 -nostdlib build/boot.o build/kernel.o -lgcc

	mkdir -p build/isodir/boot/grub
	cp env/disk.img build/disk.img
	cp build/kernel.bin build/isodir/boot/kernel.bin
	cp grub/grub.cfg build/isodir/boot/grub/grub.cfg
	grub-mkrescue -o Emerald.iso build/isodir
	qemu-system-i386 -cdrom Emerald.iso

clean:
	rm -rf build
	rm Emerald.iso
	clear