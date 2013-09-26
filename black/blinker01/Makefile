
#ARMGNU=arm-thumb-elf
#ARMGNU=arm-none-linux-gnueabi
ARMGNU?=arm-none-eabi

LOPS = -Wall -m32 -emit-llvm

LLCOPS = -march=arm

COPS = -Wall  -O2 -nostdlib -nostartfiles -ffreestanding

AOPS = --warn --fatal-warnings

OOPS = -std-compile-opts

stuff = -O2 -std-compile-opts -strip-debug


all : allgcc allclang

allgcc : blinker01.gcc.bin

allclang : blinker01.clang.norm.bin blinker01.clang.opt.bin


vectors.o : vectors.s
	$(ARMGNU)-as vectors.s -o vectors.o

blinker01.gcc.o : blinker01.c
	$(ARMGNU)-gcc $(COPS) -c blinker01.c -o blinker01.gcc.o

blinker01.gcc.bin : memmap vectors.o blinker01.gcc.o
	$(ARMGNU)-ld -o blinker01.gcc.elf -T memmap vectors.o blinker01.gcc.o
	$(ARMGNU)-objdump -D blinker01.gcc.elf > blinker01.gcc.list
	$(ARMGNU)-objcopy blinker01.gcc.elf blinker01.gcc.bin -O binary

blinker01.clang.bc : blinker01.c
	clang $(LOPS) -c blinker01.c -o blinker01.clang.bc

blinker01.clang.norm.bin : memmap vectors.o blinker01.clang.bc
	llc $(LLCOPS) blinker01.clang.bc -o blinker01.clang.norm.s
	$(ARMGNU)-as blinker01.clang.norm.s -o blinker01.clang.norm.o
	$(ARMGNU)-ld -o blinker01.clang.norm.elf -T memmap vectors.o blinker01.clang.norm.o
	$(ARMGNU)-objdump -D blinker01.clang.norm.elf > blinker01.clang.norm.list
	$(ARMGNU)-objcopy blinker01.clang.norm.elf blinker01.clang.norm.bin -O binary

blinker01.clang.opt.bin : memmap vectors.o blinker01.clang.bc
	opt $(OOPS) blinker01.clang.bc -o blinker01.clang.opt.bc
	llc $(LLCOPS) blinker01.clang.opt.bc -o blinker01.clang.opt.s
	$(ARMGNU)-as blinker01.clang.opt.s -o blinker01.clang.opt.o
	$(ARMGNU)-ld -o blinker01.clang.opt.elf -T memmap vectors.o blinker01.clang.opt.o
	$(ARMGNU)-objdump -D blinker01.clang.opt.elf > blinker01.clang.opt.list
	$(ARMGNU)-objcopy blinker01.clang.opt.elf blinker01.clang.opt.bin -O binary


clean:
	rm -f *.bin
	rm -f *.o
	rm -f *.elf
	rm -f *.list
	rm -f *.bc
	rm -f *.opt.s
	rm -f *.norm.s
	rm -f uartdiv


