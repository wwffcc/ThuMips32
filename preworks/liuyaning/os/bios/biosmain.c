#include <defs.h>
#include <elf.h>

/* *********************************************************************
 *
 * Comments NOT updated yet!
 * =========================
 *
 * This a dirt simple boot loader, whose sole job is to boot
 * an ELF kernel image from the first IDE hard disk.
 *
 * DISK LAYOUT
 *  * This program(bootasm.S and bootmain.c) is the bootloader.
 *    It should be stored in the first sector of the disk.
 *
 *  * The 2nd sector onward holds the kernel image.
 *
 *  * The kernel image must be in ELF format.
 *
 * BOOT UP STEPS
 *  * when the CPU boots it loads the BIOS into memory and executes it
 *
 *  * the BIOS intializes devices, sets of the interrupt routines, and
 *    reads the first sector of the boot device(e.g., hard-drive)
 *    into memory and jumps to it.
 *
 *  * Assuming this boot loader is stored in the first sector of the
 *    hard-drive, this code takes over...
 *
 *  * control starts in bootasm.S -- which sets up protected mode,
 *    and a stack so C code then run, then calls bootmain()
 *
 *  * bootmain() in this file takes over, reads in the kernel and jumps to it.
 * */

#define FLASH_BASE      0xbe000000
#define ELFHDR          ((struct elfhdr *)0x80700000)      // scratch space

/* *
 * readseg - read @count bytes at @offset from kernel into virtual address @va,
 * might copy more than asked.
 * */
static void
readseg(uintptr_t va, uint32_t count, uint32_t offset) {
    uint32_t* end_va = (uint32_t*)(va + count);
    uint32_t* dst = (uint32_t*)va;
    uint32_t* src = (uint32_t*)(FLASH_BASE+offset);
    for (; dst < end_va; src++, dst++) {
        *dst = *src;
    }
}

/* bootmain - the entry of bootloader */
void
biosmain(void) {
    // read the 1st page off disk
    readseg((uintptr_t)ELFHDR, sizeof(struct elfhdr), 0);

    // is this a valid ELF?
    if (ELFHDR->e_magic != ELF_MAGIC) {
        goto bad;
    }

    struct proghdr *ph, *eph;

    // load each program segment (ignores ph flags)
    ph = (struct proghdr *)((uintptr_t)ELFHDR + ELFHDR->e_phoff);
    eph = ph + ELFHDR->e_phnum;
    for (; ph < eph; ph ++) {
        readseg((uintptr_t)ph, sizeof(struct proghdr), (uintptr_t)ph - (uintptr_t)ELFHDR);
        readseg(ph->p_va, ph->p_memsz, ph->p_offset);
    }

    // call the entry point from the ELF header
    // note: does not return
    ((void (*)(void))(ELFHDR->e_entry))();

bad:
    /* do nothing */
    while (1);
}

