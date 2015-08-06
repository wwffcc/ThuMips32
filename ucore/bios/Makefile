GCCPREFIX   := mips-linux-gnu-
CC          := $(GCCPREFIX)gcc
CFLAGS      := -EL -march=4kc -fno-builtin -Wall -nostdinc $(DEFS)
CFLAGS      += -fno-stack-protector -fno-delayed-branch
LD          := $(GCCPREFIX)ld
LDFLAGS     := -EL -m elf32ltsmip -nostdlib
OBJCOPY     := $(GCCPREFIX)objcopy
OBJDUMP     := $(GCCPREFIX)objdump

all: rom.vhd

rom.vhd: bios.bin to_rom.py
	python to_rom.py $< > $@
bios.bin: bios.elf
	$(OBJCOPY) -j .text -O binary $^ $@
bios.elf: biosasm.o biosmain.o
	$(LD) $(LDFLAGS) -N -e start -Ttext 0xbfc00000 $^ -o $@
biosasm.o: biosasm.S
	$(CC) $(CFLAGS) -I. -Os -c $< -o $@
biosmain.o: biosmain.c elf.h defs.h
	$(CC) $(CFLAGS) -I. -Os -c $< -o $@

clean:
	rm -vf rom.vhd bios.bin bios.elf *.o
.PHONY: all clean

