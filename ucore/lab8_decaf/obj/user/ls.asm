
obj/__user_ls.out:     file format elf32-tradlittlemips


Disassembly of section .text:

00800020 <opendir>:
#include <error.h>
#include <unistd.h>

DIR dir, *dirp=&dir;
DIR *
opendir(const char *path) {
  800020:	27bdffc0 	addiu	sp,sp,-64
  800024:	afbf003c 	sw	ra,60(sp)
  800028:	afbe0038 	sw	s8,56(sp)
  80002c:	afb00034 	sw	s0,52(sp)
  800030:	03a0f021 	move	s8,sp
  800034:	afc40040 	sw	a0,64(s8)

    if ((dirp->fd = open(path, O_RDONLY)) < 0) {
  800038:	3c020080 	lui	v0,0x80
  80003c:	8c504000 	lw	s0,16384(v0)
  800040:	8fc40040 	lw	a0,64(s8)
  800044:	00002821 	move	a1,zero
  800048:	0c20007c 	jal	8001f0 <open>
  80004c:	00000000 	nop
  800050:	ae020000 	sw	v0,0(s0)
  800054:	8e020000 	lw	v0,0(s0)
  800058:	04410003 	bgez	v0,800068 <opendir+0x48>
  80005c:	00000000 	nop
        goto failed;
  800060:	08200032 	j	8000c8 <opendir+0xa8>
  800064:	00000000 	nop
    }
    struct stat __stat, *stat = &__stat;
  800068:	27c2001c 	addiu	v0,s8,28
  80006c:	afc20018 	sw	v0,24(s8)
    if (fstat(dirp->fd, stat) != 0 || !S_ISDIR(stat->st_mode)) {
  800070:	3c020080 	lui	v0,0x80
  800074:	8c424000 	lw	v0,16384(v0)
  800078:	8c420000 	lw	v0,0(v0)
  80007c:	00402021 	move	a0,v0
  800080:	8fc50018 	lw	a1,24(s8)
  800084:	0c2000d0 	jal	800340 <fstat>
  800088:	00000000 	nop
  80008c:	1440000e 	bnez	v0,8000c8 <opendir+0xa8>
  800090:	00000000 	nop
  800094:	8fc20018 	lw	v0,24(s8)
  800098:	8c420000 	lw	v0,0(v0)
  80009c:	30437000 	andi	v1,v0,0x7000
  8000a0:	24022000 	li	v0,8192
  8000a4:	14620008 	bne	v1,v0,8000c8 <opendir+0xa8>
  8000a8:	00000000 	nop
        goto failed;
    }
    dirp->dirent.offset = 0;
  8000ac:	3c020080 	lui	v0,0x80
  8000b0:	8c424000 	lw	v0,16384(v0)
  8000b4:	ac400004 	sw	zero,4(v0)
    return dirp;
  8000b8:	3c020080 	lui	v0,0x80
  8000bc:	8c424000 	lw	v0,16384(v0)
  8000c0:	08200033 	j	8000cc <opendir+0xac>
  8000c4:	00000000 	nop

failed:
    return NULL;
  8000c8:	00001021 	move	v0,zero
}
  8000cc:	03c0e821 	move	sp,s8
  8000d0:	8fbf003c 	lw	ra,60(sp)
  8000d4:	8fbe0038 	lw	s8,56(sp)
  8000d8:	8fb00034 	lw	s0,52(sp)
  8000dc:	27bd0040 	addiu	sp,sp,64
  8000e0:	03e00008 	jr	ra
  8000e4:	00000000 	nop

008000e8 <readdir>:

struct dirent *
readdir(DIR *dirp) {
  8000e8:	27bdffe0 	addiu	sp,sp,-32
  8000ec:	afbf001c 	sw	ra,28(sp)
  8000f0:	afbe0018 	sw	s8,24(sp)
  8000f4:	03a0f021 	move	s8,sp
  8000f8:	afc40020 	sw	a0,32(s8)
    if (sys_getdirentry(dirp->fd, &(dirp->dirent)) == 0) {
  8000fc:	8fc20020 	lw	v0,32(s8)
  800100:	8c430000 	lw	v1,0(v0)
  800104:	8fc20020 	lw	v0,32(s8)
  800108:	24420004 	addiu	v0,v0,4
  80010c:	00602021 	move	a0,v1
  800110:	00402821 	move	a1,v0
  800114:	0c20052f 	jal	8014bc <sys_getdirentry>
  800118:	00000000 	nop
  80011c:	14400005 	bnez	v0,800134 <readdir+0x4c>
  800120:	00000000 	nop
        return &(dirp->dirent);
  800124:	8fc20020 	lw	v0,32(s8)
  800128:	24420004 	addiu	v0,v0,4
  80012c:	0820004e 	j	800138 <readdir+0x50>
  800130:	00000000 	nop
    }
    return NULL;
  800134:	00001021 	move	v0,zero
}
  800138:	03c0e821 	move	sp,s8
  80013c:	8fbf001c 	lw	ra,28(sp)
  800140:	8fbe0018 	lw	s8,24(sp)
  800144:	27bd0020 	addiu	sp,sp,32
  800148:	03e00008 	jr	ra
  80014c:	00000000 	nop

00800150 <closedir>:

void
closedir(DIR *dirp) {
  800150:	27bdffe0 	addiu	sp,sp,-32
  800154:	afbf001c 	sw	ra,28(sp)
  800158:	afbe0018 	sw	s8,24(sp)
  80015c:	03a0f021 	move	s8,sp
  800160:	afc40020 	sw	a0,32(s8)
    close(dirp->fd);
  800164:	8fc20020 	lw	v0,32(s8)
  800168:	8c420000 	lw	v0,0(v0)
  80016c:	00402021 	move	a0,v0
  800170:	0c20008c 	jal	800230 <close>
  800174:	00000000 	nop
}
  800178:	03c0e821 	move	sp,s8
  80017c:	8fbf001c 	lw	ra,28(sp)
  800180:	8fbe0018 	lw	s8,24(sp)
  800184:	27bd0020 	addiu	sp,sp,32
  800188:	03e00008 	jr	ra
  80018c:	00000000 	nop

00800190 <getcwd>:

int
getcwd(char *buffer, size_t len) {
  800190:	27bdffe0 	addiu	sp,sp,-32
  800194:	afbf001c 	sw	ra,28(sp)
  800198:	afbe0018 	sw	s8,24(sp)
  80019c:	03a0f021 	move	s8,sp
  8001a0:	afc40020 	sw	a0,32(s8)
  8001a4:	afc50024 	sw	a1,36(s8)
    return sys_getcwd(buffer, len);
  8001a8:	8fc40020 	lw	a0,32(s8)
  8001ac:	8fc50024 	lw	a1,36(s8)
  8001b0:	0c20051e 	jal	801478 <sys_getcwd>
  8001b4:	00000000 	nop
}
  8001b8:	03c0e821 	move	sp,s8
  8001bc:	8fbf001c 	lw	ra,28(sp)
  8001c0:	8fbe0018 	lw	s8,24(sp)
  8001c4:	27bd0020 	addiu	sp,sp,32
  8001c8:	03e00008 	jr	ra
  8001cc:	00000000 	nop

008001d0 <do_syscall>:
.text
.globl do_syscall
do_syscall:
    lw      $v1, 0x10($sp)
  8001d0:	8fa30010 8fa20014 0000000c 03e00008     ................
	...

008001f0 <open>:
#include <stat.h>
#include <error.h>
#include <unistd.h>

int
open(const char *path, uint32_t open_flags) {
  8001f0:	27bdffe0 	addiu	sp,sp,-32
  8001f4:	afbf001c 	sw	ra,28(sp)
  8001f8:	afbe0018 	sw	s8,24(sp)
  8001fc:	03a0f021 	move	s8,sp
  800200:	afc40020 	sw	a0,32(s8)
  800204:	afc50024 	sw	a1,36(s8)
    return sys_open(path, open_flags);
  800208:	8fc40020 	lw	a0,32(s8)
  80020c:	8fc50024 	lw	a1,36(s8)
  800210:	0c2004a5 	jal	801294 <sys_open>
  800214:	00000000 	nop
}
  800218:	03c0e821 	move	sp,s8
  80021c:	8fbf001c 	lw	ra,28(sp)
  800220:	8fbe0018 	lw	s8,24(sp)
  800224:	27bd0020 	addiu	sp,sp,32
  800228:	03e00008 	jr	ra
  80022c:	00000000 	nop

00800230 <close>:

int
close(int fd) {
  800230:	27bdffe0 	addiu	sp,sp,-32
  800234:	afbf001c 	sw	ra,28(sp)
  800238:	afbe0018 	sw	s8,24(sp)
  80023c:	03a0f021 	move	s8,sp
  800240:	afc40020 	sw	a0,32(s8)
    return sys_close(fd);
  800244:	8fc40020 	lw	a0,32(s8)
  800248:	0c2004b6 	jal	8012d8 <sys_close>
  80024c:	00000000 	nop
}
  800250:	03c0e821 	move	sp,s8
  800254:	8fbf001c 	lw	ra,28(sp)
  800258:	8fbe0018 	lw	s8,24(sp)
  80025c:	27bd0020 	addiu	sp,sp,32
  800260:	03e00008 	jr	ra
  800264:	00000000 	nop

00800268 <read>:

int
read(int fd, void *base, size_t len) {
  800268:	27bdffe0 	addiu	sp,sp,-32
  80026c:	afbf001c 	sw	ra,28(sp)
  800270:	afbe0018 	sw	s8,24(sp)
  800274:	03a0f021 	move	s8,sp
  800278:	afc40020 	sw	a0,32(s8)
  80027c:	afc50024 	sw	a1,36(s8)
  800280:	afc60028 	sw	a2,40(s8)
    return sys_read(fd, base, len);
  800284:	8fc40020 	lw	a0,32(s8)
  800288:	8fc50024 	lw	a1,36(s8)
  80028c:	8fc60028 	lw	a2,40(s8)
  800290:	0c2004c5 	jal	801314 <sys_read>
  800294:	00000000 	nop
}
  800298:	03c0e821 	move	sp,s8
  80029c:	8fbf001c 	lw	ra,28(sp)
  8002a0:	8fbe0018 	lw	s8,24(sp)
  8002a4:	27bd0020 	addiu	sp,sp,32
  8002a8:	03e00008 	jr	ra
  8002ac:	00000000 	nop

008002b0 <write>:

int
write(int fd, void *base, size_t len) {
  8002b0:	27bdffe0 	addiu	sp,sp,-32
  8002b4:	afbf001c 	sw	ra,28(sp)
  8002b8:	afbe0018 	sw	s8,24(sp)
  8002bc:	03a0f021 	move	s8,sp
  8002c0:	afc40020 	sw	a0,32(s8)
  8002c4:	afc50024 	sw	a1,36(s8)
  8002c8:	afc60028 	sw	a2,40(s8)
    return sys_write(fd, base, len);
  8002cc:	8fc40020 	lw	a0,32(s8)
  8002d0:	8fc50024 	lw	a1,36(s8)
  8002d4:	8fc60028 	lw	a2,40(s8)
  8002d8:	0c2004d8 	jal	801360 <sys_write>
  8002dc:	00000000 	nop
}
  8002e0:	03c0e821 	move	sp,s8
  8002e4:	8fbf001c 	lw	ra,28(sp)
  8002e8:	8fbe0018 	lw	s8,24(sp)
  8002ec:	27bd0020 	addiu	sp,sp,32
  8002f0:	03e00008 	jr	ra
  8002f4:	00000000 	nop

008002f8 <seek>:

int
seek(int fd, off_t pos, int whence) {
  8002f8:	27bdffe0 	addiu	sp,sp,-32
  8002fc:	afbf001c 	sw	ra,28(sp)
  800300:	afbe0018 	sw	s8,24(sp)
  800304:	03a0f021 	move	s8,sp
  800308:	afc40020 	sw	a0,32(s8)
  80030c:	afc50024 	sw	a1,36(s8)
  800310:	afc60028 	sw	a2,40(s8)
    return sys_seek(fd, pos, whence);
  800314:	8fc40020 	lw	a0,32(s8)
  800318:	8fc50024 	lw	a1,36(s8)
  80031c:	8fc60028 	lw	a2,40(s8)
  800320:	0c2004eb 	jal	8013ac <sys_seek>
  800324:	00000000 	nop
}
  800328:	03c0e821 	move	sp,s8
  80032c:	8fbf001c 	lw	ra,28(sp)
  800330:	8fbe0018 	lw	s8,24(sp)
  800334:	27bd0020 	addiu	sp,sp,32
  800338:	03e00008 	jr	ra
  80033c:	00000000 	nop

00800340 <fstat>:

int
fstat(int fd, struct stat *stat) {
  800340:	27bdffe0 	addiu	sp,sp,-32
  800344:	afbf001c 	sw	ra,28(sp)
  800348:	afbe0018 	sw	s8,24(sp)
  80034c:	03a0f021 	move	s8,sp
  800350:	afc40020 	sw	a0,32(s8)
  800354:	afc50024 	sw	a1,36(s8)
    return sys_fstat(fd, stat);
  800358:	8fc40020 	lw	a0,32(s8)
  80035c:	8fc50024 	lw	a1,36(s8)
  800360:	0c2004fe 	jal	8013f8 <sys_fstat>
  800364:	00000000 	nop
}
  800368:	03c0e821 	move	sp,s8
  80036c:	8fbf001c 	lw	ra,28(sp)
  800370:	8fbe0018 	lw	s8,24(sp)
  800374:	27bd0020 	addiu	sp,sp,32
  800378:	03e00008 	jr	ra
  80037c:	00000000 	nop

00800380 <fsync>:

int
fsync(int fd) {
  800380:	27bdffe0 	addiu	sp,sp,-32
  800384:	afbf001c 	sw	ra,28(sp)
  800388:	afbe0018 	sw	s8,24(sp)
  80038c:	03a0f021 	move	s8,sp
  800390:	afc40020 	sw	a0,32(s8)
    return sys_fsync(fd);
  800394:	8fc40020 	lw	a0,32(s8)
  800398:	0c20050f 	jal	80143c <sys_fsync>
  80039c:	00000000 	nop
}
  8003a0:	03c0e821 	move	sp,s8
  8003a4:	8fbf001c 	lw	ra,28(sp)
  8003a8:	8fbe0018 	lw	s8,24(sp)
  8003ac:	27bd0020 	addiu	sp,sp,32
  8003b0:	03e00008 	jr	ra
  8003b4:	00000000 	nop

008003b8 <dup2>:

int
dup2(int fd1, int fd2) {
  8003b8:	27bdffe0 	addiu	sp,sp,-32
  8003bc:	afbf001c 	sw	ra,28(sp)
  8003c0:	afbe0018 	sw	s8,24(sp)
  8003c4:	03a0f021 	move	s8,sp
  8003c8:	afc40020 	sw	a0,32(s8)
  8003cc:	afc50024 	sw	a1,36(s8)
    return sys_dup(fd1, fd2);
  8003d0:	8fc40020 	lw	a0,32(s8)
  8003d4:	8fc50024 	lw	a1,36(s8)
  8003d8:	0c200540 	jal	801500 <sys_dup>
  8003dc:	00000000 	nop
}
  8003e0:	03c0e821 	move	sp,s8
  8003e4:	8fbf001c 	lw	ra,28(sp)
  8003e8:	8fbe0018 	lw	s8,24(sp)
  8003ec:	27bd0020 	addiu	sp,sp,32
  8003f0:	03e00008 	jr	ra
  8003f4:	00000000 	nop

008003f8 <transmode>:

static char
transmode(struct stat *stat) {
  8003f8:	27bdffe8 	addiu	sp,sp,-24
  8003fc:	afbe0014 	sw	s8,20(sp)
  800400:	03a0f021 	move	s8,sp
  800404:	afc40018 	sw	a0,24(s8)
    uint32_t mode = stat->st_mode;
  800408:	8fc20018 	lw	v0,24(s8)
  80040c:	8c420000 	lw	v0,0(v0)
  800410:	afc20008 	sw	v0,8(s8)
    if (S_ISREG(mode)) return 'r';
  800414:	8fc20008 	lw	v0,8(s8)
  800418:	30437000 	andi	v1,v0,0x7000
  80041c:	24021000 	li	v0,4096
  800420:	14620004 	bne	v1,v0,800434 <transmode+0x3c>
  800424:	00000000 	nop
  800428:	24020072 	li	v0,114
  80042c:	0820012e 	j	8004b8 <transmode+0xc0>
  800430:	00000000 	nop
    if (S_ISDIR(mode)) return 'd';
  800434:	8fc20008 	lw	v0,8(s8)
  800438:	30437000 	andi	v1,v0,0x7000
  80043c:	24022000 	li	v0,8192
  800440:	14620004 	bne	v1,v0,800454 <transmode+0x5c>
  800444:	00000000 	nop
  800448:	24020064 	li	v0,100
  80044c:	0820012e 	j	8004b8 <transmode+0xc0>
  800450:	00000000 	nop
    if (S_ISLNK(mode)) return 'l';
  800454:	8fc20008 	lw	v0,8(s8)
  800458:	30437000 	andi	v1,v0,0x7000
  80045c:	24023000 	li	v0,12288
  800460:	14620004 	bne	v1,v0,800474 <transmode+0x7c>
  800464:	00000000 	nop
  800468:	2402006c 	li	v0,108
  80046c:	0820012e 	j	8004b8 <transmode+0xc0>
  800470:	00000000 	nop
    if (S_ISCHR(mode)) return 'c';
  800474:	8fc20008 	lw	v0,8(s8)
  800478:	30437000 	andi	v1,v0,0x7000
  80047c:	24024000 	li	v0,16384
  800480:	14620004 	bne	v1,v0,800494 <transmode+0x9c>
  800484:	00000000 	nop
  800488:	24020063 	li	v0,99
  80048c:	0820012e 	j	8004b8 <transmode+0xc0>
  800490:	00000000 	nop
    if (S_ISBLK(mode)) return 'b';
  800494:	8fc20008 	lw	v0,8(s8)
  800498:	30437000 	andi	v1,v0,0x7000
  80049c:	24025000 	li	v0,20480
  8004a0:	14620004 	bne	v1,v0,8004b4 <transmode+0xbc>
  8004a4:	00000000 	nop
  8004a8:	24020062 	li	v0,98
  8004ac:	0820012e 	j	8004b8 <transmode+0xc0>
  8004b0:	00000000 	nop
    return '-';
  8004b4:	2402002d 	li	v0,45
}
  8004b8:	03c0e821 	move	sp,s8
  8004bc:	8fbe0014 	lw	s8,20(sp)
  8004c0:	27bd0018 	addiu	sp,sp,24
  8004c4:	03e00008 	jr	ra
  8004c8:	00000000 	nop

008004cc <print_stat>:

void
print_stat(const char *name, int fd, struct stat *stat) {
  8004cc:	27bdffe0 	addiu	sp,sp,-32
  8004d0:	afbf001c 	sw	ra,28(sp)
  8004d4:	afbe0018 	sw	s8,24(sp)
  8004d8:	03a0f021 	move	s8,sp
  8004dc:	afc40020 	sw	a0,32(s8)
  8004e0:	afc50024 	sw	a1,36(s8)
  8004e4:	afc60028 	sw	a2,40(s8)
    cprintf("[%03d] %s\n", fd, name);
  8004e8:	3c020080 	lui	v0,0x80
  8004ec:	24443850 	addiu	a0,v0,14416
  8004f0:	8fc50024 	lw	a1,36(s8)
  8004f4:	8fc60020 	lw	a2,32(s8)
  8004f8:	0c2002bd 	jal	800af4 <cprintf>
  8004fc:	00000000 	nop
    cprintf("    mode    : %c\n", transmode(stat));
  800500:	8fc40028 	lw	a0,40(s8)
  800504:	0c2000fe 	jal	8003f8 <transmode>
  800508:	00000000 	nop
  80050c:	3c030080 	lui	v1,0x80
  800510:	2464385c 	addiu	a0,v1,14428
  800514:	00402821 	move	a1,v0
  800518:	0c2002bd 	jal	800af4 <cprintf>
  80051c:	00000000 	nop
    cprintf("    links   : %lu\n", stat->st_nlinks);
  800520:	8fc20028 	lw	v0,40(s8)
  800524:	8c420004 	lw	v0,4(v0)
  800528:	3c030080 	lui	v1,0x80
  80052c:	24643870 	addiu	a0,v1,14448
  800530:	00402821 	move	a1,v0
  800534:	0c2002bd 	jal	800af4 <cprintf>
  800538:	00000000 	nop
    cprintf("    blocks  : %lu\n", stat->st_blocks);
  80053c:	8fc20028 	lw	v0,40(s8)
  800540:	8c420008 	lw	v0,8(v0)
  800544:	3c030080 	lui	v1,0x80
  800548:	24643884 	addiu	a0,v1,14468
  80054c:	00402821 	move	a1,v0
  800550:	0c2002bd 	jal	800af4 <cprintf>
  800554:	00000000 	nop
    cprintf("    size    : %lu\n", stat->st_size);
  800558:	8fc20028 	lw	v0,40(s8)
  80055c:	8c42000c 	lw	v0,12(v0)
  800560:	3c030080 	lui	v1,0x80
  800564:	24643898 	addiu	a0,v1,14488
  800568:	00402821 	move	a1,v0
  80056c:	0c2002bd 	jal	800af4 <cprintf>
  800570:	00000000 	nop
}
  800574:	03c0e821 	move	sp,s8
  800578:	8fbf001c 	lw	ra,28(sp)
  80057c:	8fbe0018 	lw	s8,24(sp)
  800580:	27bd0020 	addiu	sp,sp,32
  800584:	03e00008 	jr	ra
  800588:	00000000 	nop
  80058c:	00000000 	nop

00800590 <_start>:
.text
.globl _start
_start:
    # load argc and argv
    # pass through load_icode
    addiu   $sp, $sp, -0x10
  800590:	27bdfff0 0c200648 00000000 08200167     ...'H. .....g. .
	...

008005b0 <_Alloc>:

static char buf[4096];

static char bufx[4096];

void* _Alloc(int n) {
  8005b0:	27bdffe8 	addiu	sp,sp,-24
  8005b4:	afbe0014 	sw	s8,20(sp)
  8005b8:	03a0f021 	move	s8,sp
  8005bc:	afc40018 	sw	a0,24(s8)
    static char* cur = buf;
    char* p;
    if((cur+n)>=(buf+4096)){
  8005c0:	3c020080 	lui	v0,0x80
  8005c4:	8c434010 	lw	v1,16400(v0)
  8005c8:	8fc20018 	lw	v0,24(s8)
  8005cc:	00621821 	addu	v1,v1,v0
  8005d0:	3c020080 	lui	v0,0x80
  8005d4:	24425050 	addiu	v0,v0,20560
  8005d8:	0062102b 	sltu	v0,v1,v0
  8005dc:	1440000a 	bnez	v0,800608 <_Alloc+0x58>
  8005e0:	00000000 	nop
        cur = buf;
  8005e4:	3c020080 	lui	v0,0x80
  8005e8:	3c030080 	lui	v1,0x80
  8005ec:	24634050 	addiu	v1,v1,16464
  8005f0:	ac434010 	sw	v1,16400(v0)
        p = buf;
  8005f4:	3c020080 	lui	v0,0x80
  8005f8:	24424050 	addiu	v0,v0,16464
  8005fc:	afc20008 	sw	v0,8(s8)
  800600:	0820018b 	j	80062c <_Alloc+0x7c>
  800604:	00000000 	nop
    }
    else{
        p = cur;
  800608:	3c020080 	lui	v0,0x80
  80060c:	8c424010 	lw	v0,16400(v0)
  800610:	afc20008 	sw	v0,8(s8)
        cur += n;
  800614:	3c020080 	lui	v0,0x80
  800618:	8c434010 	lw	v1,16400(v0)
  80061c:	8fc20018 	lw	v0,24(s8)
  800620:	00621821 	addu	v1,v1,v0
  800624:	3c020080 	lui	v0,0x80
  800628:	ac434010 	sw	v1,16400(v0)
    }
    return p;
  80062c:	8fc20008 	lw	v0,8(s8)
}
  800630:	03c0e821 	move	sp,s8
  800634:	8fbe0014 	lw	s8,20(sp)
  800638:	27bd0018 	addiu	sp,sp,24
  80063c:	03e00008 	jr	ra
  800640:	00000000 	nop

00800644 <stralloc>:

void* stralloc(int n){
  800644:	27bdffe8 	addiu	sp,sp,-24
  800648:	afbe0014 	sw	s8,20(sp)
  80064c:	03a0f021 	move	s8,sp
  800650:	afc40018 	sw	a0,24(s8)
    static char* cur = bufx;
    char* p;
    if((cur+n)>=(bufx+4096)){
  800654:	3c020080 	lui	v0,0x80
  800658:	8c434014 	lw	v1,16404(v0)
  80065c:	8fc20018 	lw	v0,24(s8)
  800660:	00621821 	addu	v1,v1,v0
  800664:	3c020080 	lui	v0,0x80
  800668:	24426050 	addiu	v0,v0,24656
  80066c:	0062102b 	sltu	v0,v1,v0
  800670:	1440000a 	bnez	v0,80069c <stralloc+0x58>
  800674:	00000000 	nop
        cur = bufx;
  800678:	3c020080 	lui	v0,0x80
  80067c:	3c030080 	lui	v1,0x80
  800680:	24635050 	addiu	v1,v1,20560
  800684:	ac434014 	sw	v1,16404(v0)
        p = bufx;
  800688:	3c020080 	lui	v0,0x80
  80068c:	24425050 	addiu	v0,v0,20560
  800690:	afc20008 	sw	v0,8(s8)
  800694:	082001b0 	j	8006c0 <stralloc+0x7c>
  800698:	00000000 	nop
    }
    else{
        p = cur;
  80069c:	3c020080 	lui	v0,0x80
  8006a0:	8c424014 	lw	v0,16404(v0)
  8006a4:	afc20008 	sw	v0,8(s8)
        cur += n;
  8006a8:	3c020080 	lui	v0,0x80
  8006ac:	8c434014 	lw	v1,16404(v0)
  8006b0:	8fc20018 	lw	v0,24(s8)
  8006b4:	00621821 	addu	v1,v1,v0
  8006b8:	3c020080 	lui	v0,0x80
  8006bc:	ac434014 	sw	v1,16404(v0)
    }
    return p;
  8006c0:	8fc20008 	lw	v0,8(s8)
}
  8006c4:	03c0e821 	move	sp,s8
  8006c8:	8fbe0014 	lw	s8,20(sp)
  8006cc:	27bd0018 	addiu	sp,sp,24
  8006d0:	03e00008 	jr	ra
  8006d4:	00000000 	nop

008006d8 <_PrintInt>:

void _PrintInt(int x) {
  8006d8:	27bdffe0 	addiu	sp,sp,-32
  8006dc:	afbf001c 	sw	ra,28(sp)
  8006e0:	afbe0018 	sw	s8,24(sp)
  8006e4:	03a0f021 	move	s8,sp
  8006e8:	afc40020 	sw	a0,32(s8)
    cprintf("%d", x);
  8006ec:	3c020080 	lui	v0,0x80
  8006f0:	244438b0 	addiu	a0,v0,14512
  8006f4:	8fc50020 	lw	a1,32(s8)
  8006f8:	0c2002bd 	jal	800af4 <cprintf>
  8006fc:	00000000 	nop
}
  800700:	03c0e821 	move	sp,s8
  800704:	8fbf001c 	lw	ra,28(sp)
  800708:	8fbe0018 	lw	s8,24(sp)
  80070c:	27bd0020 	addiu	sp,sp,32
  800710:	03e00008 	jr	ra
  800714:	00000000 	nop

00800718 <_PrintChar>:
void _PrintChar(char x) {
  800718:	27bdffe0 	addiu	sp,sp,-32
  80071c:	afbf001c 	sw	ra,28(sp)
  800720:	afbe0018 	sw	s8,24(sp)
  800724:	03a0f021 	move	s8,sp
  800728:	00801021 	move	v0,a0
  80072c:	a3c20020 	sb	v0,32(s8)
    cprintf("%c", x);
  800730:	83c20020 	lb	v0,32(s8)
  800734:	3c030080 	lui	v1,0x80
  800738:	246438b4 	addiu	a0,v1,14516
  80073c:	00402821 	move	a1,v0
  800740:	0c2002bd 	jal	800af4 <cprintf>
  800744:	00000000 	nop
}
  800748:	03c0e821 	move	sp,s8
  80074c:	8fbf001c 	lw	ra,28(sp)
  800750:	8fbe0018 	lw	s8,24(sp)
  800754:	27bd0020 	addiu	sp,sp,32
  800758:	03e00008 	jr	ra
  80075c:	00000000 	nop

00800760 <_PrintString>:
void _PrintString(const char* x) {
  800760:	27bdffe0 	addiu	sp,sp,-32
  800764:	afbf001c 	sw	ra,28(sp)
  800768:	afbe0018 	sw	s8,24(sp)
  80076c:	03a0f021 	move	s8,sp
  800770:	afc40020 	sw	a0,32(s8)
    cprintf("%s", x);
  800774:	3c020080 	lui	v0,0x80
  800778:	244438b8 	addiu	a0,v0,14520
  80077c:	8fc50020 	lw	a1,32(s8)
  800780:	0c2002bd 	jal	800af4 <cprintf>
  800784:	00000000 	nop
}
  800788:	03c0e821 	move	sp,s8
  80078c:	8fbf001c 	lw	ra,28(sp)
  800790:	8fbe0018 	lw	s8,24(sp)
  800794:	27bd0020 	addiu	sp,sp,32
  800798:	03e00008 	jr	ra
  80079c:	00000000 	nop

008007a0 <_PrintBool>:
void _PrintBool(bool x) {
  8007a0:	27bdffe0 	addiu	sp,sp,-32
  8007a4:	afbf001c 	sw	ra,28(sp)
  8007a8:	afbe0018 	sw	s8,24(sp)
  8007ac:	03a0f021 	move	s8,sp
  8007b0:	afc40020 	sw	a0,32(s8)
    if (x)
  8007b4:	8fc20020 	lw	v0,32(s8)
  8007b8:	10400007 	beqz	v0,8007d8 <_PrintBool+0x38>
  8007bc:	00000000 	nop
        cprintf("true");
  8007c0:	3c020080 	lui	v0,0x80
  8007c4:	244438bc 	addiu	a0,v0,14524
  8007c8:	0c2002bd 	jal	800af4 <cprintf>
  8007cc:	00000000 	nop
  8007d0:	082001fa 	j	8007e8 <_PrintBool+0x48>
  8007d4:	00000000 	nop
    else
        cprintf("false");
  8007d8:	3c020080 	lui	v0,0x80
  8007dc:	244438c4 	addiu	a0,v0,14532
  8007e0:	0c2002bd 	jal	800af4 <cprintf>
  8007e4:	00000000 	nop
}
  8007e8:	03c0e821 	move	sp,s8
  8007ec:	8fbf001c 	lw	ra,28(sp)
  8007f0:	8fbe0018 	lw	s8,24(sp)
  8007f4:	27bd0020 	addiu	sp,sp,32
  8007f8:	03e00008 	jr	ra
  8007fc:	00000000 	nop

00800800 <_Halt>:
void __noreturn _Halt(void) {
  800800:	27bdffe0 	addiu	sp,sp,-32
  800804:	afbf001c 	sw	ra,28(sp)
  800808:	afbe0018 	sw	s8,24(sp)
  80080c:	03a0f021 	move	s8,sp
    exit(0);
  800810:	00002021 	move	a0,zero
  800814:	0c200560 	jal	801580 <exit>
  800818:	00000000 	nop

0080081c <_ReadLine>:
}
char* _ReadLine(void){
  80081c:	27bdffd0 	addiu	sp,sp,-48
  800820:	afbf002c 	sw	ra,44(sp)
  800824:	afbe0028 	sw	s8,40(sp)
  800828:	03a0f021 	move	s8,sp
    char* r = readline(NULL);
  80082c:	00002021 	move	a0,zero
  800830:	0c20033f 	jal	800cfc <readline>
  800834:	00000000 	nop
  800838:	afc20018 	sw	v0,24(s8)
    int n = strlen(r);
  80083c:	8fc40018 	lw	a0,24(s8)
  800840:	0c200a34 	jal	8028d0 <strlen>
  800844:	00000000 	nop
  800848:	afc2001c 	sw	v0,28(s8)
    char* a = stralloc(n+1);
  80084c:	8fc2001c 	lw	v0,28(s8)
  800850:	24420001 	addiu	v0,v0,1
  800854:	00402021 	move	a0,v0
  800858:	0c200191 	jal	800644 <stralloc>
  80085c:	00000000 	nop
  800860:	afc20020 	sw	v0,32(s8)
    
    memcpy(a,r,n);
  800864:	8fc40020 	lw	a0,32(s8)
  800868:	8fc50018 	lw	a1,24(s8)
  80086c:	8fc6001c 	lw	a2,28(s8)
  800870:	0c200c53 	jal	80314c <memcpy>
  800874:	00000000 	nop
    a[n]='\0';
  800878:	8fc2001c 	lw	v0,28(s8)
  80087c:	8fc30020 	lw	v1,32(s8)
  800880:	00621021 	addu	v0,v1,v0
  800884:	a0400000 	sb	zero,0(v0)
    return a;
  800888:	8fc20020 	lw	v0,32(s8)
}
  80088c:	03c0e821 	move	sp,s8
  800890:	8fbf002c 	lw	ra,44(sp)
  800894:	8fbe0028 	lw	s8,40(sp)
  800898:	27bd0030 	addiu	sp,sp,48
  80089c:	03e00008 	jr	ra
  8008a0:	00000000 	nop

008008a4 <_StringEqual>:

int _StringEqual(char* a,char* b){
  8008a4:	27bdffe0 	addiu	sp,sp,-32
  8008a8:	afbf001c 	sw	ra,28(sp)
  8008ac:	afbe0018 	sw	s8,24(sp)
  8008b0:	03a0f021 	move	s8,sp
  8008b4:	afc40020 	sw	a0,32(s8)
  8008b8:	afc50024 	sw	a1,36(s8)
	if(strcmp(a,b)==0)
  8008bc:	8fc40020 	lw	a0,32(s8)
  8008c0:	8fc50024 	lw	a1,36(s8)
  8008c4:	0c200ab8 	jal	802ae0 <strcmp>
  8008c8:	00000000 	nop
  8008cc:	14400004 	bnez	v0,8008e0 <_StringEqual+0x3c>
  8008d0:	00000000 	nop
		return 1;
  8008d4:	24020001 	li	v0,1
  8008d8:	08200239 	j	8008e4 <_StringEqual+0x40>
  8008dc:	00000000 	nop
	else
		return 0;
  8008e0:	00001021 	move	v0,zero
}
  8008e4:	03c0e821 	move	sp,s8
  8008e8:	8fbf001c 	lw	ra,28(sp)
  8008ec:	8fbe0018 	lw	s8,24(sp)
  8008f0:	27bd0020 	addiu	sp,sp,32
  8008f4:	03e00008 	jr	ra
  8008f8:	00000000 	nop

008008fc <_ReadInteger>:

int _ReadInteger(void){
  8008fc:	27bdffd8 	addiu	sp,sp,-40
  800900:	afbf0024 	sw	ra,36(sp)
  800904:	afbe0020 	sw	s8,32(sp)
  800908:	03a0f021 	move	s8,sp
	char* str = readline(NULL);
  80090c:	00002021 	move	a0,zero
  800910:	0c20033f 	jal	800cfc <readline>
  800914:	00000000 	nop
  800918:	afc20018 	sw	v0,24(s8)
	return strtol(str,NULL,10);
  80091c:	8fc40018 	lw	a0,24(s8)
  800920:	00002821 	move	a1,zero
  800924:	2406000a 	li	a2,10
  800928:	0c200b46 	jal	802d18 <strtol>
  80092c:	00000000 	nop
}
  800930:	03c0e821 	move	sp,s8
  800934:	8fbf0024 	lw	ra,36(sp)
  800938:	8fbe0020 	lw	s8,32(sp)
  80093c:	27bd0028 	addiu	sp,sp,40
  800940:	03e00008 	jr	ra
  800944:	00000000 	nop
	...

00800950 <__panic>:
#include <stdio.h>
#include <ulib.h>
#include <error.h>

void
__panic(const char *file, int line, const char *fmt, ...) {
  800950:	27bdffd8 	addiu	sp,sp,-40
  800954:	afbf0024 	sw	ra,36(sp)
  800958:	afbe0020 	sw	s8,32(sp)
  80095c:	03a0f021 	move	s8,sp
  800960:	afc40028 	sw	a0,40(s8)
  800964:	afc5002c 	sw	a1,44(s8)
  800968:	afc70034 	sw	a3,52(s8)
  80096c:	afc60030 	sw	a2,48(s8)
    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  800970:	27c20034 	addiu	v0,s8,52
  800974:	afc20018 	sw	v0,24(s8)
    cprintf("user panic at %s:%d:\n    ", file, line);
  800978:	3c020080 	lui	v0,0x80
  80097c:	244438d0 	addiu	a0,v0,14544
  800980:	8fc50028 	lw	a1,40(s8)
  800984:	8fc6002c 	lw	a2,44(s8)
  800988:	0c2002bd 	jal	800af4 <cprintf>
  80098c:	00000000 	nop
    vcprintf(fmt, ap);
  800990:	8fc20018 	lw	v0,24(s8)
  800994:	8fc40030 	lw	a0,48(s8)
  800998:	00402821 	move	a1,v0
  80099c:	0c2002a4 	jal	800a90 <vcprintf>
  8009a0:	00000000 	nop
    cprintf("\n");
  8009a4:	3c020080 	lui	v0,0x80
  8009a8:	244438ec 	addiu	a0,v0,14572
  8009ac:	0c2002bd 	jal	800af4 <cprintf>
  8009b0:	00000000 	nop
    va_end(ap);
    exit(-E_PANIC);
  8009b4:	2404fff6 	li	a0,-10
  8009b8:	0c200560 	jal	801580 <exit>
  8009bc:	00000000 	nop

008009c0 <__warn>:
}

void
__warn(const char *file, int line, const char *fmt, ...) {
  8009c0:	27bdffd8 	addiu	sp,sp,-40
  8009c4:	afbf0024 	sw	ra,36(sp)
  8009c8:	afbe0020 	sw	s8,32(sp)
  8009cc:	03a0f021 	move	s8,sp
  8009d0:	afc40028 	sw	a0,40(s8)
  8009d4:	afc5002c 	sw	a1,44(s8)
  8009d8:	afc70034 	sw	a3,52(s8)
  8009dc:	afc60030 	sw	a2,48(s8)
    va_list ap;
    va_start(ap, fmt);
  8009e0:	27c20034 	addiu	v0,s8,52
  8009e4:	afc20018 	sw	v0,24(s8)
    cprintf("user warning at %s:%d:\n    ", file, line);
  8009e8:	3c020080 	lui	v0,0x80
  8009ec:	244438f0 	addiu	a0,v0,14576
  8009f0:	8fc50028 	lw	a1,40(s8)
  8009f4:	8fc6002c 	lw	a2,44(s8)
  8009f8:	0c2002bd 	jal	800af4 <cprintf>
  8009fc:	00000000 	nop
    vcprintf(fmt, ap);
  800a00:	8fc20018 	lw	v0,24(s8)
  800a04:	8fc40030 	lw	a0,48(s8)
  800a08:	00402821 	move	a1,v0
  800a0c:	0c2002a4 	jal	800a90 <vcprintf>
  800a10:	00000000 	nop
    cprintf("\n");
  800a14:	3c020080 	lui	v0,0x80
  800a18:	244438ec 	addiu	a0,v0,14572
  800a1c:	0c2002bd 	jal	800af4 <cprintf>
  800a20:	00000000 	nop
    va_end(ap);
}
  800a24:	03c0e821 	move	sp,s8
  800a28:	8fbf0024 	lw	ra,36(sp)
  800a2c:	8fbe0020 	lw	s8,32(sp)
  800a30:	27bd0028 	addiu	sp,sp,40
  800a34:	03e00008 	jr	ra
  800a38:	00000000 	nop
  800a3c:	00000000 	nop

00800a40 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  800a40:	27bdffe0 	addiu	sp,sp,-32
  800a44:	afbf001c 	sw	ra,28(sp)
  800a48:	afbe0018 	sw	s8,24(sp)
  800a4c:	03a0f021 	move	s8,sp
  800a50:	afc40020 	sw	a0,32(s8)
  800a54:	afc50024 	sw	a1,36(s8)
    sys_putc(c);
  800a58:	8fc40020 	lw	a0,32(s8)
  800a5c:	0c20044b 	jal	80112c <sys_putc>
  800a60:	00000000 	nop
    (*cnt) ++;
  800a64:	8fc20024 	lw	v0,36(s8)
  800a68:	8c420000 	lw	v0,0(v0)
  800a6c:	24430001 	addiu	v1,v0,1
  800a70:	8fc20024 	lw	v0,36(s8)
  800a74:	ac430000 	sw	v1,0(v0)
}
  800a78:	03c0e821 	move	sp,s8
  800a7c:	8fbf001c 	lw	ra,28(sp)
  800a80:	8fbe0018 	lw	s8,24(sp)
  800a84:	27bd0020 	addiu	sp,sp,32
  800a88:	03e00008 	jr	ra
  800a8c:	00000000 	nop

00800a90 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  800a90:	27bdffd0 	addiu	sp,sp,-48
  800a94:	afbf002c 	sw	ra,44(sp)
  800a98:	afbe0028 	sw	s8,40(sp)
  800a9c:	03a0f021 	move	s8,sp
  800aa0:	afc40030 	sw	a0,48(s8)
  800aa4:	afc50034 	sw	a1,52(s8)
    int cnt = 0;
  800aa8:	afc00020 	sw	zero,32(s8)
    vprintfmt((void*)cputch, NO_FD, &cnt, fmt, ap);
  800aac:	8fc20034 	lw	v0,52(s8)
  800ab0:	afa20010 	sw	v0,16(sp)
  800ab4:	3c020080 	lui	v0,0x80
  800ab8:	24440a40 	addiu	a0,v0,2624
  800abc:	3c02ffff 	lui	v0,0xffff
  800ac0:	34456ad9 	ori	a1,v0,0x6ad9
  800ac4:	27c20020 	addiu	v0,s8,32
  800ac8:	00403021 	move	a2,v0
  800acc:	8fc70030 	lw	a3,48(s8)
  800ad0:	0c2007ef 	jal	801fbc <vprintfmt>
  800ad4:	00000000 	nop
    return cnt;
  800ad8:	8fc20020 	lw	v0,32(s8)
}
  800adc:	03c0e821 	move	sp,s8
  800ae0:	8fbf002c 	lw	ra,44(sp)
  800ae4:	8fbe0028 	lw	s8,40(sp)
  800ae8:	27bd0030 	addiu	sp,sp,48
  800aec:	03e00008 	jr	ra
  800af0:	00000000 	nop

00800af4 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  800af4:	27bdffd8 	addiu	sp,sp,-40
  800af8:	afbf0024 	sw	ra,36(sp)
  800afc:	afbe0020 	sw	s8,32(sp)
  800b00:	03a0f021 	move	s8,sp
  800b04:	afc5002c 	sw	a1,44(s8)
  800b08:	afc60030 	sw	a2,48(s8)
  800b0c:	afc70034 	sw	a3,52(s8)
  800b10:	afc40028 	sw	a0,40(s8)
    va_list ap;

    va_start(ap, fmt);
  800b14:	27c2002c 	addiu	v0,s8,44
  800b18:	afc2001c 	sw	v0,28(s8)
    int cnt = vcprintf(fmt, ap);
  800b1c:	8fc2001c 	lw	v0,28(s8)
  800b20:	8fc40028 	lw	a0,40(s8)
  800b24:	00402821 	move	a1,v0
  800b28:	0c2002a4 	jal	800a90 <vcprintf>
  800b2c:	00000000 	nop
  800b30:	afc20018 	sw	v0,24(s8)
    va_end(ap);

    return cnt;
  800b34:	8fc20018 	lw	v0,24(s8)
}
  800b38:	03c0e821 	move	sp,s8
  800b3c:	8fbf0024 	lw	ra,36(sp)
  800b40:	8fbe0020 	lw	s8,32(sp)
  800b44:	27bd0028 	addiu	sp,sp,40
  800b48:	03e00008 	jr	ra
  800b4c:	00000000 	nop

00800b50 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  800b50:	27bdffd8 	addiu	sp,sp,-40
  800b54:	afbf0024 	sw	ra,36(sp)
  800b58:	afbe0020 	sw	s8,32(sp)
  800b5c:	03a0f021 	move	s8,sp
  800b60:	afc40028 	sw	a0,40(s8)
    int cnt = 0;
  800b64:	afc0001c 	sw	zero,28(s8)
    char c;
    while ((c = *str ++) != '\0') {
  800b68:	082002e2 	j	800b88 <cputs+0x38>
  800b6c:	00000000 	nop
        cputch(c, &cnt);
  800b70:	83c30018 	lb	v1,24(s8)
  800b74:	27c2001c 	addiu	v0,s8,28
  800b78:	00602021 	move	a0,v1
  800b7c:	00402821 	move	a1,v0
  800b80:	0c200290 	jal	800a40 <cputch>
  800b84:	00000000 	nop
 * */
int
cputs(const char *str) {
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
  800b88:	8fc20028 	lw	v0,40(s8)
  800b8c:	24430001 	addiu	v1,v0,1
  800b90:	afc30028 	sw	v1,40(s8)
  800b94:	90420000 	lbu	v0,0(v0)
  800b98:	a3c20018 	sb	v0,24(s8)
  800b9c:	83c20018 	lb	v0,24(s8)
  800ba0:	1440fff3 	bnez	v0,800b70 <cputs+0x20>
  800ba4:	00000000 	nop
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
  800ba8:	27c2001c 	addiu	v0,s8,28
  800bac:	2404000a 	li	a0,10
  800bb0:	00402821 	move	a1,v0
  800bb4:	0c200290 	jal	800a40 <cputch>
  800bb8:	00000000 	nop
    return cnt;
  800bbc:	8fc2001c 	lw	v0,28(s8)
}
  800bc0:	03c0e821 	move	sp,s8
  800bc4:	8fbf0024 	lw	ra,36(sp)
  800bc8:	8fbe0020 	lw	s8,32(sp)
  800bcc:	27bd0028 	addiu	sp,sp,40
  800bd0:	03e00008 	jr	ra
  800bd4:	00000000 	nop

00800bd8 <fputch>:


static void
fputch(char c, int *cnt, int fd) {
  800bd8:	27bdffe0 	addiu	sp,sp,-32
  800bdc:	afbf001c 	sw	ra,28(sp)
  800be0:	afbe0018 	sw	s8,24(sp)
  800be4:	03a0f021 	move	s8,sp
  800be8:	00801021 	move	v0,a0
  800bec:	afc50024 	sw	a1,36(s8)
  800bf0:	afc60028 	sw	a2,40(s8)
  800bf4:	a3c20020 	sb	v0,32(s8)
    write(fd, &c, sizeof(char));
  800bf8:	8fc40028 	lw	a0,40(s8)
  800bfc:	27c50020 	addiu	a1,s8,32
  800c00:	24060001 	li	a2,1
  800c04:	0c2000ac 	jal	8002b0 <write>
  800c08:	00000000 	nop
    (*cnt) ++;
  800c0c:	8fc20024 	lw	v0,36(s8)
  800c10:	8c420000 	lw	v0,0(v0)
  800c14:	24430001 	addiu	v1,v0,1
  800c18:	8fc20024 	lw	v0,36(s8)
  800c1c:	ac430000 	sw	v1,0(v0)
}
  800c20:	03c0e821 	move	sp,s8
  800c24:	8fbf001c 	lw	ra,28(sp)
  800c28:	8fbe0018 	lw	s8,24(sp)
  800c2c:	27bd0020 	addiu	sp,sp,32
  800c30:	03e00008 	jr	ra
  800c34:	00000000 	nop

00800c38 <vfprintf>:

int
vfprintf(int fd, const char *fmt, va_list ap) {
  800c38:	27bdffd0 	addiu	sp,sp,-48
  800c3c:	afbf002c 	sw	ra,44(sp)
  800c40:	afbe0028 	sw	s8,40(sp)
  800c44:	03a0f021 	move	s8,sp
  800c48:	afc40030 	sw	a0,48(s8)
  800c4c:	afc50034 	sw	a1,52(s8)
  800c50:	afc60038 	sw	a2,56(s8)
    int cnt = 0;
  800c54:	afc00020 	sw	zero,32(s8)
    vprintfmt((void*)fputch, fd, &cnt, fmt, ap);
  800c58:	8fc20038 	lw	v0,56(s8)
  800c5c:	afa20010 	sw	v0,16(sp)
  800c60:	3c020080 	lui	v0,0x80
  800c64:	24440bd8 	addiu	a0,v0,3032
  800c68:	8fc50030 	lw	a1,48(s8)
  800c6c:	27c20020 	addiu	v0,s8,32
  800c70:	00403021 	move	a2,v0
  800c74:	8fc70034 	lw	a3,52(s8)
  800c78:	0c2007ef 	jal	801fbc <vprintfmt>
  800c7c:	00000000 	nop
    return cnt;
  800c80:	8fc20020 	lw	v0,32(s8)
}
  800c84:	03c0e821 	move	sp,s8
  800c88:	8fbf002c 	lw	ra,44(sp)
  800c8c:	8fbe0028 	lw	s8,40(sp)
  800c90:	27bd0030 	addiu	sp,sp,48
  800c94:	03e00008 	jr	ra
  800c98:	00000000 	nop

00800c9c <fprintf>:

int
fprintf(int fd, const char *fmt, ...) {
  800c9c:	27bdffd8 	addiu	sp,sp,-40
  800ca0:	afbf0024 	sw	ra,36(sp)
  800ca4:	afbe0020 	sw	s8,32(sp)
  800ca8:	03a0f021 	move	s8,sp
  800cac:	afc40028 	sw	a0,40(s8)
  800cb0:	afc60030 	sw	a2,48(s8)
  800cb4:	afc70034 	sw	a3,52(s8)
  800cb8:	afc5002c 	sw	a1,44(s8)
    va_list ap;

    va_start(ap, fmt);
  800cbc:	27c20030 	addiu	v0,s8,48
  800cc0:	afc2001c 	sw	v0,28(s8)
    int cnt = vfprintf(fd, fmt, ap);
  800cc4:	8fc2001c 	lw	v0,28(s8)
  800cc8:	8fc40028 	lw	a0,40(s8)
  800ccc:	8fc5002c 	lw	a1,44(s8)
  800cd0:	00403021 	move	a2,v0
  800cd4:	0c20030e 	jal	800c38 <vfprintf>
  800cd8:	00000000 	nop
  800cdc:	afc20018 	sw	v0,24(s8)
    va_end(ap);

    return cnt;
  800ce0:	8fc20018 	lw	v0,24(s8)
}
  800ce4:	03c0e821 	move	sp,s8
  800ce8:	8fbf0024 	lw	ra,36(sp)
  800cec:	8fbe0020 	lw	s8,32(sp)
  800cf0:	27bd0028 	addiu	sp,sp,40
  800cf4:	03e00008 	jr	ra
  800cf8:	00000000 	nop

00800cfc <readline>:

char *
readline(const char *prompt) {
  800cfc:	27bdffd0 	addiu	sp,sp,-48
  800d00:	afbf002c 	sw	ra,44(sp)
  800d04:	afbe0028 	sw	s8,40(sp)
  800d08:	03a0f021 	move	s8,sp
  800d0c:	afc40030 	sw	a0,48(s8)
    static char buffer[BUFSIZE];
    memset(buffer,0,BUFSIZE);
  800d10:	3c020080 	lui	v0,0x80
  800d14:	24446050 	addiu	a0,v0,24656
  800d18:	00002821 	move	a1,zero
  800d1c:	24061000 	li	a2,4096
  800d20:	0c200bf2 	jal	802fc8 <memset>
  800d24:	00000000 	nop
    if (prompt != NULL) {
  800d28:	8fc20030 	lw	v0,48(s8)
  800d2c:	10400007 	beqz	v0,800d4c <readline+0x50>
  800d30:	00000000 	nop
        printf("%s", prompt);
  800d34:	24040001 	li	a0,1
  800d38:	3c020080 	lui	v0,0x80
  800d3c:	24453910 	addiu	a1,v0,14608
  800d40:	8fc60030 	lw	a2,48(s8)
  800d44:	0c200327 	jal	800c9c <fprintf>
  800d48:	00000000 	nop
    }
    int ret, i = 0;
  800d4c:	afc00018 	sw	zero,24(s8)
    while (1) {
        char c;
        if ((ret = read(0, &c, sizeof(char))) < 0) {
  800d50:	27c20020 	addiu	v0,s8,32
  800d54:	00002021 	move	a0,zero
  800d58:	00402821 	move	a1,v0
  800d5c:	24060001 	li	a2,1
  800d60:	0c20009a 	jal	800268 <read>
  800d64:	00000000 	nop
  800d68:	afc2001c 	sw	v0,28(s8)
  800d6c:	8fc2001c 	lw	v0,28(s8)
  800d70:	04410004 	bgez	v0,800d84 <readline+0x88>
  800d74:	00000000 	nop
            return NULL;
  800d78:	00001021 	move	v0,zero
  800d7c:	082003be 	j	800ef8 <readline+0x1fc>
  800d80:	00000000 	nop
        }
        else if (ret == 0) {
  800d84:	8fc2001c 	lw	v0,28(s8)
  800d88:	1440000e 	bnez	v0,800dc4 <readline+0xc8>
  800d8c:	00000000 	nop
            if (i > 0) {
  800d90:	8fc20018 	lw	v0,24(s8)
  800d94:	18400008 	blez	v0,800db8 <readline+0xbc>
  800d98:	00000000 	nop
                buffer[i] = '\0';
  800d9c:	3c020080 	lui	v0,0x80
  800da0:	24436050 	addiu	v1,v0,24656
  800da4:	8fc20018 	lw	v0,24(s8)
  800da8:	00621021 	addu	v0,v1,v0
  800dac:	a0400000 	sb	zero,0(v0)
                break;
  800db0:	082003bc 	j	800ef0 <readline+0x1f4>
  800db4:	00000000 	nop
            }
            return NULL;
  800db8:	00001021 	move	v0,zero
  800dbc:	082003be 	j	800ef8 <readline+0x1fc>
  800dc0:	00000000 	nop
        }

        if (c == 3) {
  800dc4:	83c30020 	lb	v1,32(s8)
  800dc8:	24020003 	li	v0,3
  800dcc:	14620004 	bne	v1,v0,800de0 <readline+0xe4>
  800dd0:	00000000 	nop
            return NULL;
  800dd4:	00001021 	move	v0,zero
  800dd8:	082003be 	j	800ef8 <readline+0x1fc>
  800ddc:	00000000 	nop
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  800de0:	83c20020 	lb	v0,32(s8)
  800de4:	28420020 	slti	v0,v0,32
  800de8:	14400016 	bnez	v0,800e44 <readline+0x148>
  800dec:	00000000 	nop
  800df0:	8fc20018 	lw	v0,24(s8)
  800df4:	28420fff 	slti	v0,v0,4095
  800df8:	10400012 	beqz	v0,800e44 <readline+0x148>
  800dfc:	00000000 	nop
            putc(c);
  800e00:	83c20020 	lb	v0,32(s8)
  800e04:	24040001 	li	a0,1
  800e08:	3c030080 	lui	v1,0x80
  800e0c:	24653914 	addiu	a1,v1,14612
  800e10:	00403021 	move	a2,v0
  800e14:	0c200327 	jal	800c9c <fprintf>
  800e18:	00000000 	nop
            buffer[i ++] = c;
  800e1c:	8fc20018 	lw	v0,24(s8)
  800e20:	24430001 	addiu	v1,v0,1
  800e24:	afc30018 	sw	v1,24(s8)
  800e28:	83c30020 	lb	v1,32(s8)
  800e2c:	3c040080 	lui	a0,0x80
  800e30:	24846050 	addiu	a0,a0,24656
  800e34:	00441021 	addu	v0,v0,a0
  800e38:	a0430000 	sb	v1,0(v0)
  800e3c:	082003ba 	j	800ee8 <readline+0x1ec>
  800e40:	00000000 	nop
        }
        else if (c == '\b' && i > 0) {
  800e44:	83c30020 	lb	v1,32(s8)
  800e48:	24020008 	li	v0,8
  800e4c:	14620010 	bne	v1,v0,800e90 <readline+0x194>
  800e50:	00000000 	nop
  800e54:	8fc20018 	lw	v0,24(s8)
  800e58:	1840000d 	blez	v0,800e90 <readline+0x194>
  800e5c:	00000000 	nop
            putc(c);
  800e60:	83c20020 	lb	v0,32(s8)
  800e64:	24040001 	li	a0,1
  800e68:	3c030080 	lui	v1,0x80
  800e6c:	24653914 	addiu	a1,v1,14612
  800e70:	00403021 	move	a2,v0
  800e74:	0c200327 	jal	800c9c <fprintf>
  800e78:	00000000 	nop
            i --;
  800e7c:	8fc20018 	lw	v0,24(s8)
  800e80:	2442ffff 	addiu	v0,v0,-1
  800e84:	afc20018 	sw	v0,24(s8)
  800e88:	082003ba 	j	800ee8 <readline+0x1ec>
  800e8c:	00000000 	nop
        }
        else if (c == '\n' || c == '\r') {
  800e90:	83c30020 	lb	v1,32(s8)
  800e94:	2402000a 	li	v0,10
  800e98:	10620005 	beq	v1,v0,800eb0 <readline+0x1b4>
  800e9c:	00000000 	nop
  800ea0:	83c30020 	lb	v1,32(s8)
  800ea4:	2402000d 	li	v0,13
  800ea8:	1462000f 	bne	v1,v0,800ee8 <readline+0x1ec>
  800eac:	00000000 	nop
            putc(c);
  800eb0:	83c20020 	lb	v0,32(s8)
  800eb4:	24040001 	li	a0,1
  800eb8:	3c030080 	lui	v1,0x80
  800ebc:	24653914 	addiu	a1,v1,14612
  800ec0:	00403021 	move	a2,v0
  800ec4:	0c200327 	jal	800c9c <fprintf>
  800ec8:	00000000 	nop
            buffer[i] = '\0';
  800ecc:	3c020080 	lui	v0,0x80
  800ed0:	24436050 	addiu	v1,v0,24656
  800ed4:	8fc20018 	lw	v0,24(s8)
  800ed8:	00621021 	addu	v0,v1,v0
  800edc:	a0400000 	sb	zero,0(v0)
            break;
  800ee0:	082003bc 	j	800ef0 <readline+0x1f4>
  800ee4:	00000000 	nop
        }
    }
  800ee8:	08200354 	j	800d50 <readline+0x54>
  800eec:	00000000 	nop
    return buffer;
  800ef0:	3c020080 	lui	v0,0x80
  800ef4:	24426050 	addiu	v0,v0,24656
}
  800ef8:	03c0e821 	move	sp,s8
  800efc:	8fbf002c 	lw	ra,44(sp)
  800f00:	8fbe0028 	lw	s8,40(sp)
  800f04:	27bd0030 	addiu	sp,sp,48
  800f08:	03e00008 	jr	ra
  800f0c:	00000000 	nop

00800f10 <syscall>:
#define MAX_ARGS            5

uint32_t do_syscall(uint32_t arg0, uint32_t arg1, uint32_t arg2, uint32_t arg3, uint32_t arg4, uint32_t num);

static inline int
syscall(int num, ...) {
  800f10:	27bdffb8 	addiu	sp,sp,-72
  800f14:	afbf0044 	sw	ra,68(sp)
  800f18:	afbe0040 	sw	s8,64(sp)
  800f1c:	03a0f021 	move	s8,sp
  800f20:	afc5004c 	sw	a1,76(s8)
  800f24:	afc60050 	sw	a2,80(s8)
  800f28:	afc70054 	sw	a3,84(s8)
  800f2c:	afc40048 	sw	a0,72(s8)
    va_list ap;
    va_start(ap, num);
  800f30:	27c2004c 	addiu	v0,s8,76
  800f34:	afc20028 	sw	v0,40(s8)
    uint32_t a[MAX_ARGS];
    int i, ret;
    for (i = 0; i < MAX_ARGS; i ++) {
  800f38:	afc00020 	sw	zero,32(s8)
  800f3c:	082003dd 	j	800f74 <syscall+0x64>
  800f40:	00000000 	nop
        a[i] = va_arg(ap, uint32_t);
  800f44:	8fc20028 	lw	v0,40(s8)
  800f48:	24430004 	addiu	v1,v0,4
  800f4c:	afc30028 	sw	v1,40(s8)
  800f50:	8c430000 	lw	v1,0(v0)
  800f54:	8fc20020 	lw	v0,32(s8)
  800f58:	00021080 	sll	v0,v0,0x2
  800f5c:	27c40020 	addiu	a0,s8,32
  800f60:	00821021 	addu	v0,a0,v0
  800f64:	ac43000c 	sw	v1,12(v0)
syscall(int num, ...) {
    va_list ap;
    va_start(ap, num);
    uint32_t a[MAX_ARGS];
    int i, ret;
    for (i = 0; i < MAX_ARGS; i ++) {
  800f68:	8fc20020 	lw	v0,32(s8)
  800f6c:	24420001 	addiu	v0,v0,1
  800f70:	afc20020 	sw	v0,32(s8)
  800f74:	8fc20020 	lw	v0,32(s8)
  800f78:	28420005 	slti	v0,v0,5
  800f7c:	1440fff1 	bnez	v0,800f44 <syscall+0x34>
  800f80:	00000000 	nop
        a[i] = va_arg(ap, uint32_t);
    }
    va_end(ap);

    ret = do_syscall(a[0], a[1], a[2], a[3], a[4], num);
  800f84:	8fc4002c 	lw	a0,44(s8)
  800f88:	8fc50030 	lw	a1,48(s8)
  800f8c:	8fc30034 	lw	v1,52(s8)
  800f90:	8fc20038 	lw	v0,56(s8)
  800f94:	8fc7003c 	lw	a3,60(s8)
  800f98:	8fc60048 	lw	a2,72(s8)
  800f9c:	afa70010 	sw	a3,16(sp)
  800fa0:	afa60014 	sw	a2,20(sp)
  800fa4:	00603021 	move	a2,v1
  800fa8:	00403821 	move	a3,v0
  800fac:	0c200074 	jal	8001d0 <do_syscall>
  800fb0:	00000000 	nop
  800fb4:	afc20024 	sw	v0,36(s8)
    return ret;
  800fb8:	8fc20024 	lw	v0,36(s8)
}
  800fbc:	03c0e821 	move	sp,s8
  800fc0:	8fbf0044 	lw	ra,68(sp)
  800fc4:	8fbe0040 	lw	s8,64(sp)
  800fc8:	27bd0048 	addiu	sp,sp,72
  800fcc:	03e00008 	jr	ra
  800fd0:	00000000 	nop

00800fd4 <sys_exit>:

int
sys_exit(int error_code) {
  800fd4:	27bdffe0 	addiu	sp,sp,-32
  800fd8:	afbf001c 	sw	ra,28(sp)
  800fdc:	afbe0018 	sw	s8,24(sp)
  800fe0:	03a0f021 	move	s8,sp
  800fe4:	afc40020 	sw	a0,32(s8)
    return syscall(SYS_exit, error_code);
  800fe8:	24040001 	li	a0,1
  800fec:	8fc50020 	lw	a1,32(s8)
  800ff0:	0c2003c4 	jal	800f10 <syscall>
  800ff4:	00000000 	nop
}
  800ff8:	03c0e821 	move	sp,s8
  800ffc:	8fbf001c 	lw	ra,28(sp)
  801000:	8fbe0018 	lw	s8,24(sp)
  801004:	27bd0020 	addiu	sp,sp,32
  801008:	03e00008 	jr	ra
  80100c:	00000000 	nop

00801010 <sys_fork>:

int
sys_fork(void) {
  801010:	27bdffe0 	addiu	sp,sp,-32
  801014:	afbf001c 	sw	ra,28(sp)
  801018:	afbe0018 	sw	s8,24(sp)
  80101c:	03a0f021 	move	s8,sp
    return syscall(SYS_fork);
  801020:	24040002 	li	a0,2
  801024:	0c2003c4 	jal	800f10 <syscall>
  801028:	00000000 	nop
}
  80102c:	03c0e821 	move	sp,s8
  801030:	8fbf001c 	lw	ra,28(sp)
  801034:	8fbe0018 	lw	s8,24(sp)
  801038:	27bd0020 	addiu	sp,sp,32
  80103c:	03e00008 	jr	ra
  801040:	00000000 	nop

00801044 <sys_wait>:

int
sys_wait(int pid, int *store) {
  801044:	27bdffe0 	addiu	sp,sp,-32
  801048:	afbf001c 	sw	ra,28(sp)
  80104c:	afbe0018 	sw	s8,24(sp)
  801050:	03a0f021 	move	s8,sp
  801054:	afc40020 	sw	a0,32(s8)
  801058:	afc50024 	sw	a1,36(s8)
    return syscall(SYS_wait, pid, store);
  80105c:	24040003 	li	a0,3
  801060:	8fc50020 	lw	a1,32(s8)
  801064:	8fc60024 	lw	a2,36(s8)
  801068:	0c2003c4 	jal	800f10 <syscall>
  80106c:	00000000 	nop
}
  801070:	03c0e821 	move	sp,s8
  801074:	8fbf001c 	lw	ra,28(sp)
  801078:	8fbe0018 	lw	s8,24(sp)
  80107c:	27bd0020 	addiu	sp,sp,32
  801080:	03e00008 	jr	ra
  801084:	00000000 	nop

00801088 <sys_yield>:

int
sys_yield(void) {
  801088:	27bdffe0 	addiu	sp,sp,-32
  80108c:	afbf001c 	sw	ra,28(sp)
  801090:	afbe0018 	sw	s8,24(sp)
  801094:	03a0f021 	move	s8,sp
    return syscall(SYS_yield);
  801098:	2404000a 	li	a0,10
  80109c:	0c2003c4 	jal	800f10 <syscall>
  8010a0:	00000000 	nop
}
  8010a4:	03c0e821 	move	sp,s8
  8010a8:	8fbf001c 	lw	ra,28(sp)
  8010ac:	8fbe0018 	lw	s8,24(sp)
  8010b0:	27bd0020 	addiu	sp,sp,32
  8010b4:	03e00008 	jr	ra
  8010b8:	00000000 	nop

008010bc <sys_kill>:

int
sys_kill(int pid) {
  8010bc:	27bdffe0 	addiu	sp,sp,-32
  8010c0:	afbf001c 	sw	ra,28(sp)
  8010c4:	afbe0018 	sw	s8,24(sp)
  8010c8:	03a0f021 	move	s8,sp
  8010cc:	afc40020 	sw	a0,32(s8)
    return syscall(SYS_kill, pid);
  8010d0:	2404000c 	li	a0,12
  8010d4:	8fc50020 	lw	a1,32(s8)
  8010d8:	0c2003c4 	jal	800f10 <syscall>
  8010dc:	00000000 	nop
}
  8010e0:	03c0e821 	move	sp,s8
  8010e4:	8fbf001c 	lw	ra,28(sp)
  8010e8:	8fbe0018 	lw	s8,24(sp)
  8010ec:	27bd0020 	addiu	sp,sp,32
  8010f0:	03e00008 	jr	ra
  8010f4:	00000000 	nop

008010f8 <sys_getpid>:

int
sys_getpid(void) {
  8010f8:	27bdffe0 	addiu	sp,sp,-32
  8010fc:	afbf001c 	sw	ra,28(sp)
  801100:	afbe0018 	sw	s8,24(sp)
  801104:	03a0f021 	move	s8,sp
    return syscall(SYS_getpid);
  801108:	24040012 	li	a0,18
  80110c:	0c2003c4 	jal	800f10 <syscall>
  801110:	00000000 	nop
}
  801114:	03c0e821 	move	sp,s8
  801118:	8fbf001c 	lw	ra,28(sp)
  80111c:	8fbe0018 	lw	s8,24(sp)
  801120:	27bd0020 	addiu	sp,sp,32
  801124:	03e00008 	jr	ra
  801128:	00000000 	nop

0080112c <sys_putc>:

int
sys_putc(int c) {
  80112c:	27bdffe0 	addiu	sp,sp,-32
  801130:	afbf001c 	sw	ra,28(sp)
  801134:	afbe0018 	sw	s8,24(sp)
  801138:	03a0f021 	move	s8,sp
  80113c:	afc40020 	sw	a0,32(s8)
    return syscall(SYS_putc, c);
  801140:	2404001e 	li	a0,30
  801144:	8fc50020 	lw	a1,32(s8)
  801148:	0c2003c4 	jal	800f10 <syscall>
  80114c:	00000000 	nop
}
  801150:	03c0e821 	move	sp,s8
  801154:	8fbf001c 	lw	ra,28(sp)
  801158:	8fbe0018 	lw	s8,24(sp)
  80115c:	27bd0020 	addiu	sp,sp,32
  801160:	03e00008 	jr	ra
  801164:	00000000 	nop

00801168 <sys_pgdir>:

int
sys_pgdir(void) {
  801168:	27bdffe0 	addiu	sp,sp,-32
  80116c:	afbf001c 	sw	ra,28(sp)
  801170:	afbe0018 	sw	s8,24(sp)
  801174:	03a0f021 	move	s8,sp
    return syscall(SYS_pgdir);
  801178:	2404001f 	li	a0,31
  80117c:	0c2003c4 	jal	800f10 <syscall>
  801180:	00000000 	nop
}
  801184:	03c0e821 	move	sp,s8
  801188:	8fbf001c 	lw	ra,28(sp)
  80118c:	8fbe0018 	lw	s8,24(sp)
  801190:	27bd0020 	addiu	sp,sp,32
  801194:	03e00008 	jr	ra
  801198:	00000000 	nop

0080119c <sys_lab6_set_priority>:

void
sys_lab6_set_priority(uint32_t priority)
{
  80119c:	27bdffe0 	addiu	sp,sp,-32
  8011a0:	afbf001c 	sw	ra,28(sp)
  8011a4:	afbe0018 	sw	s8,24(sp)
  8011a8:	03a0f021 	move	s8,sp
  8011ac:	afc40020 	sw	a0,32(s8)
    syscall(SYS_lab6_set_priority, priority);
  8011b0:	240400ff 	li	a0,255
  8011b4:	8fc50020 	lw	a1,32(s8)
  8011b8:	0c2003c4 	jal	800f10 <syscall>
  8011bc:	00000000 	nop
}
  8011c0:	03c0e821 	move	sp,s8
  8011c4:	8fbf001c 	lw	ra,28(sp)
  8011c8:	8fbe0018 	lw	s8,24(sp)
  8011cc:	27bd0020 	addiu	sp,sp,32
  8011d0:	03e00008 	jr	ra
  8011d4:	00000000 	nop

008011d8 <sys_sleep>:

int
sys_sleep(unsigned int time) {
  8011d8:	27bdffe0 	addiu	sp,sp,-32
  8011dc:	afbf001c 	sw	ra,28(sp)
  8011e0:	afbe0018 	sw	s8,24(sp)
  8011e4:	03a0f021 	move	s8,sp
  8011e8:	afc40020 	sw	a0,32(s8)
    return syscall(SYS_sleep, time);
  8011ec:	2404000b 	li	a0,11
  8011f0:	8fc50020 	lw	a1,32(s8)
  8011f4:	0c2003c4 	jal	800f10 <syscall>
  8011f8:	00000000 	nop
}
  8011fc:	03c0e821 	move	sp,s8
  801200:	8fbf001c 	lw	ra,28(sp)
  801204:	8fbe0018 	lw	s8,24(sp)
  801208:	27bd0020 	addiu	sp,sp,32
  80120c:	03e00008 	jr	ra
  801210:	00000000 	nop

00801214 <sys_gettime>:

int
sys_gettime(void) {
  801214:	27bdffe0 	addiu	sp,sp,-32
  801218:	afbf001c 	sw	ra,28(sp)
  80121c:	afbe0018 	sw	s8,24(sp)
  801220:	03a0f021 	move	s8,sp
    return syscall(SYS_gettime);
  801224:	24040011 	li	a0,17
  801228:	0c2003c4 	jal	800f10 <syscall>
  80122c:	00000000 	nop
}
  801230:	03c0e821 	move	sp,s8
  801234:	8fbf001c 	lw	ra,28(sp)
  801238:	8fbe0018 	lw	s8,24(sp)
  80123c:	27bd0020 	addiu	sp,sp,32
  801240:	03e00008 	jr	ra
  801244:	00000000 	nop

00801248 <sys_exec>:

int
sys_exec(const char *name, int argc, const char **argv) {
  801248:	27bdffe0 	addiu	sp,sp,-32
  80124c:	afbf001c 	sw	ra,28(sp)
  801250:	afbe0018 	sw	s8,24(sp)
  801254:	03a0f021 	move	s8,sp
  801258:	afc40020 	sw	a0,32(s8)
  80125c:	afc50024 	sw	a1,36(s8)
  801260:	afc60028 	sw	a2,40(s8)
    return syscall(SYS_exec, name, argc, argv);
  801264:	24040004 	li	a0,4
  801268:	8fc50020 	lw	a1,32(s8)
  80126c:	8fc60024 	lw	a2,36(s8)
  801270:	8fc70028 	lw	a3,40(s8)
  801274:	0c2003c4 	jal	800f10 <syscall>
  801278:	00000000 	nop
}
  80127c:	03c0e821 	move	sp,s8
  801280:	8fbf001c 	lw	ra,28(sp)
  801284:	8fbe0018 	lw	s8,24(sp)
  801288:	27bd0020 	addiu	sp,sp,32
  80128c:	03e00008 	jr	ra
  801290:	00000000 	nop

00801294 <sys_open>:

int
sys_open(const char *path, uint32_t open_flags) {
  801294:	27bdffe0 	addiu	sp,sp,-32
  801298:	afbf001c 	sw	ra,28(sp)
  80129c:	afbe0018 	sw	s8,24(sp)
  8012a0:	03a0f021 	move	s8,sp
  8012a4:	afc40020 	sw	a0,32(s8)
  8012a8:	afc50024 	sw	a1,36(s8)
    return syscall(SYS_open, path, open_flags);
  8012ac:	24040064 	li	a0,100
  8012b0:	8fc50020 	lw	a1,32(s8)
  8012b4:	8fc60024 	lw	a2,36(s8)
  8012b8:	0c2003c4 	jal	800f10 <syscall>
  8012bc:	00000000 	nop
}
  8012c0:	03c0e821 	move	sp,s8
  8012c4:	8fbf001c 	lw	ra,28(sp)
  8012c8:	8fbe0018 	lw	s8,24(sp)
  8012cc:	27bd0020 	addiu	sp,sp,32
  8012d0:	03e00008 	jr	ra
  8012d4:	00000000 	nop

008012d8 <sys_close>:

int
sys_close(int fd) {
  8012d8:	27bdffe0 	addiu	sp,sp,-32
  8012dc:	afbf001c 	sw	ra,28(sp)
  8012e0:	afbe0018 	sw	s8,24(sp)
  8012e4:	03a0f021 	move	s8,sp
  8012e8:	afc40020 	sw	a0,32(s8)
    return syscall(SYS_close, fd);
  8012ec:	24040065 	li	a0,101
  8012f0:	8fc50020 	lw	a1,32(s8)
  8012f4:	0c2003c4 	jal	800f10 <syscall>
  8012f8:	00000000 	nop
}
  8012fc:	03c0e821 	move	sp,s8
  801300:	8fbf001c 	lw	ra,28(sp)
  801304:	8fbe0018 	lw	s8,24(sp)
  801308:	27bd0020 	addiu	sp,sp,32
  80130c:	03e00008 	jr	ra
  801310:	00000000 	nop

00801314 <sys_read>:

int
sys_read(int fd, void *base, size_t len) {
  801314:	27bdffe0 	addiu	sp,sp,-32
  801318:	afbf001c 	sw	ra,28(sp)
  80131c:	afbe0018 	sw	s8,24(sp)
  801320:	03a0f021 	move	s8,sp
  801324:	afc40020 	sw	a0,32(s8)
  801328:	afc50024 	sw	a1,36(s8)
  80132c:	afc60028 	sw	a2,40(s8)
    return syscall(SYS_read, fd, base, len);
  801330:	24040066 	li	a0,102
  801334:	8fc50020 	lw	a1,32(s8)
  801338:	8fc60024 	lw	a2,36(s8)
  80133c:	8fc70028 	lw	a3,40(s8)
  801340:	0c2003c4 	jal	800f10 <syscall>
  801344:	00000000 	nop
}
  801348:	03c0e821 	move	sp,s8
  80134c:	8fbf001c 	lw	ra,28(sp)
  801350:	8fbe0018 	lw	s8,24(sp)
  801354:	27bd0020 	addiu	sp,sp,32
  801358:	03e00008 	jr	ra
  80135c:	00000000 	nop

00801360 <sys_write>:

int
sys_write(int fd, void *base, size_t len) {
  801360:	27bdffe0 	addiu	sp,sp,-32
  801364:	afbf001c 	sw	ra,28(sp)
  801368:	afbe0018 	sw	s8,24(sp)
  80136c:	03a0f021 	move	s8,sp
  801370:	afc40020 	sw	a0,32(s8)
  801374:	afc50024 	sw	a1,36(s8)
  801378:	afc60028 	sw	a2,40(s8)
    return syscall(SYS_write, fd, base, len);
  80137c:	24040067 	li	a0,103
  801380:	8fc50020 	lw	a1,32(s8)
  801384:	8fc60024 	lw	a2,36(s8)
  801388:	8fc70028 	lw	a3,40(s8)
  80138c:	0c2003c4 	jal	800f10 <syscall>
  801390:	00000000 	nop
}
  801394:	03c0e821 	move	sp,s8
  801398:	8fbf001c 	lw	ra,28(sp)
  80139c:	8fbe0018 	lw	s8,24(sp)
  8013a0:	27bd0020 	addiu	sp,sp,32
  8013a4:	03e00008 	jr	ra
  8013a8:	00000000 	nop

008013ac <sys_seek>:

int
sys_seek(int fd, off_t pos, int whence) {
  8013ac:	27bdffe0 	addiu	sp,sp,-32
  8013b0:	afbf001c 	sw	ra,28(sp)
  8013b4:	afbe0018 	sw	s8,24(sp)
  8013b8:	03a0f021 	move	s8,sp
  8013bc:	afc40020 	sw	a0,32(s8)
  8013c0:	afc50024 	sw	a1,36(s8)
  8013c4:	afc60028 	sw	a2,40(s8)
    return syscall(SYS_seek, fd, pos, whence);
  8013c8:	24040068 	li	a0,104
  8013cc:	8fc50020 	lw	a1,32(s8)
  8013d0:	8fc60024 	lw	a2,36(s8)
  8013d4:	8fc70028 	lw	a3,40(s8)
  8013d8:	0c2003c4 	jal	800f10 <syscall>
  8013dc:	00000000 	nop
}
  8013e0:	03c0e821 	move	sp,s8
  8013e4:	8fbf001c 	lw	ra,28(sp)
  8013e8:	8fbe0018 	lw	s8,24(sp)
  8013ec:	27bd0020 	addiu	sp,sp,32
  8013f0:	03e00008 	jr	ra
  8013f4:	00000000 	nop

008013f8 <sys_fstat>:

int
sys_fstat(int fd, struct stat *stat) {
  8013f8:	27bdffe0 	addiu	sp,sp,-32
  8013fc:	afbf001c 	sw	ra,28(sp)
  801400:	afbe0018 	sw	s8,24(sp)
  801404:	03a0f021 	move	s8,sp
  801408:	afc40020 	sw	a0,32(s8)
  80140c:	afc50024 	sw	a1,36(s8)
    return syscall(SYS_fstat, fd, stat);
  801410:	2404006e 	li	a0,110
  801414:	8fc50020 	lw	a1,32(s8)
  801418:	8fc60024 	lw	a2,36(s8)
  80141c:	0c2003c4 	jal	800f10 <syscall>
  801420:	00000000 	nop
}
  801424:	03c0e821 	move	sp,s8
  801428:	8fbf001c 	lw	ra,28(sp)
  80142c:	8fbe0018 	lw	s8,24(sp)
  801430:	27bd0020 	addiu	sp,sp,32
  801434:	03e00008 	jr	ra
  801438:	00000000 	nop

0080143c <sys_fsync>:

int
sys_fsync(int fd) {
  80143c:	27bdffe0 	addiu	sp,sp,-32
  801440:	afbf001c 	sw	ra,28(sp)
  801444:	afbe0018 	sw	s8,24(sp)
  801448:	03a0f021 	move	s8,sp
  80144c:	afc40020 	sw	a0,32(s8)
    return syscall(SYS_fsync, fd);
  801450:	2404006f 	li	a0,111
  801454:	8fc50020 	lw	a1,32(s8)
  801458:	0c2003c4 	jal	800f10 <syscall>
  80145c:	00000000 	nop
}
  801460:	03c0e821 	move	sp,s8
  801464:	8fbf001c 	lw	ra,28(sp)
  801468:	8fbe0018 	lw	s8,24(sp)
  80146c:	27bd0020 	addiu	sp,sp,32
  801470:	03e00008 	jr	ra
  801474:	00000000 	nop

00801478 <sys_getcwd>:

int
sys_getcwd(char *buffer, size_t len) {
  801478:	27bdffe0 	addiu	sp,sp,-32
  80147c:	afbf001c 	sw	ra,28(sp)
  801480:	afbe0018 	sw	s8,24(sp)
  801484:	03a0f021 	move	s8,sp
  801488:	afc40020 	sw	a0,32(s8)
  80148c:	afc50024 	sw	a1,36(s8)
    return syscall(SYS_getcwd, buffer, len);
  801490:	24040079 	li	a0,121
  801494:	8fc50020 	lw	a1,32(s8)
  801498:	8fc60024 	lw	a2,36(s8)
  80149c:	0c2003c4 	jal	800f10 <syscall>
  8014a0:	00000000 	nop
}
  8014a4:	03c0e821 	move	sp,s8
  8014a8:	8fbf001c 	lw	ra,28(sp)
  8014ac:	8fbe0018 	lw	s8,24(sp)
  8014b0:	27bd0020 	addiu	sp,sp,32
  8014b4:	03e00008 	jr	ra
  8014b8:	00000000 	nop

008014bc <sys_getdirentry>:

int
sys_getdirentry(int fd, struct dirent *dirent) {
  8014bc:	27bdffe0 	addiu	sp,sp,-32
  8014c0:	afbf001c 	sw	ra,28(sp)
  8014c4:	afbe0018 	sw	s8,24(sp)
  8014c8:	03a0f021 	move	s8,sp
  8014cc:	afc40020 	sw	a0,32(s8)
  8014d0:	afc50024 	sw	a1,36(s8)
    return syscall(SYS_getdirentry, fd, dirent);
  8014d4:	24040080 	li	a0,128
  8014d8:	8fc50020 	lw	a1,32(s8)
  8014dc:	8fc60024 	lw	a2,36(s8)
  8014e0:	0c2003c4 	jal	800f10 <syscall>
  8014e4:	00000000 	nop
}
  8014e8:	03c0e821 	move	sp,s8
  8014ec:	8fbf001c 	lw	ra,28(sp)
  8014f0:	8fbe0018 	lw	s8,24(sp)
  8014f4:	27bd0020 	addiu	sp,sp,32
  8014f8:	03e00008 	jr	ra
  8014fc:	00000000 	nop

00801500 <sys_dup>:

int
sys_dup(int fd1, int fd2) {
  801500:	27bdffe0 	addiu	sp,sp,-32
  801504:	afbf001c 	sw	ra,28(sp)
  801508:	afbe0018 	sw	s8,24(sp)
  80150c:	03a0f021 	move	s8,sp
  801510:	afc40020 	sw	a0,32(s8)
  801514:	afc50024 	sw	a1,36(s8)
    return syscall(SYS_dup, fd1, fd2);
  801518:	24040082 	li	a0,130
  80151c:	8fc50020 	lw	a1,32(s8)
  801520:	8fc60024 	lw	a2,36(s8)
  801524:	0c2003c4 	jal	800f10 <syscall>
  801528:	00000000 	nop
}
  80152c:	03c0e821 	move	sp,s8
  801530:	8fbf001c 	lw	ra,28(sp)
  801534:	8fbe0018 	lw	s8,24(sp)
  801538:	27bd0020 	addiu	sp,sp,32
  80153c:	03e00008 	jr	ra
  801540:	00000000 	nop

00801544 <sys_alloc>:

void*
sys_alloc(int size){
  801544:	27bdffe0 	addiu	sp,sp,-32
  801548:	afbf001c 	sw	ra,28(sp)
  80154c:	afbe0018 	sw	s8,24(sp)
  801550:	03a0f021 	move	s8,sp
  801554:	afc40020 	sw	a0,32(s8)
    return syscall(SYS_alloc,size);
  801558:	24040009 	li	a0,9
  80155c:	8fc50020 	lw	a1,32(s8)
  801560:	0c2003c4 	jal	800f10 <syscall>
  801564:	00000000 	nop
  801568:	03c0e821 	move	sp,s8
  80156c:	8fbf001c 	lw	ra,28(sp)
  801570:	8fbe0018 	lw	s8,24(sp)
  801574:	27bd0020 	addiu	sp,sp,32
  801578:	03e00008 	jr	ra
  80157c:	00000000 	nop

00801580 <exit>:
#include <ulib.h>
#include <stat.h>
#include <string.h>

void
exit(int error_code) {
  801580:	27bdffe0 	addiu	sp,sp,-32
  801584:	afbf001c 	sw	ra,28(sp)
  801588:	afbe0018 	sw	s8,24(sp)
  80158c:	03a0f021 	move	s8,sp
  801590:	afc40020 	sw	a0,32(s8)
    sys_exit(error_code);
  801594:	8fc40020 	lw	a0,32(s8)
  801598:	0c2003f5 	jal	800fd4 <sys_exit>
  80159c:	00000000 	nop
    cprintf("BUG: exit failed.\n");
  8015a0:	3c020080 	lui	v0,0x80
  8015a4:	24443920 	addiu	a0,v0,14624
  8015a8:	0c2002bd 	jal	800af4 <cprintf>
  8015ac:	00000000 	nop
    while (1);
  8015b0:	0820056c 	j	8015b0 <exit+0x30>
  8015b4:	00000000 	nop

008015b8 <fork>:
}

int
fork(void) {
  8015b8:	27bdffe0 	addiu	sp,sp,-32
  8015bc:	afbf001c 	sw	ra,28(sp)
  8015c0:	afbe0018 	sw	s8,24(sp)
  8015c4:	03a0f021 	move	s8,sp
    return sys_fork();
  8015c8:	0c200404 	jal	801010 <sys_fork>
  8015cc:	00000000 	nop
}
  8015d0:	03c0e821 	move	sp,s8
  8015d4:	8fbf001c 	lw	ra,28(sp)
  8015d8:	8fbe0018 	lw	s8,24(sp)
  8015dc:	27bd0020 	addiu	sp,sp,32
  8015e0:	03e00008 	jr	ra
  8015e4:	00000000 	nop

008015e8 <wait>:

int
wait(void) {
  8015e8:	27bdffe0 	addiu	sp,sp,-32
  8015ec:	afbf001c 	sw	ra,28(sp)
  8015f0:	afbe0018 	sw	s8,24(sp)
  8015f4:	03a0f021 	move	s8,sp
    return sys_wait(0, NULL);
  8015f8:	00002021 	move	a0,zero
  8015fc:	00002821 	move	a1,zero
  801600:	0c200411 	jal	801044 <sys_wait>
  801604:	00000000 	nop
}
  801608:	03c0e821 	move	sp,s8
  80160c:	8fbf001c 	lw	ra,28(sp)
  801610:	8fbe0018 	lw	s8,24(sp)
  801614:	27bd0020 	addiu	sp,sp,32
  801618:	03e00008 	jr	ra
  80161c:	00000000 	nop

00801620 <waitpid>:

int
waitpid(int pid, int *store) {
  801620:	27bdffe0 	addiu	sp,sp,-32
  801624:	afbf001c 	sw	ra,28(sp)
  801628:	afbe0018 	sw	s8,24(sp)
  80162c:	03a0f021 	move	s8,sp
  801630:	afc40020 	sw	a0,32(s8)
  801634:	afc50024 	sw	a1,36(s8)
    return sys_wait(pid, store);
  801638:	8fc40020 	lw	a0,32(s8)
  80163c:	8fc50024 	lw	a1,36(s8)
  801640:	0c200411 	jal	801044 <sys_wait>
  801644:	00000000 	nop
}
  801648:	03c0e821 	move	sp,s8
  80164c:	8fbf001c 	lw	ra,28(sp)
  801650:	8fbe0018 	lw	s8,24(sp)
  801654:	27bd0020 	addiu	sp,sp,32
  801658:	03e00008 	jr	ra
  80165c:	00000000 	nop

00801660 <yield>:

void
yield(void) {
  801660:	27bdffe0 	addiu	sp,sp,-32
  801664:	afbf001c 	sw	ra,28(sp)
  801668:	afbe0018 	sw	s8,24(sp)
  80166c:	03a0f021 	move	s8,sp
    sys_yield();
  801670:	0c200422 	jal	801088 <sys_yield>
  801674:	00000000 	nop
}
  801678:	03c0e821 	move	sp,s8
  80167c:	8fbf001c 	lw	ra,28(sp)
  801680:	8fbe0018 	lw	s8,24(sp)
  801684:	27bd0020 	addiu	sp,sp,32
  801688:	03e00008 	jr	ra
  80168c:	00000000 	nop

00801690 <kill>:

int
kill(int pid) {
  801690:	27bdffe0 	addiu	sp,sp,-32
  801694:	afbf001c 	sw	ra,28(sp)
  801698:	afbe0018 	sw	s8,24(sp)
  80169c:	03a0f021 	move	s8,sp
  8016a0:	afc40020 	sw	a0,32(s8)
    return sys_kill(pid);
  8016a4:	8fc40020 	lw	a0,32(s8)
  8016a8:	0c20042f 	jal	8010bc <sys_kill>
  8016ac:	00000000 	nop
}
  8016b0:	03c0e821 	move	sp,s8
  8016b4:	8fbf001c 	lw	ra,28(sp)
  8016b8:	8fbe0018 	lw	s8,24(sp)
  8016bc:	27bd0020 	addiu	sp,sp,32
  8016c0:	03e00008 	jr	ra
  8016c4:	00000000 	nop

008016c8 <getpid>:

int
getpid(void) {
  8016c8:	27bdffe0 	addiu	sp,sp,-32
  8016cc:	afbf001c 	sw	ra,28(sp)
  8016d0:	afbe0018 	sw	s8,24(sp)
  8016d4:	03a0f021 	move	s8,sp
    return sys_getpid();
  8016d8:	0c20043e 	jal	8010f8 <sys_getpid>
  8016dc:	00000000 	nop
}
  8016e0:	03c0e821 	move	sp,s8
  8016e4:	8fbf001c 	lw	ra,28(sp)
  8016e8:	8fbe0018 	lw	s8,24(sp)
  8016ec:	27bd0020 	addiu	sp,sp,32
  8016f0:	03e00008 	jr	ra
  8016f4:	00000000 	nop

008016f8 <print_pgdir>:

//print_pgdir - print the PDT&PT
void
print_pgdir(void) {
  8016f8:	27bdffe0 	addiu	sp,sp,-32
  8016fc:	afbf001c 	sw	ra,28(sp)
  801700:	afbe0018 	sw	s8,24(sp)
  801704:	03a0f021 	move	s8,sp
    sys_pgdir();
  801708:	0c20045a 	jal	801168 <sys_pgdir>
  80170c:	00000000 	nop
}
  801710:	03c0e821 	move	sp,s8
  801714:	8fbf001c 	lw	ra,28(sp)
  801718:	8fbe0018 	lw	s8,24(sp)
  80171c:	27bd0020 	addiu	sp,sp,32
  801720:	03e00008 	jr	ra
  801724:	00000000 	nop

00801728 <lab6_set_priority>:

void
lab6_set_priority(uint32_t priority)
{
  801728:	27bdffe0 	addiu	sp,sp,-32
  80172c:	afbf001c 	sw	ra,28(sp)
  801730:	afbe0018 	sw	s8,24(sp)
  801734:	03a0f021 	move	s8,sp
  801738:	afc40020 	sw	a0,32(s8)
    sys_lab6_set_priority(priority);
  80173c:	8fc40020 	lw	a0,32(s8)
  801740:	0c200467 	jal	80119c <sys_lab6_set_priority>
  801744:	00000000 	nop
}
  801748:	03c0e821 	move	sp,s8
  80174c:	8fbf001c 	lw	ra,28(sp)
  801750:	8fbe0018 	lw	s8,24(sp)
  801754:	27bd0020 	addiu	sp,sp,32
  801758:	03e00008 	jr	ra
  80175c:	00000000 	nop

00801760 <sleep>:

int
sleep(unsigned int time) {
  801760:	27bdffe0 	addiu	sp,sp,-32
  801764:	afbf001c 	sw	ra,28(sp)
  801768:	afbe0018 	sw	s8,24(sp)
  80176c:	03a0f021 	move	s8,sp
  801770:	afc40020 	sw	a0,32(s8)
    return sys_sleep(time);
  801774:	8fc40020 	lw	a0,32(s8)
  801778:	0c200476 	jal	8011d8 <sys_sleep>
  80177c:	00000000 	nop
}
  801780:	03c0e821 	move	sp,s8
  801784:	8fbf001c 	lw	ra,28(sp)
  801788:	8fbe0018 	lw	s8,24(sp)
  80178c:	27bd0020 	addiu	sp,sp,32
  801790:	03e00008 	jr	ra
  801794:	00000000 	nop

00801798 <gettime_msec>:

unsigned int
gettime_msec(void) {
  801798:	27bdffe0 	addiu	sp,sp,-32
  80179c:	afbf001c 	sw	ra,28(sp)
  8017a0:	afbe0018 	sw	s8,24(sp)
  8017a4:	03a0f021 	move	s8,sp
    return (unsigned int)sys_gettime();
  8017a8:	0c200485 	jal	801214 <sys_gettime>
  8017ac:	00000000 	nop
}
  8017b0:	03c0e821 	move	sp,s8
  8017b4:	8fbf001c 	lw	ra,28(sp)
  8017b8:	8fbe0018 	lw	s8,24(sp)
  8017bc:	27bd0020 	addiu	sp,sp,32
  8017c0:	03e00008 	jr	ra
  8017c4:	00000000 	nop

008017c8 <__exec>:

int
__exec(const char *name, const char **argv) {
  8017c8:	27bdffd8 	addiu	sp,sp,-40
  8017cc:	afbf0024 	sw	ra,36(sp)
  8017d0:	afbe0020 	sw	s8,32(sp)
  8017d4:	03a0f021 	move	s8,sp
  8017d8:	afc40028 	sw	a0,40(s8)
  8017dc:	afc5002c 	sw	a1,44(s8)
    int argc = 0;
  8017e0:	afc00018 	sw	zero,24(s8)
    while (argv[argc] != NULL) {
  8017e4:	082005fe 	j	8017f8 <__exec+0x30>
  8017e8:	00000000 	nop
        argc ++;
  8017ec:	8fc20018 	lw	v0,24(s8)
  8017f0:	24420001 	addiu	v0,v0,1
  8017f4:	afc20018 	sw	v0,24(s8)
}

int
__exec(const char *name, const char **argv) {
    int argc = 0;
    while (argv[argc] != NULL) {
  8017f8:	8fc20018 	lw	v0,24(s8)
  8017fc:	00021080 	sll	v0,v0,0x2
  801800:	8fc3002c 	lw	v1,44(s8)
  801804:	00621021 	addu	v0,v1,v0
  801808:	8c420000 	lw	v0,0(v0)
  80180c:	1440fff7 	bnez	v0,8017ec <__exec+0x24>
  801810:	00000000 	nop
        argc ++;
    }
    return sys_exec(name, argc, argv);
  801814:	8fc40028 	lw	a0,40(s8)
  801818:	8fc50018 	lw	a1,24(s8)
  80181c:	8fc6002c 	lw	a2,44(s8)
  801820:	0c200492 	jal	801248 <sys_exec>
  801824:	00000000 	nop
}
  801828:	03c0e821 	move	sp,s8
  80182c:	8fbf0024 	lw	ra,36(sp)
  801830:	8fbe0020 	lw	s8,32(sp)
  801834:	27bd0028 	addiu	sp,sp,40
  801838:	03e00008 	jr	ra
  80183c:	00000000 	nop

00801840 <malloc>:

void* malloc(int size){
  801840:	27bdffe0 	addiu	sp,sp,-32
  801844:	afbf001c 	sw	ra,28(sp)
  801848:	afbe0018 	sw	s8,24(sp)
  80184c:	03a0f021 	move	s8,sp
  801850:	afc40020 	sw	a0,32(s8)
    return sys_alloc(size);
  801854:	8fc40020 	lw	a0,32(s8)
  801858:	0c200551 	jal	801544 <sys_alloc>
  80185c:	00000000 	nop
  801860:	03c0e821 	move	sp,s8
  801864:	8fbf001c 	lw	ra,28(sp)
  801868:	8fbe0018 	lw	s8,24(sp)
  80186c:	27bd0020 	addiu	sp,sp,32
  801870:	03e00008 	jr	ra
  801874:	00000000 	nop
	...

00801880 <initfd>:
#include <stat.h>

int main(int argc, char *argv[]);

static int
initfd(int fd2, const char *path, uint32_t open_flags) {
  801880:	27bdffd8 	addiu	sp,sp,-40
  801884:	afbf0024 	sw	ra,36(sp)
  801888:	afbe0020 	sw	s8,32(sp)
  80188c:	03a0f021 	move	s8,sp
  801890:	afc40028 	sw	a0,40(s8)
  801894:	afc5002c 	sw	a1,44(s8)
  801898:	afc60030 	sw	a2,48(s8)
    int fd1, ret;
    if ((fd1 = open(path, open_flags)) < 0) {
  80189c:	8fc4002c 	lw	a0,44(s8)
  8018a0:	8fc50030 	lw	a1,48(s8)
  8018a4:	0c20007c 	jal	8001f0 <open>
  8018a8:	00000000 	nop
  8018ac:	afc2001c 	sw	v0,28(s8)
  8018b0:	8fc2001c 	lw	v0,28(s8)
  8018b4:	04410004 	bgez	v0,8018c8 <initfd+0x48>
  8018b8:	00000000 	nop
        return fd1;
  8018bc:	8fc2001c 	lw	v0,28(s8)
  8018c0:	08200642 	j	801908 <initfd+0x88>
  8018c4:	00000000 	nop
    }
    if (fd1 != fd2) {
  8018c8:	8fc3001c 	lw	v1,28(s8)
  8018cc:	8fc20028 	lw	v0,40(s8)
  8018d0:	1062000c 	beq	v1,v0,801904 <initfd+0x84>
  8018d4:	00000000 	nop
        close(fd2);
  8018d8:	8fc40028 	lw	a0,40(s8)
  8018dc:	0c20008c 	jal	800230 <close>
  8018e0:	00000000 	nop
        ret = dup2(fd1, fd2);
  8018e4:	8fc4001c 	lw	a0,28(s8)
  8018e8:	8fc50028 	lw	a1,40(s8)
  8018ec:	0c2000ee 	jal	8003b8 <dup2>
  8018f0:	00000000 	nop
  8018f4:	afc20018 	sw	v0,24(s8)
        close(fd1);
  8018f8:	8fc4001c 	lw	a0,28(s8)
  8018fc:	0c20008c 	jal	800230 <close>
  801900:	00000000 	nop
    }
    return ret;
  801904:	8fc20018 	lw	v0,24(s8)
}
  801908:	03c0e821 	move	sp,s8
  80190c:	8fbf0024 	lw	ra,36(sp)
  801910:	8fbe0020 	lw	s8,32(sp)
  801914:	27bd0028 	addiu	sp,sp,40
  801918:	03e00008 	jr	ra
  80191c:	00000000 	nop

00801920 <umain>:

void
umain(int argc, char *argv[]) {
  801920:	27bdffd8 	addiu	sp,sp,-40
  801924:	afbf0024 	sw	ra,36(sp)
  801928:	afbe0020 	sw	s8,32(sp)
  80192c:	03a0f021 	move	s8,sp
  801930:	afc40028 	sw	a0,40(s8)
  801934:	afc5002c 	sw	a1,44(s8)
    int fd;
    if ((fd = initfd(0, "stdin:", O_RDONLY)) < 0) {
  801938:	00002021 	move	a0,zero
  80193c:	3c020080 	lui	v0,0x80
  801940:	24453940 	addiu	a1,v0,14656
  801944:	00003021 	move	a2,zero
  801948:	0c200620 	jal	801880 <initfd>
  80194c:	00000000 	nop
  801950:	afc20018 	sw	v0,24(s8)
  801954:	8fc20018 	lw	v0,24(s8)
  801958:	04410009 	bgez	v0,801980 <umain+0x60>
  80195c:	00000000 	nop
        warn("open <stdin> failed: %e.\n", fd);
  801960:	3c020080 	lui	v0,0x80
  801964:	24443948 	addiu	a0,v0,14664
  801968:	2405001a 	li	a1,26
  80196c:	3c020080 	lui	v0,0x80
  801970:	2446395c 	addiu	a2,v0,14684
  801974:	8fc70018 	lw	a3,24(s8)
  801978:	0c200270 	jal	8009c0 <__warn>
  80197c:	00000000 	nop
    }
    if ((fd = initfd(1, "stdout:", O_WRONLY)) < 0) {
  801980:	24040001 	li	a0,1
  801984:	3c020080 	lui	v0,0x80
  801988:	24453978 	addiu	a1,v0,14712
  80198c:	24060001 	li	a2,1
  801990:	0c200620 	jal	801880 <initfd>
  801994:	00000000 	nop
  801998:	afc20018 	sw	v0,24(s8)
  80199c:	8fc20018 	lw	v0,24(s8)
  8019a0:	04410009 	bgez	v0,8019c8 <umain+0xa8>
  8019a4:	00000000 	nop
        warn("open <stdout> failed: %e.\n", fd);
  8019a8:	3c020080 	lui	v0,0x80
  8019ac:	24443948 	addiu	a0,v0,14664
  8019b0:	2405001d 	li	a1,29
  8019b4:	3c020080 	lui	v0,0x80
  8019b8:	24463980 	addiu	a2,v0,14720
  8019bc:	8fc70018 	lw	a3,24(s8)
  8019c0:	0c200270 	jal	8009c0 <__warn>
  8019c4:	00000000 	nop
    }
    int ret = main(argc, argv);
  8019c8:	8fc40028 	lw	a0,40(s8)
  8019cc:	8fc5002c 	lw	a1,44(s8)
  8019d0:	0c200ddf 	jal	80377c <main>
  8019d4:	00000000 	nop
  8019d8:	afc2001c 	sw	v0,28(s8)
    exit(ret);
  8019dc:	8fc4001c 	lw	a0,28(s8)
  8019e0:	0c200560 	jal	801580 <exit>
  8019e4:	00000000 	nop
	...

008019f0 <hash32>:
 * @bits:   the number of bits in a return value
 *
 * High bits are more random, so we use them.
 * */
uint32_t
hash32(uint32_t val, unsigned int bits) {
  8019f0:	27bdffe8 	addiu	sp,sp,-24
  8019f4:	afbe0014 	sw	s8,20(sp)
  8019f8:	03a0f021 	move	s8,sp
  8019fc:	afc40018 	sw	a0,24(s8)
  801a00:	afc5001c 	sw	a1,28(s8)
    uint32_t hash = val * GOLDEN_RATIO_PRIME_32;
  801a04:	8fc30018 	lw	v1,24(s8)
  801a08:	3c029e37 	lui	v0,0x9e37
  801a0c:	34420001 	ori	v0,v0,0x1
  801a10:	00620018 	mult	v1,v0
  801a14:	00001012 	mflo	v0
  801a18:	afc20008 	sw	v0,8(s8)
    return (hash >> (32 - bits));
  801a1c:	24030020 	li	v1,32
  801a20:	8fc2001c 	lw	v0,28(s8)
  801a24:	00621023 	subu	v0,v1,v0
  801a28:	8fc30008 	lw	v1,8(s8)
  801a2c:	00431006 	srlv	v0,v1,v0
}
  801a30:	03c0e821 	move	sp,s8
  801a34:	8fbe0014 	lw	s8,20(sp)
  801a38:	27bd0018 	addiu	sp,sp,24
  801a3c:	03e00008 	jr	ra
  801a40:	00000000 	nop
	...

00801a50 <printnum>:
 * @width:      maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:       character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*, int), int fd, void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  801a50:	27bdffb0 	addiu	sp,sp,-80
  801a54:	afbf004c 	sw	ra,76(sp)
  801a58:	afbe0048 	sw	s8,72(sp)
  801a5c:	03a0f021 	move	s8,sp
  801a60:	afc40050 	sw	a0,80(s8)
  801a64:	afc50054 	sw	a1,84(s8)
  801a68:	afc60058 	sw	a2,88(s8)
    unsigned long long result = num;
  801a6c:	8fc40060 	lw	a0,96(s8)
  801a70:	8fc50064 	lw	a1,100(s8)
  801a74:	00800013 	mtlo	a0
  801a78:	00a00011 	mthi	a1
  801a7c:	00002012 	mflo	a0
  801a80:	00002810 	mfhi	a1
  801a84:	afc40030 	sw	a0,48(s8)
  801a88:	afc50034 	sw	a1,52(s8)
    unsigned mod = do_div(result, base);
  801a8c:	8fc50068 	lw	a1,104(s8)
  801a90:	2404000a 	li	a0,10
  801a94:	14a40040 	bne	a1,a0,801b98 <printnum+0x148>
  801a98:	00000000 	nop
  801a9c:	8fc40034 	lw	a0,52(s8)
  801aa0:	000427c0 	sll	a0,a0,0x1f
  801aa4:	8fc50030 	lw	a1,48(s8)
  801aa8:	00055042 	srl	t2,a1,0x1
  801aac:	008a5025 	or	t2,a0,t2
  801ab0:	8fc40034 	lw	a0,52(s8)
  801ab4:	00045842 	srl	t3,a0,0x1
  801ab8:	01402821 	move	a1,t2
  801abc:	8fc40034 	lw	a0,52(s8)
  801ac0:	00042780 	sll	a0,a0,0x1e
  801ac4:	8fc60030 	lw	a2,48(s8)
  801ac8:	00064082 	srl	t0,a2,0x2
  801acc:	00884025 	or	t0,a0,t0
  801ad0:	8fc40034 	lw	a0,52(s8)
  801ad4:	00044882 	srl	t1,a0,0x2
  801ad8:	01002021 	move	a0,t0
  801adc:	00a42021 	addu	a0,a1,a0
  801ae0:	afc4003c 	sw	a0,60(s8)
  801ae4:	8fc4003c 	lw	a0,60(s8)
  801ae8:	00042102 	srl	a0,a0,0x4
  801aec:	8fc5003c 	lw	a1,60(s8)
  801af0:	00a42021 	addu	a0,a1,a0
  801af4:	afc4003c 	sw	a0,60(s8)
  801af8:	8fc4003c 	lw	a0,60(s8)
  801afc:	00042202 	srl	a0,a0,0x8
  801b00:	8fc5003c 	lw	a1,60(s8)
  801b04:	00a42021 	addu	a0,a1,a0
  801b08:	afc4003c 	sw	a0,60(s8)
  801b0c:	8fc4003c 	lw	a0,60(s8)
  801b10:	00042402 	srl	a0,a0,0x10
  801b14:	8fc5003c 	lw	a1,60(s8)
  801b18:	00a42021 	addu	a0,a1,a0
  801b1c:	afc4003c 	sw	a0,60(s8)
  801b20:	8fc4003c 	lw	a0,60(s8)
  801b24:	000420c2 	srl	a0,a0,0x3
  801b28:	afc4003c 	sw	a0,60(s8)
  801b2c:	8fc50030 	lw	a1,48(s8)
  801b30:	8fc4003c 	lw	a0,60(s8)
  801b34:	00043080 	sll	a2,a0,0x2
  801b38:	8fc4003c 	lw	a0,60(s8)
  801b3c:	00c42021 	addu	a0,a2,a0
  801b40:	00042040 	sll	a0,a0,0x1
  801b44:	00a42023 	subu	a0,a1,a0
  801b48:	afc40038 	sw	a0,56(s8)
  801b4c:	8fc40038 	lw	a0,56(s8)
  801b50:	24840006 	addiu	a0,a0,6
  801b54:	00042102 	srl	a0,a0,0x4
  801b58:	8fc5003c 	lw	a1,60(s8)
  801b5c:	00a42021 	addu	a0,a1,a0
  801b60:	afc4003c 	sw	a0,60(s8)
  801b64:	8fc50030 	lw	a1,48(s8)
  801b68:	8fc4003c 	lw	a0,60(s8)
  801b6c:	00043080 	sll	a2,a0,0x2
  801b70:	8fc4003c 	lw	a0,60(s8)
  801b74:	00c42021 	addu	a0,a2,a0
  801b78:	00042040 	sll	a0,a0,0x1
  801b7c:	00a42023 	subu	a0,a1,a0
  801b80:	afc40038 	sw	a0,56(s8)
  801b84:	8fc4003c 	lw	a0,60(s8)
  801b88:	afc40030 	sw	a0,48(s8)
  801b8c:	afc00034 	sw	zero,52(s8)
  801b90:	08200728 	j	801ca0 <printnum+0x250>
  801b94:	00000000 	nop
  801b98:	8fc50068 	lw	a1,104(s8)
  801b9c:	24040010 	li	a0,16
  801ba0:	14a4000f 	bne	a1,a0,801be0 <printnum+0x190>
  801ba4:	00000000 	nop
  801ba8:	8fc40030 	lw	a0,48(s8)
  801bac:	3084000f 	andi	a0,a0,0xf
  801bb0:	afc40038 	sw	a0,56(s8)
  801bb4:	8fc40034 	lw	a0,52(s8)
  801bb8:	00042700 	sll	a0,a0,0x1c
  801bbc:	8fc50030 	lw	a1,48(s8)
  801bc0:	00052902 	srl	a1,a1,0x4
  801bc4:	00a42025 	or	a0,a1,a0
  801bc8:	afc40030 	sw	a0,48(s8)
  801bcc:	8fc40034 	lw	a0,52(s8)
  801bd0:	00042102 	srl	a0,a0,0x4
  801bd4:	afc40034 	sw	a0,52(s8)
  801bd8:	08200728 	j	801ca0 <printnum+0x250>
  801bdc:	00000000 	nop
  801be0:	8fc50068 	lw	a1,104(s8)
  801be4:	24040008 	li	a0,8
  801be8:	14a4000f 	bne	a1,a0,801c28 <printnum+0x1d8>
  801bec:	00000000 	nop
  801bf0:	8fc40030 	lw	a0,48(s8)
  801bf4:	30840007 	andi	a0,a0,0x7
  801bf8:	afc40038 	sw	a0,56(s8)
  801bfc:	8fc40034 	lw	a0,52(s8)
  801c00:	00042740 	sll	a0,a0,0x1d
  801c04:	8fc50030 	lw	a1,48(s8)
  801c08:	000528c2 	srl	a1,a1,0x3
  801c0c:	00a42025 	or	a0,a1,a0
  801c10:	afc40030 	sw	a0,48(s8)
  801c14:	8fc40034 	lw	a0,52(s8)
  801c18:	000420c2 	srl	a0,a0,0x3
  801c1c:	afc40034 	sw	a0,52(s8)
  801c20:	08200728 	j	801ca0 <printnum+0x250>
  801c24:	00000000 	nop
  801c28:	8fc50068 	lw	a1,104(s8)
  801c2c:	3c048000 	lui	a0,0x8000
  801c30:	14a40011 	bne	a1,a0,801c78 <printnum+0x228>
  801c34:	00000000 	nop
  801c38:	8fc50030 	lw	a1,48(s8)
  801c3c:	3c047fff 	lui	a0,0x7fff
  801c40:	3484ffff 	ori	a0,a0,0xffff
  801c44:	00a42024 	and	a0,a1,a0
  801c48:	afc40038 	sw	a0,56(s8)
  801c4c:	8fc40034 	lw	a0,52(s8)
  801c50:	00042040 	sll	a0,a0,0x1
  801c54:	8fc50030 	lw	a1,48(s8)
  801c58:	00052fc2 	srl	a1,a1,0x1f
  801c5c:	00a42025 	or	a0,a1,a0
  801c60:	afc40030 	sw	a0,48(s8)
  801c64:	8fc40034 	lw	a0,52(s8)
  801c68:	000427c2 	srl	a0,a0,0x1f
  801c6c:	afc40034 	sw	a0,52(s8)
  801c70:	08200728 	j	801ca0 <printnum+0x250>
  801c74:	00000000 	nop
  801c78:	24040003 	li	a0,3
  801c7c:	afc40038 	sw	a0,56(s8)
  801c80:	24040001 	li	a0,1
  801c84:	00002821 	move	a1,zero
  801c88:	00800013 	mtlo	a0
  801c8c:	00a00011 	mthi	a1
  801c90:	00002012 	mflo	a0
  801c94:	00002810 	mfhi	a1
  801c98:	afc40030 	sw	a0,48(s8)
  801c9c:	afc50034 	sw	a1,52(s8)
  801ca0:	8fc40038 	lw	a0,56(s8)
  801ca4:	afc40040 	sw	a0,64(s8)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  801ca8:	8fc40068 	lw	a0,104(s8)
  801cac:	00801021 	move	v0,a0
  801cb0:	00001821 	move	v1,zero
  801cb4:	8fc40064 	lw	a0,100(s8)
  801cb8:	0083202b 	sltu	a0,a0,v1
  801cbc:	14800026 	bnez	a0,801d58 <printnum+0x308>
  801cc0:	00000000 	nop
  801cc4:	8fc50064 	lw	a1,100(s8)
  801cc8:	00602021 	move	a0,v1
  801ccc:	14a40005 	bne	a1,a0,801ce4 <printnum+0x294>
  801cd0:	00000000 	nop
  801cd4:	8fc40060 	lw	a0,96(s8)
  801cd8:	0082102b 	sltu	v0,a0,v0
  801cdc:	1440001e 	bnez	v0,801d58 <printnum+0x308>
  801ce0:	00000000 	nop
        printnum(putch, fd, putdat, result, base, width - 1, padc);
  801ce4:	8fc2006c 	lw	v0,108(s8)
  801ce8:	2442ffff 	addiu	v0,v0,-1
  801cec:	8fc40030 	lw	a0,48(s8)
  801cf0:	8fc50034 	lw	a1,52(s8)
  801cf4:	00800013 	mtlo	a0
  801cf8:	00a00011 	mthi	a1
  801cfc:	00002012 	mflo	a0
  801d00:	00002810 	mfhi	a1
  801d04:	afa40010 	sw	a0,16(sp)
  801d08:	afa50014 	sw	a1,20(sp)
  801d0c:	8fc30068 	lw	v1,104(s8)
  801d10:	afa30018 	sw	v1,24(sp)
  801d14:	afa2001c 	sw	v0,28(sp)
  801d18:	8fc20070 	lw	v0,112(s8)
  801d1c:	afa20020 	sw	v0,32(sp)
  801d20:	8fc40050 	lw	a0,80(s8)
  801d24:	8fc50054 	lw	a1,84(s8)
  801d28:	8fc60058 	lw	a2,88(s8)
  801d2c:	0c200694 	jal	801a50 <printnum>
  801d30:	00000000 	nop
  801d34:	0820075c 	j	801d70 <printnum+0x320>
  801d38:	00000000 	nop
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat, fd);
  801d3c:	8fc20050 	lw	v0,80(s8)
  801d40:	8fc40070 	lw	a0,112(s8)
  801d44:	8fc50058 	lw	a1,88(s8)
  801d48:	8fc60054 	lw	a2,84(s8)
  801d4c:	0040c821 	move	t9,v0
  801d50:	0320f809 	jalr	t9
  801d54:	00000000 	nop
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, fd, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  801d58:	8fc2006c 	lw	v0,108(s8)
  801d5c:	2442ffff 	addiu	v0,v0,-1
  801d60:	afc2006c 	sw	v0,108(s8)
  801d64:	8fc2006c 	lw	v0,108(s8)
  801d68:	1c40fff4 	bgtz	v0,801d3c <printnum+0x2ec>
  801d6c:	00000000 	nop
            putch(padc, putdat, fd);
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat, fd);
  801d70:	3c020080 	lui	v0,0x80
  801d74:	24433bb0 	addiu	v1,v0,15280
  801d78:	8fc20040 	lw	v0,64(s8)
  801d7c:	00621021 	addu	v0,v1,v0
  801d80:	80420000 	lb	v0,0(v0)
  801d84:	00401821 	move	v1,v0
  801d88:	8fc20050 	lw	v0,80(s8)
  801d8c:	00602021 	move	a0,v1
  801d90:	8fc50058 	lw	a1,88(s8)
  801d94:	8fc60054 	lw	a2,84(s8)
  801d98:	0040c821 	move	t9,v0
  801d9c:	0320f809 	jalr	t9
  801da0:	00000000 	nop
}
  801da4:	03c0e821 	move	sp,s8
  801da8:	8fbf004c 	lw	ra,76(sp)
  801dac:	8fbe0048 	lw	s8,72(sp)
  801db0:	27bd0050 	addiu	sp,sp,80
  801db4:	03e00008 	jr	ra
  801db8:	00000000 	nop

00801dbc <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:         a varargs list pointer
 * @lflag:      determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  801dbc:	27bdfff8 	addiu	sp,sp,-8
  801dc0:	afbe0004 	sw	s8,4(sp)
  801dc4:	03a0f021 	move	s8,sp
  801dc8:	afc40008 	sw	a0,8(s8)
  801dcc:	afc5000c 	sw	a1,12(s8)
    if (lflag >= 2) {
  801dd0:	8fc4000c 	lw	a0,12(s8)
  801dd4:	28840002 	slti	a0,a0,2
  801dd8:	1480000d 	bnez	a0,801e10 <getuint+0x54>
  801ddc:	00000000 	nop
        return va_arg(*ap, unsigned long long);
  801de0:	8fc20008 	lw	v0,8(s8)
  801de4:	8c420000 	lw	v0,0(v0)
  801de8:	24430007 	addiu	v1,v0,7
  801dec:	2402fff8 	li	v0,-8
  801df0:	00621024 	and	v0,v1,v0
  801df4:	24440008 	addiu	a0,v0,8
  801df8:	8fc30008 	lw	v1,8(s8)
  801dfc:	ac640000 	sw	a0,0(v1)
  801e00:	8c430004 	lw	v1,4(v0)
  801e04:	8c420000 	lw	v0,0(v0)
  801e08:	08200799 	j	801e64 <getuint+0xa8>
  801e0c:	00000000 	nop
    }
    else if (lflag) {
  801e10:	8fc4000c 	lw	a0,12(s8)
  801e14:	1080000b 	beqz	a0,801e44 <getuint+0x88>
  801e18:	00000000 	nop
        return va_arg(*ap, unsigned long);
  801e1c:	8fc40008 	lw	a0,8(s8)
  801e20:	8c840000 	lw	a0,0(a0)
  801e24:	24860004 	addiu	a2,a0,4
  801e28:	8fc50008 	lw	a1,8(s8)
  801e2c:	aca60000 	sw	a2,0(a1)
  801e30:	8c840000 	lw	a0,0(a0)
  801e34:	00801021 	move	v0,a0
  801e38:	00001821 	move	v1,zero
  801e3c:	08200799 	j	801e64 <getuint+0xa8>
  801e40:	00000000 	nop
    }
    else {
        return va_arg(*ap, unsigned int);
  801e44:	8fc40008 	lw	a0,8(s8)
  801e48:	8c840000 	lw	a0,0(a0)
  801e4c:	24860004 	addiu	a2,a0,4
  801e50:	8fc50008 	lw	a1,8(s8)
  801e54:	aca60000 	sw	a2,0(a1)
  801e58:	8c840000 	lw	a0,0(a0)
  801e5c:	00801021 	move	v0,a0
  801e60:	00001821 	move	v1,zero
  801e64:	00400013 	mtlo	v0
  801e68:	00600011 	mthi	v1
    }
}
  801e6c:	00001012 	mflo	v0
  801e70:	00001810 	mfhi	v1
  801e74:	03c0e821 	move	sp,s8
  801e78:	8fbe0004 	lw	s8,4(sp)
  801e7c:	27bd0008 	addiu	sp,sp,8
  801e80:	03e00008 	jr	ra
  801e84:	00000000 	nop

00801e88 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:         a varargs list pointer
 * @lflag:      determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  801e88:	27bdfff8 	addiu	sp,sp,-8
  801e8c:	afbe0004 	sw	s8,4(sp)
  801e90:	03a0f021 	move	s8,sp
  801e94:	afc40008 	sw	a0,8(s8)
  801e98:	afc5000c 	sw	a1,12(s8)
    if (lflag >= 2) {
  801e9c:	8fc4000c 	lw	a0,12(s8)
  801ea0:	28840002 	slti	a0,a0,2
  801ea4:	1480000d 	bnez	a0,801edc <getint+0x54>
  801ea8:	00000000 	nop
        return va_arg(*ap, long long);
  801eac:	8fc20008 	lw	v0,8(s8)
  801eb0:	8c420000 	lw	v0,0(v0)
  801eb4:	24430007 	addiu	v1,v0,7
  801eb8:	2402fff8 	li	v0,-8
  801ebc:	00621024 	and	v0,v1,v0
  801ec0:	24440008 	addiu	a0,v0,8
  801ec4:	8fc30008 	lw	v1,8(s8)
  801ec8:	ac640000 	sw	a0,0(v1)
  801ecc:	8c430004 	lw	v1,4(v0)
  801ed0:	8c420000 	lw	v0,0(v0)
  801ed4:	082007ce 	j	801f38 <getint+0xb0>
  801ed8:	00000000 	nop
    }
    else if (lflag) {
  801edc:	8fc4000c 	lw	a0,12(s8)
  801ee0:	1080000c 	beqz	a0,801f14 <getint+0x8c>
  801ee4:	00000000 	nop
        return va_arg(*ap, long);
  801ee8:	8fc40008 	lw	a0,8(s8)
  801eec:	8c840000 	lw	a0,0(a0)
  801ef0:	24860004 	addiu	a2,a0,4
  801ef4:	8fc50008 	lw	a1,8(s8)
  801ef8:	aca60000 	sw	a2,0(a1)
  801efc:	8c840000 	lw	a0,0(a0)
  801f00:	00801021 	move	v0,a0
  801f04:	000427c3 	sra	a0,a0,0x1f
  801f08:	00801821 	move	v1,a0
  801f0c:	082007ce 	j	801f38 <getint+0xb0>
  801f10:	00000000 	nop
    }
    else {
        return va_arg(*ap, int);
  801f14:	8fc40008 	lw	a0,8(s8)
  801f18:	8c840000 	lw	a0,0(a0)
  801f1c:	24860004 	addiu	a2,a0,4
  801f20:	8fc50008 	lw	a1,8(s8)
  801f24:	aca60000 	sw	a2,0(a1)
  801f28:	8c840000 	lw	a0,0(a0)
  801f2c:	00801021 	move	v0,a0
  801f30:	000427c3 	sra	a0,a0,0x1f
  801f34:	00801821 	move	v1,a0
  801f38:	00400013 	mtlo	v0
  801f3c:	00600011 	mthi	v1
    }
}
  801f40:	00001012 	mflo	v0
  801f44:	00001810 	mfhi	v1
  801f48:	03c0e821 	move	sp,s8
  801f4c:	8fbe0004 	lw	s8,4(sp)
  801f50:	27bd0008 	addiu	sp,sp,8
  801f54:	03e00008 	jr	ra
  801f58:	00000000 	nop

00801f5c <printfmt>:
 * @fd:         file descriptor
 * @putdat:     used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*, int), int fd, void *putdat, const char *fmt, ...) {
  801f5c:	27bdffd0 	addiu	sp,sp,-48
  801f60:	afbf002c 	sw	ra,44(sp)
  801f64:	afbe0028 	sw	s8,40(sp)
  801f68:	03a0f021 	move	s8,sp
  801f6c:	afc40030 	sw	a0,48(s8)
  801f70:	afc50034 	sw	a1,52(s8)
  801f74:	afc60038 	sw	a2,56(s8)
  801f78:	afc7003c 	sw	a3,60(s8)
    va_list ap;

    va_start(ap, fmt);
  801f7c:	27c20040 	addiu	v0,s8,64
  801f80:	afc20020 	sw	v0,32(s8)
    vprintfmt(putch, fd, putdat, fmt, ap);
  801f84:	8fc20020 	lw	v0,32(s8)
  801f88:	afa20010 	sw	v0,16(sp)
  801f8c:	8fc40030 	lw	a0,48(s8)
  801f90:	8fc50034 	lw	a1,52(s8)
  801f94:	8fc60038 	lw	a2,56(s8)
  801f98:	8fc7003c 	lw	a3,60(s8)
  801f9c:	0c2007ef 	jal	801fbc <vprintfmt>
  801fa0:	00000000 	nop
    va_end(ap);
}
  801fa4:	03c0e821 	move	sp,s8
  801fa8:	8fbf002c 	lw	ra,44(sp)
  801fac:	8fbe0028 	lw	s8,40(sp)
  801fb0:	27bd0030 	addiu	sp,sp,48
  801fb4:	03e00008 	jr	ra
  801fb8:	00000000 	nop

00801fbc <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*, int), int fd, void *putdat, const char *fmt, va_list ap) {
  801fbc:	27bdffa0 	addiu	sp,sp,-96
  801fc0:	afbf005c 	sw	ra,92(sp)
  801fc4:	afbe0058 	sw	s8,88(sp)
  801fc8:	afb10054 	sw	s1,84(sp)
  801fcc:	afb00050 	sw	s0,80(sp)
  801fd0:	03a0f021 	move	s8,sp
  801fd4:	afc40060 	sw	a0,96(s8)
  801fd8:	afc50064 	sw	a1,100(s8)
  801fdc:	afc60068 	sw	a2,104(s8)
  801fe0:	afc7006c 	sw	a3,108(s8)
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  801fe4:	08200806 	j	802018 <vprintfmt+0x5c>
  801fe8:	00000000 	nop
            if (ch == '\0') {
  801fec:	16000003 	bnez	s0,801ffc <vprintfmt+0x40>
  801ff0:	00000000 	nop
                return;
  801ff4:	08200998 	j	802660 <vprintfmt+0x6a4>
  801ff8:	00000000 	nop
            }
            putch(ch, putdat, fd);
  801ffc:	8fc20060 	lw	v0,96(s8)
  802000:	02002021 	move	a0,s0
  802004:	8fc50068 	lw	a1,104(s8)
  802008:	8fc60064 	lw	a2,100(s8)
  80200c:	0040c821 	move	t9,v0
  802010:	0320f809 	jalr	t9
  802014:	00000000 	nop
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  802018:	8fc2006c 	lw	v0,108(s8)
  80201c:	24430001 	addiu	v1,v0,1
  802020:	afc3006c 	sw	v1,108(s8)
  802024:	90420000 	lbu	v0,0(v0)
  802028:	00408021 	move	s0,v0
  80202c:	24020025 	li	v0,37
  802030:	1602ffee 	bne	s0,v0,801fec <vprintfmt+0x30>
  802034:	00000000 	nop
            }
            putch(ch, putdat, fd);
        }

        // Process a %-escape sequence
        char padc = ' ';
  802038:	24020020 	li	v0,32
  80203c:	a3c2004c 	sb	v0,76(s8)
        width = precision = -1;
  802040:	2402ffff 	li	v0,-1
  802044:	afc20040 	sw	v0,64(s8)
  802048:	8fc20040 	lw	v0,64(s8)
  80204c:	afc2003c 	sw	v0,60(s8)
        lflag = altflag = 0;
  802050:	afc00048 	sw	zero,72(s8)
  802054:	8fc20048 	lw	v0,72(s8)
  802058:	afc20044 	sw	v0,68(s8)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  80205c:	8fc2006c 	lw	v0,108(s8)
  802060:	24430001 	addiu	v1,v0,1
  802064:	afc3006c 	sw	v1,108(s8)
  802068:	90420000 	lbu	v0,0(v0)
  80206c:	00408021 	move	s0,v0
  802070:	2602ffdd 	addiu	v0,s0,-35
  802074:	2c430056 	sltiu	v1,v0,86
  802078:	10600160 	beqz	v1,8025fc <vprintfmt+0x640>
  80207c:	00000000 	nop
  802080:	00021880 	sll	v1,v0,0x2
  802084:	3c020080 	lui	v0,0x80
  802088:	24423bdc 	addiu	v0,v0,15324
  80208c:	00621021 	addu	v0,v1,v0
  802090:	8c420000 	lw	v0,0(v0)
  802094:	00400008 	jr	v0
  802098:	00000000 	nop

        // flag to pad on the right
        case '-':
            padc = '-';
  80209c:	2402002d 	li	v0,45
  8020a0:	a3c2004c 	sb	v0,76(s8)
            goto reswitch;
  8020a4:	08200817 	j	80205c <vprintfmt+0xa0>
  8020a8:	00000000 	nop

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  8020ac:	24020030 	li	v0,48
  8020b0:	a3c2004c 	sb	v0,76(s8)
            goto reswitch;
  8020b4:	08200817 	j	80205c <vprintfmt+0xa0>
  8020b8:	00000000 	nop

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  8020bc:	afc00040 	sw	zero,64(s8)
                precision = precision * 10 + ch - '0';
  8020c0:	8fc20040 	lw	v0,64(s8)
  8020c4:	00021040 	sll	v0,v0,0x1
  8020c8:	00021880 	sll	v1,v0,0x2
  8020cc:	00431021 	addu	v0,v0,v1
  8020d0:	00501021 	addu	v0,v0,s0
  8020d4:	2442ffd0 	addiu	v0,v0,-48
  8020d8:	afc20040 	sw	v0,64(s8)
                ch = *fmt;
  8020dc:	8fc2006c 	lw	v0,108(s8)
  8020e0:	80420000 	lb	v0,0(v0)
  8020e4:	00408021 	move	s0,v0
                if (ch < '0' || ch > '9') {
  8020e8:	2a020030 	slti	v0,s0,48
  8020ec:	14400009 	bnez	v0,802114 <vprintfmt+0x158>
  8020f0:	00000000 	nop
  8020f4:	2a02003a 	slti	v0,s0,58
  8020f8:	10400006 	beqz	v0,802114 <vprintfmt+0x158>
  8020fc:	00000000 	nop
            padc = '0';
            goto reswitch;

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  802100:	8fc2006c 	lw	v0,108(s8)
  802104:	24420001 	addiu	v0,v0,1
  802108:	afc2006c 	sw	v0,108(s8)
                precision = precision * 10 + ch - '0';
                ch = *fmt;
                if (ch < '0' || ch > '9') {
                    break;
                }
            }
  80210c:	08200830 	j	8020c0 <vprintfmt+0x104>
  802110:	00000000 	nop
            goto process_precision;
  802114:	0820085a 	j	802168 <vprintfmt+0x1ac>
  802118:	00000000 	nop

        case '*':
            precision = va_arg(ap, int);
  80211c:	8fc20070 	lw	v0,112(s8)
  802120:	24430004 	addiu	v1,v0,4
  802124:	afc30070 	sw	v1,112(s8)
  802128:	8c420000 	lw	v0,0(v0)
  80212c:	afc20040 	sw	v0,64(s8)
            goto process_precision;
  802130:	0820085a 	j	802168 <vprintfmt+0x1ac>
  802134:	00000000 	nop

        case '.':
            if (width < 0)
  802138:	8fc2003c 	lw	v0,60(s8)
  80213c:	04410004 	bgez	v0,802150 <vprintfmt+0x194>
  802140:	00000000 	nop
                width = 0;
  802144:	afc0003c 	sw	zero,60(s8)
            goto reswitch;
  802148:	08200817 	j	80205c <vprintfmt+0xa0>
  80214c:	00000000 	nop
  802150:	08200817 	j	80205c <vprintfmt+0xa0>
  802154:	00000000 	nop

        case '#':
            altflag = 1;
  802158:	24020001 	li	v0,1
  80215c:	afc20048 	sw	v0,72(s8)
            goto reswitch;
  802160:	08200817 	j	80205c <vprintfmt+0xa0>
  802164:	00000000 	nop

        process_precision:
            if (width < 0)
  802168:	8fc2003c 	lw	v0,60(s8)
  80216c:	04410007 	bgez	v0,80218c <vprintfmt+0x1d0>
  802170:	00000000 	nop
                width = precision, precision = -1;
  802174:	8fc20040 	lw	v0,64(s8)
  802178:	afc2003c 	sw	v0,60(s8)
  80217c:	2402ffff 	li	v0,-1
  802180:	afc20040 	sw	v0,64(s8)
            goto reswitch;
  802184:	08200817 	j	80205c <vprintfmt+0xa0>
  802188:	00000000 	nop
  80218c:	08200817 	j	80205c <vprintfmt+0xa0>
  802190:	00000000 	nop

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  802194:	8fc20044 	lw	v0,68(s8)
  802198:	24420001 	addiu	v0,v0,1
  80219c:	afc20044 	sw	v0,68(s8)
            goto reswitch;
  8021a0:	08200817 	j	80205c <vprintfmt+0xa0>
  8021a4:	00000000 	nop

        // character
        case 'c':
            putch(va_arg(ap, int), putdat, fd);
  8021a8:	8fc20070 	lw	v0,112(s8)
  8021ac:	24430004 	addiu	v1,v0,4
  8021b0:	afc30070 	sw	v1,112(s8)
  8021b4:	8c430000 	lw	v1,0(v0)
  8021b8:	8fc20060 	lw	v0,96(s8)
  8021bc:	00602021 	move	a0,v1
  8021c0:	8fc50068 	lw	a1,104(s8)
  8021c4:	8fc60064 	lw	a2,100(s8)
  8021c8:	0040c821 	move	t9,v0
  8021cc:	0320f809 	jalr	t9
  8021d0:	00000000 	nop
            break;
  8021d4:	08200995 	j	802654 <vprintfmt+0x698>
  8021d8:	00000000 	nop

        // error message
        case 'e':
            err = va_arg(ap, int);
  8021dc:	8fc20070 	lw	v0,112(s8)
  8021e0:	24430004 	addiu	v1,v0,4
  8021e4:	afc30070 	sw	v1,112(s8)
  8021e8:	8c5f0000 	lw	ra,0(v0)
            if (err < 0) {
  8021ec:	07e10002 	bgez	ra,8021f8 <vprintfmt+0x23c>
  8021f0:	00000000 	nop
                err = -err;
  8021f4:	001ff823 	negu	ra,ra
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  8021f8:	2be20019 	slti	v0,ra,25
  8021fc:	10400008 	beqz	v0,802220 <vprintfmt+0x264>
  802200:	00000000 	nop
  802204:	3c020080 	lui	v0,0x80
  802208:	001f1880 	sll	v1,ra,0x2
  80220c:	24423b4c 	addiu	v0,v0,15180
  802210:	00621021 	addu	v0,v1,v0
  802214:	8c510000 	lw	s1,0(v0)
  802218:	1620000b 	bnez	s1,802248 <vprintfmt+0x28c>
  80221c:	00000000 	nop
                printfmt(putch, fd, putdat, "error %d", err);
  802220:	afbf0010 	sw	ra,16(sp)
  802224:	8fc40060 	lw	a0,96(s8)
  802228:	8fc50064 	lw	a1,100(s8)
  80222c:	8fc60068 	lw	a2,104(s8)
  802230:	3c020080 	lui	v0,0x80
  802234:	24473bc4 	addiu	a3,v0,15300
  802238:	0c2007d7 	jal	801f5c <printfmt>
  80223c:	00000000 	nop
            }
            else {
                printfmt(putch, fd, putdat, "%s", p);
            }
            break;
  802240:	08200995 	j	802654 <vprintfmt+0x698>
  802244:	00000000 	nop
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
                printfmt(putch, fd, putdat, "error %d", err);
            }
            else {
                printfmt(putch, fd, putdat, "%s", p);
  802248:	afb10010 	sw	s1,16(sp)
  80224c:	8fc40060 	lw	a0,96(s8)
  802250:	8fc50064 	lw	a1,100(s8)
  802254:	8fc60068 	lw	a2,104(s8)
  802258:	3c020080 	lui	v0,0x80
  80225c:	24473bd0 	addiu	a3,v0,15312
  802260:	0c2007d7 	jal	801f5c <printfmt>
  802264:	00000000 	nop
            }
            break;
  802268:	08200995 	j	802654 <vprintfmt+0x698>
  80226c:	00000000 	nop

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  802270:	8fc20070 	lw	v0,112(s8)
  802274:	24430004 	addiu	v1,v0,4
  802278:	afc30070 	sw	v1,112(s8)
  80227c:	8c510000 	lw	s1,0(v0)
  802280:	16200003 	bnez	s1,802290 <vprintfmt+0x2d4>
  802284:	00000000 	nop
                p = "(null)";
  802288:	3c020080 	lui	v0,0x80
  80228c:	24513bd4 	addiu	s1,v0,15316
            }
            if (width > 0 && padc != '-') {
  802290:	8fc2003c 	lw	v0,60(s8)
  802294:	1840001d 	blez	v0,80230c <vprintfmt+0x350>
  802298:	00000000 	nop
  80229c:	83c3004c 	lb	v1,76(s8)
  8022a0:	2402002d 	li	v0,45
  8022a4:	10620019 	beq	v1,v0,80230c <vprintfmt+0x350>
  8022a8:	00000000 	nop
                for (width -= strnlen(p, precision); width > 0; width --) {
  8022ac:	8fd0003c 	lw	s0,60(s8)
  8022b0:	8fc20040 	lw	v0,64(s8)
  8022b4:	02202021 	move	a0,s1
  8022b8:	00402821 	move	a1,v0
  8022bc:	0c200a4a 	jal	802928 <strnlen>
  8022c0:	00000000 	nop
  8022c4:	02021023 	subu	v0,s0,v0
  8022c8:	afc2003c 	sw	v0,60(s8)
  8022cc:	082008c0 	j	802300 <vprintfmt+0x344>
  8022d0:	00000000 	nop
                    putch(padc, putdat, fd);
  8022d4:	83c3004c 	lb	v1,76(s8)
  8022d8:	8fc20060 	lw	v0,96(s8)
  8022dc:	00602021 	move	a0,v1
  8022e0:	8fc50068 	lw	a1,104(s8)
  8022e4:	8fc60064 	lw	a2,100(s8)
  8022e8:	0040c821 	move	t9,v0
  8022ec:	0320f809 	jalr	t9
  8022f0:	00000000 	nop
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
                p = "(null)";
            }
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
  8022f4:	8fc2003c 	lw	v0,60(s8)
  8022f8:	2442ffff 	addiu	v0,v0,-1
  8022fc:	afc2003c 	sw	v0,60(s8)
  802300:	8fc2003c 	lw	v0,60(s8)
  802304:	1c40fff3 	bgtz	v0,8022d4 <vprintfmt+0x318>
  802308:	00000000 	nop
                    putch(padc, putdat, fd);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  80230c:	082008e1 	j	802384 <vprintfmt+0x3c8>
  802310:	00000000 	nop
                if (altflag && (ch < ' ' || ch > '~')) {
  802314:	8fc20048 	lw	v0,72(s8)
  802318:	10400010 	beqz	v0,80235c <vprintfmt+0x3a0>
  80231c:	00000000 	nop
  802320:	2a020020 	slti	v0,s0,32
  802324:	14400004 	bnez	v0,802338 <vprintfmt+0x37c>
  802328:	00000000 	nop
  80232c:	2a02007f 	slti	v0,s0,127
  802330:	1440000a 	bnez	v0,80235c <vprintfmt+0x3a0>
  802334:	00000000 	nop
                    putch('?', putdat, fd);
  802338:	8fc20060 	lw	v0,96(s8)
  80233c:	2404003f 	li	a0,63
  802340:	8fc50068 	lw	a1,104(s8)
  802344:	8fc60064 	lw	a2,100(s8)
  802348:	0040c821 	move	t9,v0
  80234c:	0320f809 	jalr	t9
  802350:	00000000 	nop
  802354:	082008de 	j	802378 <vprintfmt+0x3bc>
  802358:	00000000 	nop
                }
                else {
                    putch(ch, putdat, fd);
  80235c:	8fc20060 	lw	v0,96(s8)
  802360:	02002021 	move	a0,s0
  802364:	8fc50068 	lw	a1,104(s8)
  802368:	8fc60064 	lw	a2,100(s8)
  80236c:	0040c821 	move	t9,v0
  802370:	0320f809 	jalr	t9
  802374:	00000000 	nop
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
                    putch(padc, putdat, fd);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  802378:	8fc2003c 	lw	v0,60(s8)
  80237c:	2442ffff 	addiu	v0,v0,-1
  802380:	afc2003c 	sw	v0,60(s8)
  802384:	02201021 	move	v0,s1
  802388:	24510001 	addiu	s1,v0,1
  80238c:	80420000 	lb	v0,0(v0)
  802390:	00408021 	move	s0,v0
  802394:	1200000a 	beqz	s0,8023c0 <vprintfmt+0x404>
  802398:	00000000 	nop
  80239c:	8fc20040 	lw	v0,64(s8)
  8023a0:	0440ffdc 	bltz	v0,802314 <vprintfmt+0x358>
  8023a4:	00000000 	nop
  8023a8:	8fc20040 	lw	v0,64(s8)
  8023ac:	2442ffff 	addiu	v0,v0,-1
  8023b0:	afc20040 	sw	v0,64(s8)
  8023b4:	8fc20040 	lw	v0,64(s8)
  8023b8:	0441ffd6 	bgez	v0,802314 <vprintfmt+0x358>
  8023bc:	00000000 	nop
                }
                else {
                    putch(ch, putdat, fd);
                }
            }
            for (; width > 0; width --) {
  8023c0:	082008fc 	j	8023f0 <vprintfmt+0x434>
  8023c4:	00000000 	nop
                putch(' ', putdat, fd);
  8023c8:	8fc20060 	lw	v0,96(s8)
  8023cc:	24040020 	li	a0,32
  8023d0:	8fc50068 	lw	a1,104(s8)
  8023d4:	8fc60064 	lw	a2,100(s8)
  8023d8:	0040c821 	move	t9,v0
  8023dc:	0320f809 	jalr	t9
  8023e0:	00000000 	nop
                }
                else {
                    putch(ch, putdat, fd);
                }
            }
            for (; width > 0; width --) {
  8023e4:	8fc2003c 	lw	v0,60(s8)
  8023e8:	2442ffff 	addiu	v0,v0,-1
  8023ec:	afc2003c 	sw	v0,60(s8)
  8023f0:	8fc2003c 	lw	v0,60(s8)
  8023f4:	1c40fff4 	bgtz	v0,8023c8 <vprintfmt+0x40c>
  8023f8:	00000000 	nop
                putch(' ', putdat, fd);
            }
            break;
  8023fc:	08200995 	j	802654 <vprintfmt+0x698>
  802400:	00000000 	nop

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  802404:	27c20070 	addiu	v0,s8,112
  802408:	00402021 	move	a0,v0
  80240c:	8fc50044 	lw	a1,68(s8)
  802410:	0c2007a2 	jal	801e88 <getint>
  802414:	00000000 	nop
  802418:	00400013 	mtlo	v0
  80241c:	00600011 	mthi	v1
  802420:	00001012 	mflo	v0
  802424:	00001810 	mfhi	v1
  802428:	afc20030 	sw	v0,48(s8)
  80242c:	afc30034 	sw	v1,52(s8)
            if ((long long)num < 0) {
  802430:	8fc20030 	lw	v0,48(s8)
  802434:	8fc30034 	lw	v1,52(s8)
  802438:	04610017 	bgez	v1,802498 <vprintfmt+0x4dc>
  80243c:	00000000 	nop
                putch('-', putdat, fd);
  802440:	8fc20060 	lw	v0,96(s8)
  802444:	2404002d 	li	a0,45
  802448:	8fc50068 	lw	a1,104(s8)
  80244c:	8fc60064 	lw	a2,100(s8)
  802450:	0040c821 	move	t9,v0
  802454:	0320f809 	jalr	t9
  802458:	00000000 	nop
                num = -(long long)num;
  80245c:	8fc60030 	lw	a2,48(s8)
  802460:	8fc70034 	lw	a3,52(s8)
  802464:	00002021 	move	a0,zero
  802468:	00002821 	move	a1,zero
  80246c:	00861023 	subu	v0,a0,a2
  802470:	0082402b 	sltu	t0,a0,v0
  802474:	00a71823 	subu	v1,a1,a3
  802478:	00682023 	subu	a0,v1,t0
  80247c:	00801821 	move	v1,a0
  802480:	00400013 	mtlo	v0
  802484:	00600011 	mthi	v1
  802488:	00001012 	mflo	v0
  80248c:	00001810 	mfhi	v1
  802490:	afc20030 	sw	v0,48(s8)
  802494:	afc30034 	sw	v1,52(s8)
            }
            base = 10;
  802498:	2402000a 	li	v0,10
  80249c:	afc20038 	sw	v0,56(s8)
            goto number;
  8024a0:	08200961 	j	802584 <vprintfmt+0x5c8>
  8024a4:	00000000 	nop

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  8024a8:	27c20070 	addiu	v0,s8,112
  8024ac:	00402021 	move	a0,v0
  8024b0:	8fc50044 	lw	a1,68(s8)
  8024b4:	0c20076f 	jal	801dbc <getuint>
  8024b8:	00000000 	nop
  8024bc:	afc20030 	sw	v0,48(s8)
  8024c0:	afc30034 	sw	v1,52(s8)
            base = 10;
  8024c4:	2402000a 	li	v0,10
  8024c8:	afc20038 	sw	v0,56(s8)
            goto number;
  8024cc:	08200961 	j	802584 <vprintfmt+0x5c8>
  8024d0:	00000000 	nop

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  8024d4:	27c20070 	addiu	v0,s8,112
  8024d8:	00402021 	move	a0,v0
  8024dc:	8fc50044 	lw	a1,68(s8)
  8024e0:	0c20076f 	jal	801dbc <getuint>
  8024e4:	00000000 	nop
  8024e8:	afc20030 	sw	v0,48(s8)
  8024ec:	afc30034 	sw	v1,52(s8)
            base = 8;
  8024f0:	24020008 	li	v0,8
  8024f4:	afc20038 	sw	v0,56(s8)
            goto number;
  8024f8:	08200961 	j	802584 <vprintfmt+0x5c8>
  8024fc:	00000000 	nop

        // pointer
        case 'p':
            putch('0', putdat, fd);
  802500:	8fc20060 	lw	v0,96(s8)
  802504:	24040030 	li	a0,48
  802508:	8fc50068 	lw	a1,104(s8)
  80250c:	8fc60064 	lw	a2,100(s8)
  802510:	0040c821 	move	t9,v0
  802514:	0320f809 	jalr	t9
  802518:	00000000 	nop
            putch('x', putdat, fd);
  80251c:	8fc20060 	lw	v0,96(s8)
  802520:	24040078 	li	a0,120
  802524:	8fc50068 	lw	a1,104(s8)
  802528:	8fc60064 	lw	a2,100(s8)
  80252c:	0040c821 	move	t9,v0
  802530:	0320f809 	jalr	t9
  802534:	00000000 	nop
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  802538:	8fc20070 	lw	v0,112(s8)
  80253c:	24430004 	addiu	v1,v0,4
  802540:	afc30070 	sw	v1,112(s8)
  802544:	8c420000 	lw	v0,0(v0)
  802548:	afc20030 	sw	v0,48(s8)
  80254c:	afc00034 	sw	zero,52(s8)
            base = 16;
  802550:	24020010 	li	v0,16
  802554:	afc20038 	sw	v0,56(s8)
            goto number;
  802558:	08200961 	j	802584 <vprintfmt+0x5c8>
  80255c:	00000000 	nop

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  802560:	27c20070 	addiu	v0,s8,112
  802564:	00402021 	move	a0,v0
  802568:	8fc50044 	lw	a1,68(s8)
  80256c:	0c20076f 	jal	801dbc <getuint>
  802570:	00000000 	nop
  802574:	afc20030 	sw	v0,48(s8)
  802578:	afc30034 	sw	v1,52(s8)
            base = 16;
  80257c:	24020010 	li	v0,16
  802580:	afc20038 	sw	v0,56(s8)
        number:
            printnum(putch, fd, putdat, num, base, width, padc);
  802584:	8fc30038 	lw	v1,56(s8)
  802588:	83c2004c 	lb	v0,76(s8)
  80258c:	8fc40030 	lw	a0,48(s8)
  802590:	8fc50034 	lw	a1,52(s8)
  802594:	00800013 	mtlo	a0
  802598:	00a00011 	mthi	a1
  80259c:	00002012 	mflo	a0
  8025a0:	00002810 	mfhi	a1
  8025a4:	afa40010 	sw	a0,16(sp)
  8025a8:	afa50014 	sw	a1,20(sp)
  8025ac:	afa30018 	sw	v1,24(sp)
  8025b0:	8fc3003c 	lw	v1,60(s8)
  8025b4:	afa3001c 	sw	v1,28(sp)
  8025b8:	afa20020 	sw	v0,32(sp)
  8025bc:	8fc40060 	lw	a0,96(s8)
  8025c0:	8fc50064 	lw	a1,100(s8)
  8025c4:	8fc60068 	lw	a2,104(s8)
  8025c8:	0c200694 	jal	801a50 <printnum>
  8025cc:	00000000 	nop
            break;
  8025d0:	08200995 	j	802654 <vprintfmt+0x698>
  8025d4:	00000000 	nop

        // escaped '%' character
        case '%':
            putch(ch, putdat, fd);
  8025d8:	8fc20060 	lw	v0,96(s8)
  8025dc:	02002021 	move	a0,s0
  8025e0:	8fc50068 	lw	a1,104(s8)
  8025e4:	8fc60064 	lw	a2,100(s8)
  8025e8:	0040c821 	move	t9,v0
  8025ec:	0320f809 	jalr	t9
  8025f0:	00000000 	nop
            break;
  8025f4:	08200995 	j	802654 <vprintfmt+0x698>
  8025f8:	00000000 	nop

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat, fd);
  8025fc:	8fc20060 	lw	v0,96(s8)
  802600:	24040025 	li	a0,37
  802604:	8fc50068 	lw	a1,104(s8)
  802608:	8fc60064 	lw	a2,100(s8)
  80260c:	0040c821 	move	t9,v0
  802610:	0320f809 	jalr	t9
  802614:	00000000 	nop
            for (fmt --; fmt[-1] != '%'; fmt --)
  802618:	8fc2006c 	lw	v0,108(s8)
  80261c:	2442ffff 	addiu	v0,v0,-1
  802620:	afc2006c 	sw	v0,108(s8)
  802624:	0820098e 	j	802638 <vprintfmt+0x67c>
  802628:	00000000 	nop
  80262c:	8fc2006c 	lw	v0,108(s8)
  802630:	2442ffff 	addiu	v0,v0,-1
  802634:	afc2006c 	sw	v0,108(s8)
  802638:	8fc2006c 	lw	v0,108(s8)
  80263c:	2442ffff 	addiu	v0,v0,-1
  802640:	80430000 	lb	v1,0(v0)
  802644:	24020025 	li	v0,37
  802648:	1462fff8 	bne	v1,v0,80262c <vprintfmt+0x670>
  80264c:	00000000 	nop
	...
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  802658:	08200806 	j	802018 <vprintfmt+0x5c>
  80265c:	00000000 	nop
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  802660:	03c0e821 	move	sp,s8
  802664:	8fbf005c 	lw	ra,92(sp)
  802668:	8fbe0058 	lw	s8,88(sp)
  80266c:	8fb10054 	lw	s1,84(sp)
  802670:	8fb00050 	lw	s0,80(sp)
  802674:	27bd0060 	addiu	sp,sp,96
  802678:	03e00008 	jr	ra
  80267c:	00000000 	nop

00802680 <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:         the character will be printed
 * @b:          the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  802680:	27bdfff8 	addiu	sp,sp,-8
  802684:	afbe0004 	sw	s8,4(sp)
  802688:	03a0f021 	move	s8,sp
  80268c:	afc40008 	sw	a0,8(s8)
  802690:	afc5000c 	sw	a1,12(s8)
    b->cnt ++;
  802694:	8fc2000c 	lw	v0,12(s8)
  802698:	8c420008 	lw	v0,8(v0)
  80269c:	24430001 	addiu	v1,v0,1
  8026a0:	8fc2000c 	lw	v0,12(s8)
  8026a4:	ac430008 	sw	v1,8(v0)
    if (b->buf < b->ebuf) {
  8026a8:	8fc2000c 	lw	v0,12(s8)
  8026ac:	8c430000 	lw	v1,0(v0)
  8026b0:	8fc2000c 	lw	v0,12(s8)
  8026b4:	8c420004 	lw	v0,4(v0)
  8026b8:	0062102b 	sltu	v0,v1,v0
  8026bc:	1040000a 	beqz	v0,8026e8 <sprintputch+0x68>
  8026c0:	00000000 	nop
        *b->buf ++ = ch;
  8026c4:	8fc2000c 	lw	v0,12(s8)
  8026c8:	8c420000 	lw	v0,0(v0)
  8026cc:	24440001 	addiu	a0,v0,1
  8026d0:	8fc3000c 	lw	v1,12(s8)
  8026d4:	ac640000 	sw	a0,0(v1)
  8026d8:	8fc30008 	lw	v1,8(s8)
  8026dc:	00031e00 	sll	v1,v1,0x18
  8026e0:	00031e03 	sra	v1,v1,0x18
  8026e4:	a0430000 	sb	v1,0(v0)
    }
}
  8026e8:	03c0e821 	move	sp,s8
  8026ec:	8fbe0004 	lw	s8,4(sp)
  8026f0:	27bd0008 	addiu	sp,sp,8
  8026f4:	03e00008 	jr	ra
  8026f8:	00000000 	nop

008026fc <snprintf>:
 * @str:        the buffer to place the result into
 * @size:       the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  8026fc:	27bdffd8 	addiu	sp,sp,-40
  802700:	afbf0024 	sw	ra,36(sp)
  802704:	afbe0020 	sw	s8,32(sp)
  802708:	03a0f021 	move	s8,sp
  80270c:	afc40028 	sw	a0,40(s8)
  802710:	afc5002c 	sw	a1,44(s8)
  802714:	afc70034 	sw	a3,52(s8)
  802718:	afc60030 	sw	a2,48(s8)
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  80271c:	27c20034 	addiu	v0,s8,52
  802720:	afc2001c 	sw	v0,28(s8)
    cnt = vsnprintf(str, size, fmt, ap);
  802724:	8fc2001c 	lw	v0,28(s8)
  802728:	8fc40028 	lw	a0,40(s8)
  80272c:	8fc5002c 	lw	a1,44(s8)
  802730:	8fc60030 	lw	a2,48(s8)
  802734:	00403821 	move	a3,v0
  802738:	0c2009d8 	jal	802760 <vsnprintf>
  80273c:	00000000 	nop
  802740:	afc20018 	sw	v0,24(s8)
    va_end(ap);
    return cnt;
  802744:	8fc20018 	lw	v0,24(s8)
}
  802748:	03c0e821 	move	sp,s8
  80274c:	8fbf0024 	lw	ra,36(sp)
  802750:	8fbe0020 	lw	s8,32(sp)
  802754:	27bd0028 	addiu	sp,sp,40
  802758:	03e00008 	jr	ra
  80275c:	00000000 	nop

00802760 <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  802760:	27bdffc8 	addiu	sp,sp,-56
  802764:	afbf0034 	sw	ra,52(sp)
  802768:	afbe0030 	sw	s8,48(sp)
  80276c:	03a0f021 	move	s8,sp
  802770:	afc40038 	sw	a0,56(s8)
  802774:	afc5003c 	sw	a1,60(s8)
  802778:	afc60040 	sw	a2,64(s8)
  80277c:	afc70044 	sw	a3,68(s8)
    struct sprintbuf b = {str, str + size - 1, 0};
  802780:	8fc20038 	lw	v0,56(s8)
  802784:	afc20020 	sw	v0,32(s8)
  802788:	8fc2003c 	lw	v0,60(s8)
  80278c:	2442ffff 	addiu	v0,v0,-1
  802790:	8fc30038 	lw	v1,56(s8)
  802794:	00621021 	addu	v0,v1,v0
  802798:	afc20024 	sw	v0,36(s8)
  80279c:	afc00028 	sw	zero,40(s8)
    if (str == NULL || b.buf > b.ebuf) {
  8027a0:	8fc20038 	lw	v0,56(s8)
  8027a4:	10400006 	beqz	v0,8027c0 <vsnprintf+0x60>
  8027a8:	00000000 	nop
  8027ac:	8fc30020 	lw	v1,32(s8)
  8027b0:	8fc20024 	lw	v0,36(s8)
  8027b4:	0043102b 	sltu	v0,v0,v1
  8027b8:	10400004 	beqz	v0,8027cc <vsnprintf+0x6c>
  8027bc:	00000000 	nop
        return -E_INVAL;
  8027c0:	2402fffd 	li	v0,-3
  8027c4:	08200a01 	j	802804 <vsnprintf+0xa4>
  8027c8:	00000000 	nop
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, NO_FD, &b, fmt, ap);
  8027cc:	8fc20044 	lw	v0,68(s8)
  8027d0:	afa20010 	sw	v0,16(sp)
  8027d4:	3c020080 	lui	v0,0x80
  8027d8:	24442680 	addiu	a0,v0,9856
  8027dc:	3c02ffff 	lui	v0,0xffff
  8027e0:	34456ad9 	ori	a1,v0,0x6ad9
  8027e4:	27c20020 	addiu	v0,s8,32
  8027e8:	00403021 	move	a2,v0
  8027ec:	8fc70040 	lw	a3,64(s8)
  8027f0:	0c2007ef 	jal	801fbc <vprintfmt>
  8027f4:	00000000 	nop
    // null terminate the buffer
    *b.buf = '\0';
  8027f8:	8fc20020 	lw	v0,32(s8)
  8027fc:	a0400000 	sb	zero,0(v0)
    return b.cnt;
  802800:	8fc20028 	lw	v0,40(s8)
}
  802804:	03c0e821 	move	sp,s8
  802808:	8fbf0034 	lw	ra,52(sp)
  80280c:	8fbe0030 	lw	s8,48(sp)
  802810:	27bd0038 	addiu	sp,sp,56
  802814:	03e00008 	jr	ra
  802818:	00000000 	nop
  80281c:	00000000 	nop

00802820 <rand>:
 * rand - returns a pseudo-random integer
 *
 * The rand() function return a value in the range [0, RAND_MAX].
 * */
int
rand(void) {
  802820:	27bdfff8 	addiu	sp,sp,-8
  802824:	afbe0004 	sw	s8,4(sp)
  802828:	03a0f021 	move	s8,sp
    /*
    next = (next * 0x5DEECE66DLL + 0xBLL) & ((1LL << 48) - 1);
    unsigned long long result = (next >> 12);
    return (int)do_div(result, RAND_MAX + 1);
    */
    next = (unsigned long)next * 1103515245 + 12345;
  80282c:	3c040080 	lui	a0,0x80
  802830:	8c854024 	lw	a1,16420(a0)
  802834:	8c844020 	lw	a0,16416(a0)
  802838:	00802821 	move	a1,a0
  80283c:	3c0441c6 	lui	a0,0x41c6
  802840:	34844e6d 	ori	a0,a0,0x4e6d
  802844:	00a40018 	mult	a1,a0
  802848:	00001012 	mflo	v0
  80284c:	24443039 	addiu	a0,v0,12345
  802850:	00801021 	move	v0,a0
  802854:	00001821 	move	v1,zero
  802858:	3c040080 	lui	a0,0x80
  80285c:	ac824020 	sw	v0,16416(a0)
  802860:	ac834024 	sw	v1,16420(a0)
    return ((unsigned long)next % (RAND_MAX+1));
  802864:	3c020080 	lui	v0,0x80
  802868:	8c434024 	lw	v1,16420(v0)
  80286c:	8c424020 	lw	v0,16416(v0)
  802870:	00401821 	move	v1,v0
  802874:	3c027fff 	lui	v0,0x7fff
  802878:	3442ffff 	ori	v0,v0,0xffff
  80287c:	00621024 	and	v0,v1,v0
}
  802880:	03c0e821 	move	sp,s8
  802884:	8fbe0004 	lw	s8,4(sp)
  802888:	27bd0008 	addiu	sp,sp,8
  80288c:	03e00008 	jr	ra
  802890:	00000000 	nop

00802894 <srand>:
/* *
 * srand - seed the random number generator with the given number
 * @seed:   the required seed number
 * */
void
srand(unsigned int seed) {
  802894:	27bdfff8 	addiu	sp,sp,-8
  802898:	afbe0004 	sw	s8,4(sp)
  80289c:	03a0f021 	move	s8,sp
  8028a0:	afc40008 	sw	a0,8(s8)
    next = seed;
  8028a4:	8fc40008 	lw	a0,8(s8)
  8028a8:	00801021 	move	v0,a0
  8028ac:	00001821 	move	v1,zero
  8028b0:	3c040080 	lui	a0,0x80
  8028b4:	ac824020 	sw	v0,16416(a0)
  8028b8:	ac834024 	sw	v1,16420(a0)
}
  8028bc:	03c0e821 	move	sp,s8
  8028c0:	8fbe0004 	lw	s8,4(sp)
  8028c4:	27bd0008 	addiu	sp,sp,8
  8028c8:	03e00008 	jr	ra
  8028cc:	00000000 	nop

008028d0 <strlen>:
 * @s:      the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  8028d0:	27bdffe8 	addiu	sp,sp,-24
  8028d4:	afbe0014 	sw	s8,20(sp)
  8028d8:	03a0f021 	move	s8,sp
  8028dc:	afc40018 	sw	a0,24(s8)
    size_t cnt = 0;
  8028e0:	afc00008 	sw	zero,8(s8)
    while (*s ++ != '\0') {
  8028e4:	08200a3e 	j	8028f8 <strlen+0x28>
  8028e8:	00000000 	nop
        cnt ++;
  8028ec:	8fc20008 	lw	v0,8(s8)
  8028f0:	24420001 	addiu	v0,v0,1
  8028f4:	afc20008 	sw	v0,8(s8)
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
  8028f8:	8fc20018 	lw	v0,24(s8)
  8028fc:	24430001 	addiu	v1,v0,1
  802900:	afc30018 	sw	v1,24(s8)
  802904:	80420000 	lb	v0,0(v0)
  802908:	1440fff8 	bnez	v0,8028ec <strlen+0x1c>
  80290c:	00000000 	nop
        cnt ++;
    }
    return cnt;
  802910:	8fc20008 	lw	v0,8(s8)
}
  802914:	03c0e821 	move	sp,s8
  802918:	8fbe0014 	lw	s8,20(sp)
  80291c:	27bd0018 	addiu	sp,sp,24
  802920:	03e00008 	jr	ra
  802924:	00000000 	nop

00802928 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  802928:	27bdffe8 	addiu	sp,sp,-24
  80292c:	afbe0014 	sw	s8,20(sp)
  802930:	03a0f021 	move	s8,sp
  802934:	afc40018 	sw	a0,24(s8)
  802938:	afc5001c 	sw	a1,28(s8)
    size_t cnt = 0;
  80293c:	afc00008 	sw	zero,8(s8)
    while (cnt < len && *s ++ != '\0') {
  802940:	08200a55 	j	802954 <strnlen+0x2c>
  802944:	00000000 	nop
        cnt ++;
  802948:	8fc20008 	lw	v0,8(s8)
  80294c:	24420001 	addiu	v0,v0,1
  802950:	afc20008 	sw	v0,8(s8)
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
    while (cnt < len && *s ++ != '\0') {
  802954:	8fc30008 	lw	v1,8(s8)
  802958:	8fc2001c 	lw	v0,28(s8)
  80295c:	0062102b 	sltu	v0,v1,v0
  802960:	10400007 	beqz	v0,802980 <strnlen+0x58>
  802964:	00000000 	nop
  802968:	8fc20018 	lw	v0,24(s8)
  80296c:	24430001 	addiu	v1,v0,1
  802970:	afc30018 	sw	v1,24(s8)
  802974:	80420000 	lb	v0,0(v0)
  802978:	1440fff3 	bnez	v0,802948 <strnlen+0x20>
  80297c:	00000000 	nop
        cnt ++;
    }
    return cnt;
  802980:	8fc20008 	lw	v0,8(s8)
}
  802984:	03c0e821 	move	sp,s8
  802988:	8fbe0014 	lw	s8,20(sp)
  80298c:	27bd0018 	addiu	sp,sp,24
  802990:	03e00008 	jr	ra
  802994:	00000000 	nop

00802998 <strcat>:
 * @dst:    pointer to the @dst array, which should be large enough to contain the concatenated
 *          resulting string.
 * @src:    string to be appended, this should not overlap @dst
 * */
char *
strcat(char *dst, const char *src) {
  802998:	27bdffe0 	addiu	sp,sp,-32
  80299c:	afbf001c 	sw	ra,28(sp)
  8029a0:	afbe0018 	sw	s8,24(sp)
  8029a4:	03a0f021 	move	s8,sp
  8029a8:	afc40020 	sw	a0,32(s8)
  8029ac:	afc50024 	sw	a1,36(s8)
    return strcpy(dst + strlen(dst), src);
  8029b0:	8fc40020 	lw	a0,32(s8)
  8029b4:	0c200a34 	jal	8028d0 <strlen>
  8029b8:	00000000 	nop
  8029bc:	8fc30020 	lw	v1,32(s8)
  8029c0:	00621021 	addu	v0,v1,v0
  8029c4:	00402021 	move	a0,v0
  8029c8:	8fc50024 	lw	a1,36(s8)
  8029cc:	0c200a7b 	jal	8029ec <strcpy>
  8029d0:	00000000 	nop
}
  8029d4:	03c0e821 	move	sp,s8
  8029d8:	8fbf001c 	lw	ra,28(sp)
  8029dc:	8fbe0018 	lw	s8,24(sp)
  8029e0:	27bd0020 	addiu	sp,sp,32
  8029e4:	03e00008 	jr	ra
  8029e8:	00000000 	nop

008029ec <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  8029ec:	27bdffe8 	addiu	sp,sp,-24
  8029f0:	afbe0014 	sw	s8,20(sp)
  8029f4:	03a0f021 	move	s8,sp
  8029f8:	afc40018 	sw	a0,24(s8)
  8029fc:	afc5001c 	sw	a1,28(s8)
#ifdef __HAVE_ARCH_STRCPY
    return __strcpy(dst, src);
#else
    char *p = dst;
  802a00:	8fc20018 	lw	v0,24(s8)
  802a04:	afc20008 	sw	v0,8(s8)
    while ((*p ++ = *src ++) != '\0')
  802a08:	00000000 	nop
  802a0c:	8fc20008 	lw	v0,8(s8)
  802a10:	24430001 	addiu	v1,v0,1
  802a14:	afc30008 	sw	v1,8(s8)
  802a18:	8fc3001c 	lw	v1,28(s8)
  802a1c:	24640001 	addiu	a0,v1,1
  802a20:	afc4001c 	sw	a0,28(s8)
  802a24:	80630000 	lb	v1,0(v1)
  802a28:	a0430000 	sb	v1,0(v0)
  802a2c:	80420000 	lb	v0,0(v0)
  802a30:	1440fff6 	bnez	v0,802a0c <strcpy+0x20>
  802a34:	00000000 	nop
        /* nothing */;
    return dst;
  802a38:	8fc20018 	lw	v0,24(s8)
#endif /* __HAVE_ARCH_STRCPY */
}
  802a3c:	03c0e821 	move	sp,s8
  802a40:	8fbe0014 	lw	s8,20(sp)
  802a44:	27bd0018 	addiu	sp,sp,24
  802a48:	03e00008 	jr	ra
  802a4c:	00000000 	nop

00802a50 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  802a50:	27bdffe8 	addiu	sp,sp,-24
  802a54:	afbe0014 	sw	s8,20(sp)
  802a58:	03a0f021 	move	s8,sp
  802a5c:	afc40018 	sw	a0,24(s8)
  802a60:	afc5001c 	sw	a1,28(s8)
  802a64:	afc60020 	sw	a2,32(s8)
    char *p = dst;
  802a68:	8fc20018 	lw	v0,24(s8)
  802a6c:	afc20008 	sw	v0,8(s8)
    while (len > 0) {
  802a70:	08200aaf 	j	802abc <strncpy+0x6c>
  802a74:	00000000 	nop
        if ((*p = *src) != '\0') {
  802a78:	8fc2001c 	lw	v0,28(s8)
  802a7c:	80430000 	lb	v1,0(v0)
  802a80:	8fc20008 	lw	v0,8(s8)
  802a84:	a0430000 	sb	v1,0(v0)
  802a88:	8fc20008 	lw	v0,8(s8)
  802a8c:	80420000 	lb	v0,0(v0)
  802a90:	10400004 	beqz	v0,802aa4 <strncpy+0x54>
  802a94:	00000000 	nop
            src ++;
  802a98:	8fc2001c 	lw	v0,28(s8)
  802a9c:	24420001 	addiu	v0,v0,1
  802aa0:	afc2001c 	sw	v0,28(s8)
        }
        p ++, len --;
  802aa4:	8fc20008 	lw	v0,8(s8)
  802aa8:	24420001 	addiu	v0,v0,1
  802aac:	afc20008 	sw	v0,8(s8)
  802ab0:	8fc20020 	lw	v0,32(s8)
  802ab4:	2442ffff 	addiu	v0,v0,-1
  802ab8:	afc20020 	sw	v0,32(s8)
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
    char *p = dst;
    while (len > 0) {
  802abc:	8fc20020 	lw	v0,32(s8)
  802ac0:	1440ffed 	bnez	v0,802a78 <strncpy+0x28>
  802ac4:	00000000 	nop
        if ((*p = *src) != '\0') {
            src ++;
        }
        p ++, len --;
    }
    return dst;
  802ac8:	8fc20018 	lw	v0,24(s8)
}
  802acc:	03c0e821 	move	sp,s8
  802ad0:	8fbe0014 	lw	s8,20(sp)
  802ad4:	27bd0018 	addiu	sp,sp,24
  802ad8:	03e00008 	jr	ra
  802adc:	00000000 	nop

00802ae0 <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  802ae0:	27bdfff8 	addiu	sp,sp,-8
  802ae4:	afbe0004 	sw	s8,4(sp)
  802ae8:	03a0f021 	move	s8,sp
  802aec:	afc40008 	sw	a0,8(s8)
  802af0:	afc5000c 	sw	a1,12(s8)
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
  802af4:	08200ac5 	j	802b14 <strcmp+0x34>
  802af8:	00000000 	nop
        s1 ++, s2 ++;
  802afc:	8fc20008 	lw	v0,8(s8)
  802b00:	24420001 	addiu	v0,v0,1
  802b04:	afc20008 	sw	v0,8(s8)
  802b08:	8fc2000c 	lw	v0,12(s8)
  802b0c:	24420001 	addiu	v0,v0,1
  802b10:	afc2000c 	sw	v0,12(s8)
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
  802b14:	8fc20008 	lw	v0,8(s8)
  802b18:	80420000 	lb	v0,0(v0)
  802b1c:	10400007 	beqz	v0,802b3c <strcmp+0x5c>
  802b20:	00000000 	nop
  802b24:	8fc20008 	lw	v0,8(s8)
  802b28:	80430000 	lb	v1,0(v0)
  802b2c:	8fc2000c 	lw	v0,12(s8)
  802b30:	80420000 	lb	v0,0(v0)
  802b34:	1062fff1 	beq	v1,v0,802afc <strcmp+0x1c>
  802b38:	00000000 	nop
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
  802b3c:	8fc20008 	lw	v0,8(s8)
  802b40:	80420000 	lb	v0,0(v0)
  802b44:	304200ff 	andi	v0,v0,0xff
  802b48:	00401821 	move	v1,v0
  802b4c:	8fc2000c 	lw	v0,12(s8)
  802b50:	80420000 	lb	v0,0(v0)
  802b54:	304200ff 	andi	v0,v0,0xff
  802b58:	00621023 	subu	v0,v1,v0
#endif /* __HAVE_ARCH_STRCMP */
}
  802b5c:	03c0e821 	move	sp,s8
  802b60:	8fbe0004 	lw	s8,4(sp)
  802b64:	27bd0008 	addiu	sp,sp,8
  802b68:	03e00008 	jr	ra
  802b6c:	00000000 	nop

00802b70 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  802b70:	27bdfff8 	addiu	sp,sp,-8
  802b74:	afbe0004 	sw	s8,4(sp)
  802b78:	03a0f021 	move	s8,sp
  802b7c:	afc40008 	sw	a0,8(s8)
  802b80:	afc5000c 	sw	a1,12(s8)
  802b84:	afc60010 	sw	a2,16(s8)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  802b88:	08200aed 	j	802bb4 <strncmp+0x44>
  802b8c:	00000000 	nop
        n --, s1 ++, s2 ++;
  802b90:	8fc20010 	lw	v0,16(s8)
  802b94:	2442ffff 	addiu	v0,v0,-1
  802b98:	afc20010 	sw	v0,16(s8)
  802b9c:	8fc20008 	lw	v0,8(s8)
  802ba0:	24420001 	addiu	v0,v0,1
  802ba4:	afc20008 	sw	v0,8(s8)
  802ba8:	8fc2000c 	lw	v0,12(s8)
  802bac:	24420001 	addiu	v0,v0,1
  802bb0:	afc2000c 	sw	v0,12(s8)
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  802bb4:	8fc20010 	lw	v0,16(s8)
  802bb8:	1040000b 	beqz	v0,802be8 <strncmp+0x78>
  802bbc:	00000000 	nop
  802bc0:	8fc20008 	lw	v0,8(s8)
  802bc4:	80420000 	lb	v0,0(v0)
  802bc8:	10400007 	beqz	v0,802be8 <strncmp+0x78>
  802bcc:	00000000 	nop
  802bd0:	8fc20008 	lw	v0,8(s8)
  802bd4:	80430000 	lb	v1,0(v0)
  802bd8:	8fc2000c 	lw	v0,12(s8)
  802bdc:	80420000 	lb	v0,0(v0)
  802be0:	1062ffeb 	beq	v1,v0,802b90 <strncmp+0x20>
  802be4:	00000000 	nop
        n --, s1 ++, s2 ++;
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  802be8:	8fc20010 	lw	v0,16(s8)
  802bec:	1040000b 	beqz	v0,802c1c <strncmp+0xac>
  802bf0:	00000000 	nop
  802bf4:	8fc20008 	lw	v0,8(s8)
  802bf8:	80420000 	lb	v0,0(v0)
  802bfc:	304200ff 	andi	v0,v0,0xff
  802c00:	00401821 	move	v1,v0
  802c04:	8fc2000c 	lw	v0,12(s8)
  802c08:	80420000 	lb	v0,0(v0)
  802c0c:	304200ff 	andi	v0,v0,0xff
  802c10:	00621023 	subu	v0,v1,v0
  802c14:	08200b08 	j	802c20 <strncmp+0xb0>
  802c18:	00000000 	nop
  802c1c:	00001021 	move	v0,zero
}
  802c20:	03c0e821 	move	sp,s8
  802c24:	8fbe0004 	lw	s8,4(sp)
  802c28:	27bd0008 	addiu	sp,sp,8
  802c2c:	03e00008 	jr	ra
  802c30:	00000000 	nop

00802c34 <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  802c34:	27bdfff8 	addiu	sp,sp,-8
  802c38:	afbe0004 	sw	s8,4(sp)
  802c3c:	03a0f021 	move	s8,sp
  802c40:	afc40008 	sw	a0,8(s8)
  802c44:	00a01021 	move	v0,a1
  802c48:	a3c2000c 	sb	v0,12(s8)
    while (*s != '\0') {
  802c4c:	08200b20 	j	802c80 <strchr+0x4c>
  802c50:	00000000 	nop
        if (*s == c) {
  802c54:	8fc20008 	lw	v0,8(s8)
  802c58:	80420000 	lb	v0,0(v0)
  802c5c:	83c3000c 	lb	v1,12(s8)
  802c60:	14620004 	bne	v1,v0,802c74 <strchr+0x40>
  802c64:	00000000 	nop
            return (char *)s;
  802c68:	8fc20008 	lw	v0,8(s8)
  802c6c:	08200b25 	j	802c94 <strchr+0x60>
  802c70:	00000000 	nop
        }
        s ++;
  802c74:	8fc20008 	lw	v0,8(s8)
  802c78:	24420001 	addiu	v0,v0,1
  802c7c:	afc20008 	sw	v0,8(s8)
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
  802c80:	8fc20008 	lw	v0,8(s8)
  802c84:	80420000 	lb	v0,0(v0)
  802c88:	1440fff2 	bnez	v0,802c54 <strchr+0x20>
  802c8c:	00000000 	nop
        if (*s == c) {
            return (char *)s;
        }
        s ++;
    }
    return NULL;
  802c90:	00001021 	move	v0,zero
}
  802c94:	03c0e821 	move	sp,s8
  802c98:	8fbe0004 	lw	s8,4(sp)
  802c9c:	27bd0008 	addiu	sp,sp,8
  802ca0:	03e00008 	jr	ra
  802ca4:	00000000 	nop

00802ca8 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  802ca8:	27bdfff8 	addiu	sp,sp,-8
  802cac:	afbe0004 	sw	s8,4(sp)
  802cb0:	03a0f021 	move	s8,sp
  802cb4:	afc40008 	sw	a0,8(s8)
  802cb8:	00a01021 	move	v0,a1
  802cbc:	a3c2000c 	sb	v0,12(s8)
    while (*s != '\0') {
  802cc0:	08200b3c 	j	802cf0 <strfind+0x48>
  802cc4:	00000000 	nop
        if (*s == c) {
  802cc8:	8fc20008 	lw	v0,8(s8)
  802ccc:	80420000 	lb	v0,0(v0)
  802cd0:	83c3000c 	lb	v1,12(s8)
  802cd4:	14620003 	bne	v1,v0,802ce4 <strfind+0x3c>
  802cd8:	00000000 	nop
            break;
  802cdc:	08200b40 	j	802d00 <strfind+0x58>
  802ce0:	00000000 	nop
        }
        s ++;
  802ce4:	8fc20008 	lw	v0,8(s8)
  802ce8:	24420001 	addiu	v0,v0,1
  802cec:	afc20008 	sw	v0,8(s8)
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
    while (*s != '\0') {
  802cf0:	8fc20008 	lw	v0,8(s8)
  802cf4:	80420000 	lb	v0,0(v0)
  802cf8:	1440fff3 	bnez	v0,802cc8 <strfind+0x20>
  802cfc:	00000000 	nop
        if (*s == c) {
            break;
        }
        s ++;
    }
    return (char *)s;
  802d00:	8fc20008 	lw	v0,8(s8)
}
  802d04:	03c0e821 	move	sp,s8
  802d08:	8fbe0004 	lw	s8,4(sp)
  802d0c:	27bd0008 	addiu	sp,sp,8
  802d10:	03e00008 	jr	ra
  802d14:	00000000 	nop

00802d18 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  802d18:	27bdffe0 	addiu	sp,sp,-32
  802d1c:	afbe001c 	sw	s8,28(sp)
  802d20:	03a0f021 	move	s8,sp
  802d24:	afc40020 	sw	a0,32(s8)
  802d28:	afc50024 	sw	a1,36(s8)
  802d2c:	afc60028 	sw	a2,40(s8)
    int neg = 0;
  802d30:	afc00008 	sw	zero,8(s8)
    long val = 0;
  802d34:	afc0000c 	sw	zero,12(s8)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  802d38:	08200b53 	j	802d4c <strtol+0x34>
  802d3c:	00000000 	nop
        s ++;
  802d40:	8fc20020 	lw	v0,32(s8)
  802d44:	24420001 	addiu	v0,v0,1
  802d48:	afc20020 	sw	v0,32(s8)
strtol(const char *s, char **endptr, int base) {
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  802d4c:	8fc20020 	lw	v0,32(s8)
  802d50:	80430000 	lb	v1,0(v0)
  802d54:	24020020 	li	v0,32
  802d58:	1062fff9 	beq	v1,v0,802d40 <strtol+0x28>
  802d5c:	00000000 	nop
  802d60:	8fc20020 	lw	v0,32(s8)
  802d64:	80430000 	lb	v1,0(v0)
  802d68:	24020009 	li	v0,9
  802d6c:	1062fff4 	beq	v1,v0,802d40 <strtol+0x28>
  802d70:	00000000 	nop
        s ++;
    }

    // plus/minus sign
    if (*s == '+') {
  802d74:	8fc20020 	lw	v0,32(s8)
  802d78:	80430000 	lb	v1,0(v0)
  802d7c:	2402002b 	li	v0,43
  802d80:	14620006 	bne	v1,v0,802d9c <strtol+0x84>
  802d84:	00000000 	nop
        s ++;
  802d88:	8fc20020 	lw	v0,32(s8)
  802d8c:	24420001 	addiu	v0,v0,1
  802d90:	afc20020 	sw	v0,32(s8)
  802d94:	08200b71 	j	802dc4 <strtol+0xac>
  802d98:	00000000 	nop
    }
    else if (*s == '-') {
  802d9c:	8fc20020 	lw	v0,32(s8)
  802da0:	80430000 	lb	v1,0(v0)
  802da4:	2402002d 	li	v0,45
  802da8:	14620006 	bne	v1,v0,802dc4 <strtol+0xac>
  802dac:	00000000 	nop
        s ++, neg = 1;
  802db0:	8fc20020 	lw	v0,32(s8)
  802db4:	24420001 	addiu	v0,v0,1
  802db8:	afc20020 	sw	v0,32(s8)
  802dbc:	24020001 	li	v0,1
  802dc0:	afc20008 	sw	v0,8(s8)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  802dc4:	8fc20028 	lw	v0,40(s8)
  802dc8:	10400005 	beqz	v0,802de0 <strtol+0xc8>
  802dcc:	00000000 	nop
  802dd0:	8fc30028 	lw	v1,40(s8)
  802dd4:	24020010 	li	v0,16
  802dd8:	14620013 	bne	v1,v0,802e28 <strtol+0x110>
  802ddc:	00000000 	nop
  802de0:	8fc20020 	lw	v0,32(s8)
  802de4:	80430000 	lb	v1,0(v0)
  802de8:	24020030 	li	v0,48
  802dec:	1462000e 	bne	v1,v0,802e28 <strtol+0x110>
  802df0:	00000000 	nop
  802df4:	8fc20020 	lw	v0,32(s8)
  802df8:	24420001 	addiu	v0,v0,1
  802dfc:	80430000 	lb	v1,0(v0)
  802e00:	24020078 	li	v0,120
  802e04:	14620008 	bne	v1,v0,802e28 <strtol+0x110>
  802e08:	00000000 	nop
        s += 2, base = 16;
  802e0c:	8fc20020 	lw	v0,32(s8)
  802e10:	24420002 	addiu	v0,v0,2
  802e14:	afc20020 	sw	v0,32(s8)
  802e18:	24020010 	li	v0,16
  802e1c:	afc20028 	sw	v0,40(s8)
  802e20:	08200b9e 	j	802e78 <strtol+0x160>
  802e24:	00000000 	nop
    }
    else if (base == 0 && s[0] == '0') {
  802e28:	8fc20028 	lw	v0,40(s8)
  802e2c:	1440000d 	bnez	v0,802e64 <strtol+0x14c>
  802e30:	00000000 	nop
  802e34:	8fc20020 	lw	v0,32(s8)
  802e38:	80430000 	lb	v1,0(v0)
  802e3c:	24020030 	li	v0,48
  802e40:	14620008 	bne	v1,v0,802e64 <strtol+0x14c>
  802e44:	00000000 	nop
        s ++, base = 8;
  802e48:	8fc20020 	lw	v0,32(s8)
  802e4c:	24420001 	addiu	v0,v0,1
  802e50:	afc20020 	sw	v0,32(s8)
  802e54:	24020008 	li	v0,8
  802e58:	afc20028 	sw	v0,40(s8)
  802e5c:	08200b9e 	j	802e78 <strtol+0x160>
  802e60:	00000000 	nop
    }
    else if (base == 0) {
  802e64:	8fc20028 	lw	v0,40(s8)
  802e68:	14400003 	bnez	v0,802e78 <strtol+0x160>
  802e6c:	00000000 	nop
        base = 10;
  802e70:	2402000a 	li	v0,10
  802e74:	afc20028 	sw	v0,40(s8)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  802e78:	8fc20020 	lw	v0,32(s8)
  802e7c:	80420000 	lb	v0,0(v0)
  802e80:	28420030 	slti	v0,v0,48
  802e84:	1440000c 	bnez	v0,802eb8 <strtol+0x1a0>
  802e88:	00000000 	nop
  802e8c:	8fc20020 	lw	v0,32(s8)
  802e90:	80420000 	lb	v0,0(v0)
  802e94:	2842003a 	slti	v0,v0,58
  802e98:	10400007 	beqz	v0,802eb8 <strtol+0x1a0>
  802e9c:	00000000 	nop
            dig = *s - '0';
  802ea0:	8fc20020 	lw	v0,32(s8)
  802ea4:	80420000 	lb	v0,0(v0)
  802ea8:	2442ffd0 	addiu	v0,v0,-48
  802eac:	afc20010 	sw	v0,16(s8)
  802eb0:	08200bcc 	j	802f30 <strtol+0x218>
  802eb4:	00000000 	nop
        }
        else if (*s >= 'a' && *s <= 'z') {
  802eb8:	8fc20020 	lw	v0,32(s8)
  802ebc:	80420000 	lb	v0,0(v0)
  802ec0:	28420061 	slti	v0,v0,97
  802ec4:	1440000c 	bnez	v0,802ef8 <strtol+0x1e0>
  802ec8:	00000000 	nop
  802ecc:	8fc20020 	lw	v0,32(s8)
  802ed0:	80420000 	lb	v0,0(v0)
  802ed4:	2842007b 	slti	v0,v0,123
  802ed8:	10400007 	beqz	v0,802ef8 <strtol+0x1e0>
  802edc:	00000000 	nop
            dig = *s - 'a' + 10;
  802ee0:	8fc20020 	lw	v0,32(s8)
  802ee4:	80420000 	lb	v0,0(v0)
  802ee8:	2442ffa9 	addiu	v0,v0,-87
  802eec:	afc20010 	sw	v0,16(s8)
  802ef0:	08200bcc 	j	802f30 <strtol+0x218>
  802ef4:	00000000 	nop
        }
        else if (*s >= 'A' && *s <= 'Z') {
  802ef8:	8fc20020 	lw	v0,32(s8)
  802efc:	80420000 	lb	v0,0(v0)
  802f00:	28420041 	slti	v0,v0,65
  802f04:	1440001d 	bnez	v0,802f7c <strtol+0x264>
  802f08:	00000000 	nop
  802f0c:	8fc20020 	lw	v0,32(s8)
  802f10:	80420000 	lb	v0,0(v0)
  802f14:	2842005b 	slti	v0,v0,91
  802f18:	10400018 	beqz	v0,802f7c <strtol+0x264>
  802f1c:	00000000 	nop
            dig = *s - 'A' + 10;
  802f20:	8fc20020 	lw	v0,32(s8)
  802f24:	80420000 	lb	v0,0(v0)
  802f28:	2442ffc9 	addiu	v0,v0,-55
  802f2c:	afc20010 	sw	v0,16(s8)
        }
        else {
            break;
        }
        if (dig >= base) {
  802f30:	8fc30010 	lw	v1,16(s8)
  802f34:	8fc20028 	lw	v0,40(s8)
  802f38:	0062102a 	slt	v0,v1,v0
  802f3c:	14400003 	bnez	v0,802f4c <strtol+0x234>
  802f40:	00000000 	nop
            break;
  802f44:	08200bdf 	j	802f7c <strtol+0x264>
  802f48:	00000000 	nop
        }
        s ++, val = (val * base) + dig;
  802f4c:	8fc20020 	lw	v0,32(s8)
  802f50:	24420001 	addiu	v0,v0,1
  802f54:	afc20020 	sw	v0,32(s8)
  802f58:	8fc3000c 	lw	v1,12(s8)
  802f5c:	8fc20028 	lw	v0,40(s8)
  802f60:	00620018 	mult	v1,v0
  802f64:	8fc20010 	lw	v0,16(s8)
  802f68:	00001812 	mflo	v1
  802f6c:	00621021 	addu	v0,v1,v0
  802f70:	afc2000c 	sw	v0,12(s8)
        // we don't properly detect overflow!
    }
  802f74:	08200b9e 	j	802e78 <strtol+0x160>
  802f78:	00000000 	nop

    if (endptr) {
  802f7c:	8fc20024 	lw	v0,36(s8)
  802f80:	10400004 	beqz	v0,802f94 <strtol+0x27c>
  802f84:	00000000 	nop
        *endptr = (char *) s;
  802f88:	8fc20024 	lw	v0,36(s8)
  802f8c:	8fc30020 	lw	v1,32(s8)
  802f90:	ac430000 	sw	v1,0(v0)
    }
    return (neg ? -val : val);
  802f94:	8fc20008 	lw	v0,8(s8)
  802f98:	10400005 	beqz	v0,802fb0 <strtol+0x298>
  802f9c:	00000000 	nop
  802fa0:	8fc2000c 	lw	v0,12(s8)
  802fa4:	00021023 	negu	v0,v0
  802fa8:	08200bed 	j	802fb4 <strtol+0x29c>
  802fac:	00000000 	nop
  802fb0:	8fc2000c 	lw	v0,12(s8)
}
  802fb4:	03c0e821 	move	sp,s8
  802fb8:	8fbe001c 	lw	s8,28(sp)
  802fbc:	27bd0020 	addiu	sp,sp,32
  802fc0:	03e00008 	jr	ra
  802fc4:	00000000 	nop

00802fc8 <memset>:
 * @n:      number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  802fc8:	27bdffe8 	addiu	sp,sp,-24
  802fcc:	afbe0014 	sw	s8,20(sp)
  802fd0:	03a0f021 	move	s8,sp
  802fd4:	afc40018 	sw	a0,24(s8)
  802fd8:	00a01021 	move	v0,a1
  802fdc:	afc60020 	sw	a2,32(s8)
  802fe0:	a3c2001c 	sb	v0,28(s8)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
  802fe4:	8fc20018 	lw	v0,24(s8)
  802fe8:	afc20008 	sw	v0,8(s8)
    while (n -- > 0) {
  802fec:	08200c02 	j	803008 <memset+0x40>
  802ff0:	00000000 	nop
        *p ++ = c;
  802ff4:	8fc20008 	lw	v0,8(s8)
  802ff8:	24430001 	addiu	v1,v0,1
  802ffc:	afc30008 	sw	v1,8(s8)
  803000:	93c3001c 	lbu	v1,28(s8)
  803004:	a0430000 	sb	v1,0(v0)
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
  803008:	8fc20020 	lw	v0,32(s8)
  80300c:	2443ffff 	addiu	v1,v0,-1
  803010:	afc30020 	sw	v1,32(s8)
  803014:	1440fff7 	bnez	v0,802ff4 <memset+0x2c>
  803018:	00000000 	nop
        *p ++ = c;
    }
    return s;
  80301c:	8fc20018 	lw	v0,24(s8)
#endif /* __HAVE_ARCH_MEMSET */
}
  803020:	03c0e821 	move	sp,s8
  803024:	8fbe0014 	lw	s8,20(sp)
  803028:	27bd0018 	addiu	sp,sp,24
  80302c:	03e00008 	jr	ra
  803030:	00000000 	nop

00803034 <memmove>:
 * @n:      number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  803034:	27bdffe8 	addiu	sp,sp,-24
  803038:	afbe0014 	sw	s8,20(sp)
  80303c:	03a0f021 	move	s8,sp
  803040:	afc40018 	sw	a0,24(s8)
  803044:	afc5001c 	sw	a1,28(s8)
  803048:	afc60020 	sw	a2,32(s8)
#ifdef __HAVE_ARCH_MEMMOVE
    return __memmove(dst, src, n);
#else
    const char *s = src;
  80304c:	8fc2001c 	lw	v0,28(s8)
  803050:	afc20008 	sw	v0,8(s8)
    char *d = dst;
  803054:	8fc20018 	lw	v0,24(s8)
  803058:	afc2000c 	sw	v0,12(s8)
    if (s < d && s + n > d) {
  80305c:	8fc30008 	lw	v1,8(s8)
  803060:	8fc2000c 	lw	v0,12(s8)
  803064:	0062102b 	sltu	v0,v1,v0
  803068:	10400023 	beqz	v0,8030f8 <memmove+0xc4>
  80306c:	00000000 	nop
  803070:	8fc30008 	lw	v1,8(s8)
  803074:	8fc20020 	lw	v0,32(s8)
  803078:	00621821 	addu	v1,v1,v0
  80307c:	8fc2000c 	lw	v0,12(s8)
  803080:	0043102b 	sltu	v0,v0,v1
  803084:	1040001c 	beqz	v0,8030f8 <memmove+0xc4>
  803088:	00000000 	nop
        s += n, d += n;
  80308c:	8fc30008 	lw	v1,8(s8)
  803090:	8fc20020 	lw	v0,32(s8)
  803094:	00621021 	addu	v0,v1,v0
  803098:	afc20008 	sw	v0,8(s8)
  80309c:	8fc3000c 	lw	v1,12(s8)
  8030a0:	8fc20020 	lw	v0,32(s8)
  8030a4:	00621021 	addu	v0,v1,v0
  8030a8:	afc2000c 	sw	v0,12(s8)
        while (n -- > 0) {
  8030ac:	08200c37 	j	8030dc <memmove+0xa8>
  8030b0:	00000000 	nop
            *-- d = *-- s;
  8030b4:	8fc2000c 	lw	v0,12(s8)
  8030b8:	2442ffff 	addiu	v0,v0,-1
  8030bc:	afc2000c 	sw	v0,12(s8)
  8030c0:	8fc20008 	lw	v0,8(s8)
  8030c4:	2442ffff 	addiu	v0,v0,-1
  8030c8:	afc20008 	sw	v0,8(s8)
  8030cc:	8fc20008 	lw	v0,8(s8)
  8030d0:	80430000 	lb	v1,0(v0)
  8030d4:	8fc2000c 	lw	v0,12(s8)
  8030d8:	a0430000 	sb	v1,0(v0)
#else
    const char *s = src;
    char *d = dst;
    if (s < d && s + n > d) {
        s += n, d += n;
        while (n -- > 0) {
  8030dc:	8fc20020 	lw	v0,32(s8)
  8030e0:	2443ffff 	addiu	v1,v0,-1
  8030e4:	afc30020 	sw	v1,32(s8)
  8030e8:	1440fff2 	bnez	v0,8030b4 <memmove+0x80>
  8030ec:	00000000 	nop
#ifdef __HAVE_ARCH_MEMMOVE
    return __memmove(dst, src, n);
#else
    const char *s = src;
    char *d = dst;
    if (s < d && s + n > d) {
  8030f0:	08200c4d 	j	803134 <memmove+0x100>
  8030f4:	00000000 	nop
        s += n, d += n;
        while (n -- > 0) {
            *-- d = *-- s;
        }
    } else {
        while (n -- > 0) {
  8030f8:	08200c48 	j	803120 <memmove+0xec>
  8030fc:	00000000 	nop
            *d ++ = *s ++;
  803100:	8fc2000c 	lw	v0,12(s8)
  803104:	24430001 	addiu	v1,v0,1
  803108:	afc3000c 	sw	v1,12(s8)
  80310c:	8fc30008 	lw	v1,8(s8)
  803110:	24640001 	addiu	a0,v1,1
  803114:	afc40008 	sw	a0,8(s8)
  803118:	80630000 	lb	v1,0(v1)
  80311c:	a0430000 	sb	v1,0(v0)
        s += n, d += n;
        while (n -- > 0) {
            *-- d = *-- s;
        }
    } else {
        while (n -- > 0) {
  803120:	8fc20020 	lw	v0,32(s8)
  803124:	2443ffff 	addiu	v1,v0,-1
  803128:	afc30020 	sw	v1,32(s8)
  80312c:	1440fff4 	bnez	v0,803100 <memmove+0xcc>
  803130:	00000000 	nop
            *d ++ = *s ++;
        }
    }
    return dst;
  803134:	8fc20018 	lw	v0,24(s8)
#endif /* __HAVE_ARCH_MEMMOVE */
}
  803138:	03c0e821 	move	sp,s8
  80313c:	8fbe0014 	lw	s8,20(sp)
  803140:	27bd0018 	addiu	sp,sp,24
  803144:	03e00008 	jr	ra
  803148:	00000000 	nop

0080314c <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  80314c:	27bdffe8 	addiu	sp,sp,-24
  803150:	afbe0014 	sw	s8,20(sp)
  803154:	03a0f021 	move	s8,sp
  803158:	afc40018 	sw	a0,24(s8)
  80315c:	afc5001c 	sw	a1,28(s8)
  803160:	afc60020 	sw	a2,32(s8)
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
#else
    const char *s = src;
  803164:	8fc2001c 	lw	v0,28(s8)
  803168:	afc20008 	sw	v0,8(s8)
    char *d = dst;
  80316c:	8fc20018 	lw	v0,24(s8)
  803170:	afc2000c 	sw	v0,12(s8)
    while (n -- > 0) {
  803174:	08200c67 	j	80319c <memcpy+0x50>
  803178:	00000000 	nop
        *d ++ = *s ++;
  80317c:	8fc2000c 	lw	v0,12(s8)
  803180:	24430001 	addiu	v1,v0,1
  803184:	afc3000c 	sw	v1,12(s8)
  803188:	8fc30008 	lw	v1,8(s8)
  80318c:	24640001 	addiu	a0,v1,1
  803190:	afc40008 	sw	a0,8(s8)
  803194:	80630000 	lb	v1,0(v1)
  803198:	a0430000 	sb	v1,0(v0)
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
#else
    const char *s = src;
    char *d = dst;
    while (n -- > 0) {
  80319c:	8fc20020 	lw	v0,32(s8)
  8031a0:	2443ffff 	addiu	v1,v0,-1
  8031a4:	afc30020 	sw	v1,32(s8)
  8031a8:	1440fff4 	bnez	v0,80317c <memcpy+0x30>
  8031ac:	00000000 	nop
        *d ++ = *s ++;
    }
    return dst;
  8031b0:	8fc20018 	lw	v0,24(s8)
#endif /* __HAVE_ARCH_MEMCPY */
}
  8031b4:	03c0e821 	move	sp,s8
  8031b8:	8fbe0014 	lw	s8,20(sp)
  8031bc:	27bd0018 	addiu	sp,sp,24
  8031c0:	03e00008 	jr	ra
  8031c4:	00000000 	nop

008031c8 <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  8031c8:	27bdffe8 	addiu	sp,sp,-24
  8031cc:	afbe0014 	sw	s8,20(sp)
  8031d0:	03a0f021 	move	s8,sp
  8031d4:	afc40018 	sw	a0,24(s8)
  8031d8:	afc5001c 	sw	a1,28(s8)
  8031dc:	afc60020 	sw	a2,32(s8)
    const char *s1 = (const char *)v1;
  8031e0:	8fc20018 	lw	v0,24(s8)
  8031e4:	afc20008 	sw	v0,8(s8)
    const char *s2 = (const char *)v2;
  8031e8:	8fc2001c 	lw	v0,28(s8)
  8031ec:	afc2000c 	sw	v0,12(s8)
    while (n -- > 0) {
  8031f0:	08200c94 	j	803250 <memcmp+0x88>
  8031f4:	00000000 	nop
        if (*s1 != *s2) {
  8031f8:	8fc20008 	lw	v0,8(s8)
  8031fc:	80430000 	lb	v1,0(v0)
  803200:	8fc2000c 	lw	v0,12(s8)
  803204:	80420000 	lb	v0,0(v0)
  803208:	1062000b 	beq	v1,v0,803238 <memcmp+0x70>
  80320c:	00000000 	nop
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  803210:	8fc20008 	lw	v0,8(s8)
  803214:	80420000 	lb	v0,0(v0)
  803218:	304200ff 	andi	v0,v0,0xff
  80321c:	00401821 	move	v1,v0
  803220:	8fc2000c 	lw	v0,12(s8)
  803224:	80420000 	lb	v0,0(v0)
  803228:	304200ff 	andi	v0,v0,0xff
  80322c:	00621023 	subu	v0,v1,v0
  803230:	08200c9a 	j	803268 <memcmp+0xa0>
  803234:	00000000 	nop
        }
        s1 ++, s2 ++;
  803238:	8fc20008 	lw	v0,8(s8)
  80323c:	24420001 	addiu	v0,v0,1
  803240:	afc20008 	sw	v0,8(s8)
  803244:	8fc2000c 	lw	v0,12(s8)
  803248:	24420001 	addiu	v0,v0,1
  80324c:	afc2000c 	sw	v0,12(s8)
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
    const char *s1 = (const char *)v1;
    const char *s2 = (const char *)v2;
    while (n -- > 0) {
  803250:	8fc20020 	lw	v0,32(s8)
  803254:	2443ffff 	addiu	v1,v0,-1
  803258:	afc30020 	sw	v1,32(s8)
  80325c:	1440ffe6 	bnez	v0,8031f8 <memcmp+0x30>
  803260:	00000000 	nop
        if (*s1 != *s2) {
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
        }
        s1 ++, s2 ++;
    }
    return 0;
  803264:	00001021 	move	v0,zero
}
  803268:	03c0e821 	move	sp,s8
  80326c:	8fbe0014 	lw	s8,20(sp)
  803270:	27bd0018 	addiu	sp,sp,24
  803274:	03e00008 	jr	ra
  803278:	00000000 	nop
  80327c:	00000000 	nop

00803280 <getmode>:

#define printf(...)                     fprintf(1, __VA_ARGS__)
#define BUFSIZE                         4096

static char
getmode(uint32_t st_mode) {
  803280:	27bdffe8 	addiu	sp,sp,-24
  803284:	afbe0014 	sw	s8,20(sp)
  803288:	03a0f021 	move	s8,sp
  80328c:	afc40018 	sw	a0,24(s8)
    char mode = '?';
  803290:	2402003f 	li	v0,63
  803294:	a3c20008 	sb	v0,8(s8)
    if (S_ISREG(st_mode)) mode = '-';
  803298:	8fc20018 	lw	v0,24(s8)
  80329c:	30437000 	andi	v1,v0,0x7000
  8032a0:	24021000 	li	v0,4096
  8032a4:	14620003 	bne	v1,v0,8032b4 <getmode+0x34>
  8032a8:	00000000 	nop
  8032ac:	2402002d 	li	v0,45
  8032b0:	a3c20008 	sb	v0,8(s8)
    if (S_ISDIR(st_mode)) mode = 'd';
  8032b4:	8fc20018 	lw	v0,24(s8)
  8032b8:	30437000 	andi	v1,v0,0x7000
  8032bc:	24022000 	li	v0,8192
  8032c0:	14620003 	bne	v1,v0,8032d0 <getmode+0x50>
  8032c4:	00000000 	nop
  8032c8:	24020064 	li	v0,100
  8032cc:	a3c20008 	sb	v0,8(s8)
    if (S_ISLNK(st_mode)) mode = 'l';
  8032d0:	8fc20018 	lw	v0,24(s8)
  8032d4:	30437000 	andi	v1,v0,0x7000
  8032d8:	24023000 	li	v0,12288
  8032dc:	14620003 	bne	v1,v0,8032ec <getmode+0x6c>
  8032e0:	00000000 	nop
  8032e4:	2402006c 	li	v0,108
  8032e8:	a3c20008 	sb	v0,8(s8)
    if (S_ISCHR(st_mode)) mode = 'c';
  8032ec:	8fc20018 	lw	v0,24(s8)
  8032f0:	30437000 	andi	v1,v0,0x7000
  8032f4:	24024000 	li	v0,16384
  8032f8:	14620003 	bne	v1,v0,803308 <getmode+0x88>
  8032fc:	00000000 	nop
  803300:	24020063 	li	v0,99
  803304:	a3c20008 	sb	v0,8(s8)
    if (S_ISBLK(st_mode)) mode = 'b';
  803308:	8fc20018 	lw	v0,24(s8)
  80330c:	30437000 	andi	v1,v0,0x7000
  803310:	24025000 	li	v0,20480
  803314:	14620003 	bne	v1,v0,803324 <getmode+0xa4>
  803318:	00000000 	nop
  80331c:	24020062 	li	v0,98
  803320:	a3c20008 	sb	v0,8(s8)
    return mode;
  803324:	83c20008 	lb	v0,8(s8)
}
  803328:	03c0e821 	move	sp,s8
  80332c:	8fbe0014 	lw	s8,20(sp)
  803330:	27bd0018 	addiu	sp,sp,24
  803334:	03e00008 	jr	ra
  803338:	00000000 	nop

0080333c <getstat>:

static int
getstat(const char *name, struct stat *stat) {
  80333c:	27bdffd8 	addiu	sp,sp,-40
  803340:	afbf0024 	sw	ra,36(sp)
  803344:	afbe0020 	sw	s8,32(sp)
  803348:	03a0f021 	move	s8,sp
  80334c:	afc40028 	sw	a0,40(s8)
  803350:	afc5002c 	sw	a1,44(s8)
    int fd, ret;
    if ((fd = open(name, O_RDONLY)) < 0) {
  803354:	8fc40028 	lw	a0,40(s8)
  803358:	00002821 	move	a1,zero
  80335c:	0c20007c 	jal	8001f0 <open>
  803360:	00000000 	nop
  803364:	afc20018 	sw	v0,24(s8)
  803368:	8fc20018 	lw	v0,24(s8)
  80336c:	04410004 	bgez	v0,803380 <getstat+0x44>
  803370:	00000000 	nop
        return fd;
  803374:	8fc20018 	lw	v0,24(s8)
  803378:	08200ce9 	j	8033a4 <getstat+0x68>
  80337c:	00000000 	nop
    }
    ret = fstat(fd, stat);
  803380:	8fc40018 	lw	a0,24(s8)
  803384:	8fc5002c 	lw	a1,44(s8)
  803388:	0c2000d0 	jal	800340 <fstat>
  80338c:	00000000 	nop
  803390:	afc2001c 	sw	v0,28(s8)
    close(fd);
  803394:	8fc40018 	lw	a0,24(s8)
  803398:	0c20008c 	jal	800230 <close>
  80339c:	00000000 	nop
    return ret;
  8033a0:	8fc2001c 	lw	v0,28(s8)
}
  8033a4:	03c0e821 	move	sp,s8
  8033a8:	8fbf0024 	lw	ra,36(sp)
  8033ac:	8fbe0020 	lw	s8,32(sp)
  8033b0:	27bd0028 	addiu	sp,sp,40
  8033b4:	03e00008 	jr	ra
  8033b8:	00000000 	nop

008033bc <lsstat>:

void
lsstat(struct stat *stat, const char *filename) {
  8033bc:	27bdffe0 	addiu	sp,sp,-32
  8033c0:	afbf001c 	sw	ra,28(sp)
  8033c4:	afbe0018 	sw	s8,24(sp)
  8033c8:	03a0f021 	move	s8,sp
  8033cc:	afc40020 	sw	a0,32(s8)
  8033d0:	afc50024 	sw	a1,36(s8)
    printf("   [%c]", getmode(stat->st_mode));
  8033d4:	8fc20020 	lw	v0,32(s8)
  8033d8:	8c420000 	lw	v0,0(v0)
  8033dc:	00402021 	move	a0,v0
  8033e0:	0c200ca0 	jal	803280 <getmode>
  8033e4:	00000000 	nop
  8033e8:	24040001 	li	a0,1
  8033ec:	3c030080 	lui	v1,0x80
  8033f0:	24653d40 	addiu	a1,v1,15680
  8033f4:	00403021 	move	a2,v0
  8033f8:	0c200327 	jal	800c9c <fprintf>
  8033fc:	00000000 	nop
    printf(" %3d(h)", stat->st_nlinks);
  803400:	8fc20020 	lw	v0,32(s8)
  803404:	8c420004 	lw	v0,4(v0)
  803408:	24040001 	li	a0,1
  80340c:	3c030080 	lui	v1,0x80
  803410:	24653d48 	addiu	a1,v1,15688
  803414:	00403021 	move	a2,v0
  803418:	0c200327 	jal	800c9c <fprintf>
  80341c:	00000000 	nop
    printf(" %8d(b)", stat->st_blocks);
  803420:	8fc20020 	lw	v0,32(s8)
  803424:	8c420008 	lw	v0,8(v0)
  803428:	24040001 	li	a0,1
  80342c:	3c030080 	lui	v1,0x80
  803430:	24653d50 	addiu	a1,v1,15696
  803434:	00403021 	move	a2,v0
  803438:	0c200327 	jal	800c9c <fprintf>
  80343c:	00000000 	nop
    printf(" %8d(s)", stat->st_size);
  803440:	8fc20020 	lw	v0,32(s8)
  803444:	8c42000c 	lw	v0,12(v0)
  803448:	24040001 	li	a0,1
  80344c:	3c030080 	lui	v1,0x80
  803450:	24653d58 	addiu	a1,v1,15704
  803454:	00403021 	move	a2,v0
  803458:	0c200327 	jal	800c9c <fprintf>
  80345c:	00000000 	nop
    printf("   %s\n", filename);
  803460:	24040001 	li	a0,1
  803464:	3c020080 	lui	v0,0x80
  803468:	24453d60 	addiu	a1,v0,15712
  80346c:	8fc60024 	lw	a2,36(s8)
  803470:	0c200327 	jal	800c9c <fprintf>
  803474:	00000000 	nop
}
  803478:	03c0e821 	move	sp,s8
  80347c:	8fbf001c 	lw	ra,28(sp)
  803480:	8fbe0018 	lw	s8,24(sp)
  803484:	27bd0020 	addiu	sp,sp,32
  803488:	03e00008 	jr	ra
  80348c:	00000000 	nop

00803490 <lsdir>:

int
lsdir(const char *path) {
  803490:	27bdffc0 	addiu	sp,sp,-64
  803494:	afbf003c 	sw	ra,60(sp)
  803498:	afbe0038 	sw	s8,56(sp)
  80349c:	03a0f021 	move	s8,sp
  8034a0:	afc40040 	sw	a0,64(s8)
    struct stat __stat, *stat = &__stat;
  8034a4:	27c20028 	addiu	v0,s8,40
  8034a8:	afc20018 	sw	v0,24(s8)
    int ret;
    DIR *dirp = opendir(".");
  8034ac:	3c020080 	lui	v0,0x80
  8034b0:	24443d68 	addiu	a0,v0,15720
  8034b4:	0c200008 	jal	800020 <opendir>
  8034b8:	00000000 	nop
  8034bc:	afc2001c 	sw	v0,28(s8)
    
    if (dirp == NULL) {
  8034c0:	8fc2001c 	lw	v0,28(s8)
  8034c4:	14400004 	bnez	v0,8034d8 <lsdir+0x48>
  8034c8:	00000000 	nop
        return -1;
  8034cc:	2402ffff 	li	v0,-1
  8034d0:	08200d5f 	j	80357c <lsdir+0xec>
  8034d4:	00000000 	nop
    }
    struct dirent *direntp;
    while ((direntp = readdir(dirp)) != NULL) {
  8034d8:	08200d4f 	j	80353c <lsdir+0xac>
  8034dc:	00000000 	nop
        if ((ret = getstat(direntp->name, stat)) != 0) {
  8034e0:	8fc20020 	lw	v0,32(s8)
  8034e4:	24420004 	addiu	v0,v0,4
  8034e8:	00402021 	move	a0,v0
  8034ec:	8fc50018 	lw	a1,24(s8)
  8034f0:	0c200ccf 	jal	80333c <getstat>
  8034f4:	00000000 	nop
  8034f8:	afc20024 	sw	v0,36(s8)
  8034fc:	8fc20024 	lw	v0,36(s8)
  803500:	10400008 	beqz	v0,803524 <lsdir+0x94>
  803504:	00000000 	nop
            goto failed;
  803508:	00000000 	nop
    }
    printf("lsdir: step 4\n");
    closedir(dirp);
    return 0;
failed:
    closedir(dirp);
  80350c:	8fc4001c 	lw	a0,28(s8)
  803510:	0c200054 	jal	800150 <closedir>
  803514:	00000000 	nop
    return ret;
  803518:	8fc20024 	lw	v0,36(s8)
  80351c:	08200d5f 	j	80357c <lsdir+0xec>
  803520:	00000000 	nop
    struct dirent *direntp;
    while ((direntp = readdir(dirp)) != NULL) {
        if ((ret = getstat(direntp->name, stat)) != 0) {
            goto failed;
        }
        lsstat(stat, direntp->name);
  803524:	8fc20020 	lw	v0,32(s8)
  803528:	24420004 	addiu	v0,v0,4
  80352c:	8fc40018 	lw	a0,24(s8)
  803530:	00402821 	move	a1,v0
  803534:	0c200cef 	jal	8033bc <lsstat>
  803538:	00000000 	nop
    
    if (dirp == NULL) {
        return -1;
    }
    struct dirent *direntp;
    while ((direntp = readdir(dirp)) != NULL) {
  80353c:	8fc4001c 	lw	a0,28(s8)
  803540:	0c20003a 	jal	8000e8 <readdir>
  803544:	00000000 	nop
  803548:	afc20020 	sw	v0,32(s8)
  80354c:	8fc20020 	lw	v0,32(s8)
  803550:	1440ffe3 	bnez	v0,8034e0 <lsdir+0x50>
  803554:	00000000 	nop
        if ((ret = getstat(direntp->name, stat)) != 0) {
            goto failed;
        }
        lsstat(stat, direntp->name);
    }
    printf("lsdir: step 4\n");
  803558:	24040001 	li	a0,1
  80355c:	3c020080 	lui	v0,0x80
  803560:	24453d6c 	addiu	a1,v0,15724
  803564:	0c200327 	jal	800c9c <fprintf>
  803568:	00000000 	nop
    closedir(dirp);
  80356c:	8fc4001c 	lw	a0,28(s8)
  803570:	0c200054 	jal	800150 <closedir>
  803574:	00000000 	nop
    return 0;
  803578:	00001021 	move	v0,zero
failed:
    closedir(dirp);
    return ret;
}
  80357c:	03c0e821 	move	sp,s8
  803580:	8fbf003c 	lw	ra,60(sp)
  803584:	8fbe0038 	lw	s8,56(sp)
  803588:	27bd0040 	addiu	sp,sp,64
  80358c:	03e00008 	jr	ra
  803590:	00000000 	nop

00803594 <ls>:

int
ls(const char *path) {
  803594:	27bdffc0 	addiu	sp,sp,-64
  803598:	afbf003c 	sw	ra,60(sp)
  80359c:	afbe0038 	sw	s8,56(sp)
  8035a0:	03a0f021 	move	s8,sp
  8035a4:	afc40040 	sw	a0,64(s8)
    struct stat __stat, *stat = &__stat;
  8035a8:	27c20024 	addiu	v0,s8,36
  8035ac:	afc2001c 	sw	v0,28(s8)
    int ret, type;
    if ((ret = getstat(path, stat)) != 0) {
  8035b0:	8fc40040 	lw	a0,64(s8)
  8035b4:	8fc5001c 	lw	a1,28(s8)
  8035b8:	0c200ccf 	jal	80333c <getstat>
  8035bc:	00000000 	nop
  8035c0:	afc20020 	sw	v0,32(s8)
  8035c4:	8fc20020 	lw	v0,32(s8)
  8035c8:	10400004 	beqz	v0,8035dc <ls+0x48>
  8035cc:	00000000 	nop
        return ret;
  8035d0:	8fc20020 	lw	v0,32(s8)
  8035d4:	08200dd9 	j	803764 <ls+0x1d0>
  8035d8:	00000000 	nop
        " [ symlink ]",
        " [character]",
        " [  block  ]",
        " [  ?????  ]",
    };
    switch (getmode(stat->st_mode)) {
  8035dc:	8fc2001c 	lw	v0,28(s8)
  8035e0:	8c420000 	lw	v0,0(v0)
  8035e4:	00402021 	move	a0,v0
  8035e8:	0c200ca0 	jal	803280 <getmode>
  8035ec:	00000000 	nop
  8035f0:	24030063 	li	v1,99
  8035f4:	1043001f 	beq	v0,v1,803674 <ls+0xe0>
  8035f8:	00000000 	nop
  8035fc:	28430064 	slti	v1,v0,100
  803600:	10600009 	beqz	v1,803628 <ls+0x94>
  803604:	00000000 	nop
  803608:	2403002d 	li	v1,45
  80360c:	1043000e 	beq	v0,v1,803648 <ls+0xb4>
  803610:	00000000 	nop
  803614:	24030062 	li	v1,98
  803618:	1043001a 	beq	v0,v1,803684 <ls+0xf0>
  80361c:	00000000 	nop
  803620:	08200da5 	j	803694 <ls+0x100>
  803624:	00000000 	nop
  803628:	24030064 	li	v1,100
  80362c:	10430009 	beq	v0,v1,803654 <ls+0xc0>
  803630:	00000000 	nop
  803634:	2403006c 	li	v1,108
  803638:	1043000a 	beq	v0,v1,803664 <ls+0xd0>
  80363c:	00000000 	nop
  803640:	08200da5 	j	803694 <ls+0x100>
  803644:	00000000 	nop
    case '-': type = 0; break;
  803648:	afc00018 	sw	zero,24(s8)
  80364c:	08200da8 	j	8036a0 <ls+0x10c>
  803650:	00000000 	nop
    case 'd': type = 1; break;
  803654:	24020001 	li	v0,1
  803658:	afc20018 	sw	v0,24(s8)
  80365c:	08200da8 	j	8036a0 <ls+0x10c>
  803660:	00000000 	nop
    case 'l': type = 2; break;
  803664:	24020002 	li	v0,2
  803668:	afc20018 	sw	v0,24(s8)
  80366c:	08200da8 	j	8036a0 <ls+0x10c>
  803670:	00000000 	nop
    case 'c': type = 3; break;
  803674:	24020003 	li	v0,3
  803678:	afc20018 	sw	v0,24(s8)
  80367c:	08200da8 	j	8036a0 <ls+0x10c>
  803680:	00000000 	nop
    case 'b': type = 4; break;
  803684:	24020004 	li	v0,4
  803688:	afc20018 	sw	v0,24(s8)
  80368c:	08200da8 	j	8036a0 <ls+0x10c>
  803690:	00000000 	nop
    default:  type = 5; break;
  803694:	24020005 	li	v0,5
  803698:	afc20018 	sw	v0,24(s8)
  80369c:	00000000 	nop
    }

    printf(" @ is %s", filetype[type]);
  8036a0:	3c020080 	lui	v0,0x80
  8036a4:	8fc30018 	lw	v1,24(s8)
  8036a8:	00031880 	sll	v1,v1,0x2
  8036ac:	24424030 	addiu	v0,v0,16432
  8036b0:	00621021 	addu	v0,v1,v0
  8036b4:	8c420000 	lw	v0,0(v0)
  8036b8:	24040001 	li	a0,1
  8036bc:	3c030080 	lui	v1,0x80
  8036c0:	24653d7c 	addiu	a1,v1,15740
  8036c4:	00403021 	move	a2,v0
  8036c8:	0c200327 	jal	800c9c <fprintf>
  8036cc:	00000000 	nop
    printf(" %d(hlinks)", stat->st_nlinks);
  8036d0:	8fc2001c 	lw	v0,28(s8)
  8036d4:	8c420004 	lw	v0,4(v0)
  8036d8:	24040001 	li	a0,1
  8036dc:	3c030080 	lui	v1,0x80
  8036e0:	24653d88 	addiu	a1,v1,15752
  8036e4:	00403021 	move	a2,v0
  8036e8:	0c200327 	jal	800c9c <fprintf>
  8036ec:	00000000 	nop
    printf(" %d(blocks)", stat->st_blocks);
  8036f0:	8fc2001c 	lw	v0,28(s8)
  8036f4:	8c420008 	lw	v0,8(v0)
  8036f8:	24040001 	li	a0,1
  8036fc:	3c030080 	lui	v1,0x80
  803700:	24653d94 	addiu	a1,v1,15764
  803704:	00403021 	move	a2,v0
  803708:	0c200327 	jal	800c9c <fprintf>
  80370c:	00000000 	nop
    printf(" %d(bytes) : @'%s'\n", stat->st_size, path);
  803710:	8fc2001c 	lw	v0,28(s8)
  803714:	8c42000c 	lw	v0,12(v0)
  803718:	24040001 	li	a0,1
  80371c:	3c030080 	lui	v1,0x80
  803720:	24653da0 	addiu	a1,v1,15776
  803724:	00403021 	move	a2,v0
  803728:	8fc70040 	lw	a3,64(s8)
  80372c:	0c200327 	jal	800c9c <fprintf>
  803730:	00000000 	nop
    if (S_ISDIR(stat->st_mode)) {
  803734:	8fc2001c 	lw	v0,28(s8)
  803738:	8c420000 	lw	v0,0(v0)
  80373c:	30437000 	andi	v1,v0,0x7000
  803740:	24022000 	li	v0,8192
  803744:	14620006 	bne	v1,v0,803760 <ls+0x1cc>
  803748:	00000000 	nop
        return lsdir(path);
  80374c:	8fc40040 	lw	a0,64(s8)
  803750:	0c200d24 	jal	803490 <lsdir>
  803754:	00000000 	nop
  803758:	08200dd9 	j	803764 <ls+0x1d0>
  80375c:	00000000 	nop
    }
    return 0;
  803760:	00001021 	move	v0,zero
}
  803764:	03c0e821 	move	sp,s8
  803768:	8fbf003c 	lw	ra,60(sp)
  80376c:	8fbe0038 	lw	s8,56(sp)
  803770:	27bd0040 	addiu	sp,sp,64
  803774:	03e00008 	jr	ra
  803778:	00000000 	nop

0080377c <main>:

int
main(int argc, char **argv) {
  80377c:	27bdffd8 	addiu	sp,sp,-40
  803780:	afbf0024 	sw	ra,36(sp)
  803784:	afbe0020 	sw	s8,32(sp)
  803788:	03a0f021 	move	s8,sp
  80378c:	afc40028 	sw	a0,40(s8)
  803790:	afc5002c 	sw	a1,44(s8)
    if (argc == 1) {
  803794:	8fc30028 	lw	v1,40(s8)
  803798:	24020001 	li	v0,1
  80379c:	14620007 	bne	v1,v0,8037bc <main+0x40>
  8037a0:	00000000 	nop
        return ls(".");
  8037a4:	3c020080 	lui	v0,0x80
  8037a8:	24443d68 	addiu	a0,v0,15720
  8037ac:	0c200d65 	jal	803594 <ls>
  8037b0:	00000000 	nop
  8037b4:	08200e0b 	j	80382c <main+0xb0>
  8037b8:	00000000 	nop
    }
    else {
        int i, ret;
        for (i = 1; i < argc; i ++) {
  8037bc:	24020001 	li	v0,1
  8037c0:	afc20018 	sw	v0,24(s8)
  8037c4:	08200e05 	j	803814 <main+0x98>
  8037c8:	00000000 	nop
            if ((ret = ls(argv[i])) != 0) {
  8037cc:	8fc20018 	lw	v0,24(s8)
  8037d0:	00021080 	sll	v0,v0,0x2
  8037d4:	8fc3002c 	lw	v1,44(s8)
  8037d8:	00621021 	addu	v0,v1,v0
  8037dc:	8c420000 	lw	v0,0(v0)
  8037e0:	00402021 	move	a0,v0
  8037e4:	0c200d65 	jal	803594 <ls>
  8037e8:	00000000 	nop
  8037ec:	afc2001c 	sw	v0,28(s8)
  8037f0:	8fc2001c 	lw	v0,28(s8)
  8037f4:	10400004 	beqz	v0,803808 <main+0x8c>
  8037f8:	00000000 	nop
                return ret;
  8037fc:	8fc2001c 	lw	v0,28(s8)
  803800:	08200e0b 	j	80382c <main+0xb0>
  803804:	00000000 	nop
    if (argc == 1) {
        return ls(".");
    }
    else {
        int i, ret;
        for (i = 1; i < argc; i ++) {
  803808:	8fc20018 	lw	v0,24(s8)
  80380c:	24420001 	addiu	v0,v0,1
  803810:	afc20018 	sw	v0,24(s8)
  803814:	8fc30018 	lw	v1,24(s8)
  803818:	8fc20028 	lw	v0,40(s8)
  80381c:	0062102a 	slt	v0,v1,v0
  803820:	1440ffea 	bnez	v0,8037cc <main+0x50>
  803824:	00000000 	nop
            if ((ret = ls(argv[i])) != 0) {
                return ret;
            }
        }
    }
    return 0;
  803828:	00001021 	move	v0,zero
}
  80382c:	03c0e821 	move	sp,s8
  803830:	8fbf0024 	lw	ra,36(sp)
  803834:	8fbe0020 	lw	s8,32(sp)
  803838:	27bd0028 	addiu	sp,sp,40
  80383c:	03e00008 	jr	ra
  803840:	00000000 	nop
	...
