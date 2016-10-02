
#ARMGNU=arm-thumb-elf
#ARMGNU=arm-none-linux-gnueabi
ARMGNU?=arm-none-eabi

COPS = -Wall  -O2 -nostdlib -nostartfiles -ffreestanding
AOPS = --warn --fatal-warnings

all : uart01.bin

vectors.o : vectors.s
	$(ARMGNU)-as vectors.s -o vectors.o

uart01.o : uart01.c
	$(ARMGNU)-gcc $(COPS) -c uart01.c -o uart01.o

uart01.bin : memmap vectors.o uart01.o
	$(ARMGNU)-ld -o uart01.elf -T memmap vectors.o uart01.o
	$(ARMGNU)-objdump -D uart01.elf > uart01.list
	$(ARMGNU)-objcopy --srec-forceS3 uart01.elf -O srec uart01.srec
	$(ARMGNU)-objcopy uart01.elf -O binary uart01.bin

clean:
	rm -f *.bin
	rm -f *.o
	rm -f *.elf
	rm -f *.list
	rm -f *.srec



