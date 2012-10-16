
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

allgcc : features.gcc.bin

allclang : features.clang.norm.bin features.clang.opt.bin


vectors.o : vectors.s
	$(ARMGNU)-as -mfpu=vfp vectors.s -o vectors.o

features.gcc.o : features.c
	$(ARMGNU)-gcc $(COPS) -c features.c -o features.gcc.o

features.gcc.bin : memmap vectors.o features.gcc.o
	$(ARMGNU)-ld -o features.gcc.elf -T memmap vectors.o features.gcc.o
	$(ARMGNU)-objdump -D features.gcc.elf > features.gcc.list
	$(ARMGNU)-objcopy features.gcc.elf features.gcc.bin -O binary

features.clang.bc : features.c
	clang $(LOPS) -c features.c -o features.clang.bc

features.clang.norm.bin : memmap vectors.o features.clang.bc
	llc $(LLCOPS) features.clang.bc -o features.clang.norm.s
	$(ARMGNU)-as features.clang.norm.s -o features.clang.norm.o
	$(ARMGNU)-ld -o features.clang.norm.elf -T memmap vectors.o features.clang.norm.o
	$(ARMGNU)-objdump -D features.clang.norm.elf > features.clang.norm.list
	$(ARMGNU)-objcopy features.clang.norm.elf features.clang.norm.bin -O binary

features.clang.opt.bin : memmap vectors.o features.clang.bc
	opt $(OOPS) features.clang.bc -o features.clang.opt.bc
	llc $(LLCOPS) features.clang.opt.bc -o features.clang.opt.s
	$(ARMGNU)-as features.clang.opt.s -o features.clang.opt.o
	$(ARMGNU)-ld -o features.clang.opt.elf -T memmap vectors.o features.clang.opt.o
	$(ARMGNU)-objdump -D features.clang.opt.elf > features.clang.opt.list
	$(ARMGNU)-objcopy features.clang.opt.elf features.clang.opt.bin -O binary


clean:
	rm -f *.bin
	rm -f *.o
	rm -f *.elf
	rm -f *.list
	rm -f *.bc
	rm -f *.opt.s
	rm -f *.norm.s
	rm -f uartdiv


