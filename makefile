compile: assembly kernel link
all: assembly kernel link start

start:
	qemu -kernel levos.bin

assembly:
	i586-elf-as boot.s -o boot.o

kernel:
	i586-elf-gcc -c main.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
	cd display && make

link:
	i586-elf-gcc -T linker.ld -o levos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o display/display.o display/textmode/dispi_textmode.o  -lgcc