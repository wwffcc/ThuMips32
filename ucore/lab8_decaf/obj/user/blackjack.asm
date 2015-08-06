
obj/__user_blackjack.out:     file format elf32-tradlittlemips


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
  80003c:	8c507000 	lw	s0,28672(v0)
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
  800074:	8c427000 	lw	v0,28672(v0)
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
  8000b0:	8c427000 	lw	v0,28672(v0)
  8000b4:	ac400004 	sw	zero,4(v0)
    return dirp;
  8000b8:	3c020080 	lui	v0,0x80
  8000bc:	8c427000 	lw	v0,28672(v0)
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
  8004ec:	24446230 	addiu	a0,v0,25136
  8004f0:	8fc50024 	lw	a1,36(s8)
  8004f4:	8fc60020 	lw	a2,32(s8)
  8004f8:	0c2002bd 	jal	800af4 <cprintf>
  8004fc:	00000000 	nop
    cprintf("    mode    : %c\n", transmode(stat));
  800500:	8fc40028 	lw	a0,40(s8)
  800504:	0c2000fe 	jal	8003f8 <transmode>
  800508:	00000000 	nop
  80050c:	3c030080 	lui	v1,0x80
  800510:	2464623c 	addiu	a0,v1,25148
  800514:	00402821 	move	a1,v0
  800518:	0c2002bd 	jal	800af4 <cprintf>
  80051c:	00000000 	nop
    cprintf("    links   : %lu\n", stat->st_nlinks);
  800520:	8fc20028 	lw	v0,40(s8)
  800524:	8c420004 	lw	v0,4(v0)
  800528:	3c030080 	lui	v1,0x80
  80052c:	24646250 	addiu	a0,v1,25168
  800530:	00402821 	move	a1,v0
  800534:	0c2002bd 	jal	800af4 <cprintf>
  800538:	00000000 	nop
    cprintf("    blocks  : %lu\n", stat->st_blocks);
  80053c:	8fc20028 	lw	v0,40(s8)
  800540:	8c420008 	lw	v0,8(v0)
  800544:	3c030080 	lui	v1,0x80
  800548:	24646264 	addiu	a0,v1,25188
  80054c:	00402821 	move	a1,v0
  800550:	0c2002bd 	jal	800af4 <cprintf>
  800554:	00000000 	nop
    cprintf("    size    : %lu\n", stat->st_size);
  800558:	8fc20028 	lw	v0,40(s8)
  80055c:	8c42000c 	lw	v0,12(v0)
  800560:	3c030080 	lui	v1,0x80
  800564:	24646278 	addiu	a0,v1,25208
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
  8005c4:	8c437010 	lw	v1,28688(v0)
  8005c8:	8fc20018 	lw	v0,24(s8)
  8005cc:	00621821 	addu	v1,v1,v0
  8005d0:	3c020081 	lui	v0,0x81
  8005d4:	24428410 	addiu	v0,v0,-31728
  8005d8:	0062102b 	sltu	v0,v1,v0
  8005dc:	1440000a 	bnez	v0,800608 <_Alloc+0x58>
  8005e0:	00000000 	nop
        cur = buf;
  8005e4:	3c020080 	lui	v0,0x80
  8005e8:	3c030080 	lui	v1,0x80
  8005ec:	24637410 	addiu	v1,v1,29712
  8005f0:	ac437010 	sw	v1,28688(v0)
        p = buf;
  8005f4:	3c020080 	lui	v0,0x80
  8005f8:	24427410 	addiu	v0,v0,29712
  8005fc:	afc20008 	sw	v0,8(s8)
  800600:	0820018b 	j	80062c <_Alloc+0x7c>
  800604:	00000000 	nop
    }
    else{
        p = cur;
  800608:	3c020080 	lui	v0,0x80
  80060c:	8c427010 	lw	v0,28688(v0)
  800610:	afc20008 	sw	v0,8(s8)
        cur += n;
  800614:	3c020080 	lui	v0,0x80
  800618:	8c437010 	lw	v1,28688(v0)
  80061c:	8fc20018 	lw	v0,24(s8)
  800620:	00621821 	addu	v1,v1,v0
  800624:	3c020080 	lui	v0,0x80
  800628:	ac437010 	sw	v1,28688(v0)
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
  800658:	8c437014 	lw	v1,28692(v0)
  80065c:	8fc20018 	lw	v0,24(s8)
  800660:	00621821 	addu	v1,v1,v0
  800664:	3c020081 	lui	v0,0x81
  800668:	24429410 	addiu	v0,v0,-27632
  80066c:	0062102b 	sltu	v0,v1,v0
  800670:	1440000a 	bnez	v0,80069c <stralloc+0x58>
  800674:	00000000 	nop
        cur = bufx;
  800678:	3c020080 	lui	v0,0x80
  80067c:	3c030081 	lui	v1,0x81
  800680:	24638410 	addiu	v1,v1,-31728
  800684:	ac437014 	sw	v1,28692(v0)
        p = bufx;
  800688:	3c020081 	lui	v0,0x81
  80068c:	24428410 	addiu	v0,v0,-31728
  800690:	afc20008 	sw	v0,8(s8)
  800694:	082001b0 	j	8006c0 <stralloc+0x7c>
  800698:	00000000 	nop
    }
    else{
        p = cur;
  80069c:	3c020080 	lui	v0,0x80
  8006a0:	8c427014 	lw	v0,28692(v0)
  8006a4:	afc20008 	sw	v0,8(s8)
        cur += n;
  8006a8:	3c020080 	lui	v0,0x80
  8006ac:	8c437014 	lw	v1,28692(v0)
  8006b0:	8fc20018 	lw	v0,24(s8)
  8006b4:	00621821 	addu	v1,v1,v0
  8006b8:	3c020080 	lui	v0,0x80
  8006bc:	ac437014 	sw	v1,28692(v0)
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
  8006f0:	24446290 	addiu	a0,v0,25232
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
  800738:	24646294 	addiu	a0,v1,25236
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
  800778:	24446298 	addiu	a0,v0,25240
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
  8007c4:	2444629c 	addiu	a0,v0,25244
  8007c8:	0c2002bd 	jal	800af4 <cprintf>
  8007cc:	00000000 	nop
  8007d0:	082001fa 	j	8007e8 <_PrintBool+0x48>
  8007d4:	00000000 	nop
    else
        cprintf("false");
  8007d8:	3c020080 	lui	v0,0x80
  8007dc:	244462a4 	addiu	a0,v0,25252
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
  80097c:	244462b0 	addiu	a0,v0,25264
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
  8009a8:	244462cc 	addiu	a0,v0,25292
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
  8009ec:	244462d0 	addiu	a0,v0,25296
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
  800a18:	244462cc 	addiu	a0,v0,25292
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
  800d10:	3c020081 	lui	v0,0x81
  800d14:	24449410 	addiu	a0,v0,-27632
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
  800d3c:	244562f0 	addiu	a1,v0,25328
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
  800d9c:	3c020081 	lui	v0,0x81
  800da0:	24439410 	addiu	v1,v0,-27632
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
  800e0c:	246562f4 	addiu	a1,v1,25332
  800e10:	00403021 	move	a2,v0
  800e14:	0c200327 	jal	800c9c <fprintf>
  800e18:	00000000 	nop
            buffer[i ++] = c;
  800e1c:	8fc20018 	lw	v0,24(s8)
  800e20:	24430001 	addiu	v1,v0,1
  800e24:	afc30018 	sw	v1,24(s8)
  800e28:	83c30020 	lb	v1,32(s8)
  800e2c:	3c040081 	lui	a0,0x81
  800e30:	24849410 	addiu	a0,a0,-27632
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
  800e6c:	246562f4 	addiu	a1,v1,25332
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
  800ebc:	246562f4 	addiu	a1,v1,25332
  800ec0:	00403021 	move	a2,v0
  800ec4:	0c200327 	jal	800c9c <fprintf>
  800ec8:	00000000 	nop
            buffer[i] = '\0';
  800ecc:	3c020081 	lui	v0,0x81
  800ed0:	24439410 	addiu	v1,v0,-27632
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
  800ef0:	3c020081 	lui	v0,0x81
  800ef4:	24429410 	addiu	v0,v0,-27632
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
  8015a4:	24446300 	addiu	a0,v0,25344
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
  801940:	24456320 	addiu	a1,v0,25376
  801944:	00003021 	move	a2,zero
  801948:	0c200620 	jal	801880 <initfd>
  80194c:	00000000 	nop
  801950:	afc20018 	sw	v0,24(s8)
  801954:	8fc20018 	lw	v0,24(s8)
  801958:	04410009 	bgez	v0,801980 <umain+0x60>
  80195c:	00000000 	nop
        warn("open <stdin> failed: %e.\n", fd);
  801960:	3c020080 	lui	v0,0x80
  801964:	24446328 	addiu	a0,v0,25384
  801968:	2405001a 	li	a1,26
  80196c:	3c020080 	lui	v0,0x80
  801970:	2446633c 	addiu	a2,v0,25404
  801974:	8fc70018 	lw	a3,24(s8)
  801978:	0c200270 	jal	8009c0 <__warn>
  80197c:	00000000 	nop
    }
    if ((fd = initfd(1, "stdout:", O_WRONLY)) < 0) {
  801980:	24040001 	li	a0,1
  801984:	3c020080 	lui	v0,0x80
  801988:	24456358 	addiu	a1,v0,25432
  80198c:	24060001 	li	a2,1
  801990:	0c200620 	jal	801880 <initfd>
  801994:	00000000 	nop
  801998:	afc20018 	sw	v0,24(s8)
  80199c:	8fc20018 	lw	v0,24(s8)
  8019a0:	04410009 	bgez	v0,8019c8 <umain+0xa8>
  8019a4:	00000000 	nop
        warn("open <stdout> failed: %e.\n", fd);
  8019a8:	3c020080 	lui	v0,0x80
  8019ac:	24446328 	addiu	a0,v0,25384
  8019b0:	2405001d 	li	a1,29
  8019b4:	3c020080 	lui	v0,0x80
  8019b8:	24466360 	addiu	a2,v0,25440
  8019bc:	8fc70018 	lw	a3,24(s8)
  8019c0:	0c200270 	jal	8009c0 <__warn>
  8019c4:	00000000 	nop
    }
    int ret = main(argc, argv);
  8019c8:	8fc40028 	lw	a0,40(s8)
  8019cc:	8fc5002c 	lw	a1,44(s8)
  8019d0:	0c20180d 	jal	806034 <main>
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
  801d74:	24436590 	addiu	v1,v0,26000
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
  802088:	244265bc 	addiu	v0,v0,26044
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
  80220c:	2442652c 	addiu	v0,v0,25900
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
  802234:	244765a4 	addiu	a3,v0,26020
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
  80225c:	244765b0 	addiu	a3,v0,26032
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
  80228c:	245165b4 	addiu	s1,v0,26036
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
  802830:	8c857024 	lw	a1,28708(a0)
  802834:	8c847020 	lw	a0,28704(a0)
  802838:	00802821 	move	a1,a0
  80283c:	3c0441c6 	lui	a0,0x41c6
  802840:	34844e6d 	ori	a0,a0,0x4e6d
  802844:	00a40018 	mult	a1,a0
  802848:	00001012 	mflo	v0
  80284c:	24443039 	addiu	a0,v0,12345
  802850:	00801021 	move	v0,a0
  802854:	00001821 	move	v1,zero
  802858:	3c040080 	lui	a0,0x80
  80285c:	ac827020 	sw	v0,28704(a0)
  802860:	ac837024 	sw	v1,28708(a0)
    return ((unsigned long)next % (RAND_MAX+1));
  802864:	3c020080 	lui	v0,0x80
  802868:	8c437024 	lw	v1,28708(v0)
  80286c:	8c427020 	lw	v0,28704(v0)
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
  8028b4:	ac827020 	sw	v0,28704(a0)
  8028b8:	ac837024 	sw	v1,28708(a0)
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

00803280 <_rndModule_New>:



          .text                         
_rndModule_New:                         # function entry
          sw $fp, 0($sp)                
  803280:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  803284:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  803288:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -16           
  80328c:	27bdfff0 	addiu	sp,sp,-16

00803290 <_L167>:
_L167:                                  
          li    $t0, 8                  
  803290:	24080008 	li	t0,8
          move  $a0, $t0                
  803294:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  803298:	afa80004 	sw	t0,4(sp)
          jal   _Alloc                  
  80329c:	0c20016c 	jal	8005b0 <_Alloc>
  8032a0:	00000000 	nop
          move  $t0, $v0                
  8032a4:	00404021 	move	t0,v0
          li    $t1, 0                  
  8032a8:	24090000 	li	t1,0
          sw    $t1, 4($t0)             
  8032ac:	ad090004 	sw	t1,4(t0)
          la    $t1, _rndModule         
  8032b0:	3c090080 	lui	t1,0x80
  8032b4:	25297030 	addiu	t1,t1,28720
          sw    $t1, 0($t0)             
  8032b8:	ad090000 	sw	t1,0(t0)
          move  $v0, $t0                
  8032bc:	01001021 	move	v0,t0
          move  $sp, $fp                
  8032c0:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  8032c4:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  8032c8:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  8032cc:	03e00008 	jr	ra
  8032d0:	00000000 	nop

008032d4 <_Deck_New>:

_Deck_New:                              # function entry
          sw $fp, 0($sp)                
  8032d4:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  8032d8:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  8032dc:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -16           
  8032e0:	27bdfff0 	addiu	sp,sp,-16

008032e4 <_L168>:
_L168:                                  
          li    $t0, 16                 
  8032e4:	24080010 	li	t0,16
          move  $a0, $t0                
  8032e8:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  8032ec:	afa80004 	sw	t0,4(sp)
          jal   _Alloc                  
  8032f0:	0c20016c 	jal	8005b0 <_Alloc>
  8032f4:	00000000 	nop
          move  $t0, $v0                
  8032f8:	00404021 	move	t0,v0
          li    $t1, 0                  
  8032fc:	24090000 	li	t1,0
          sw    $t1, 4($t0)             
  803300:	ad090004 	sw	t1,4(t0)
          sw    $t1, 8($t0)             
  803304:	ad090008 	sw	t1,8(t0)
          sw    $t1, 12($t0)            
  803308:	ad09000c 	sw	t1,12(t0)
          la    $t1, _Deck              
  80330c:	3c090080 	lui	t1,0x80
  803310:	25297044 	addiu	t1,t1,28740
          sw    $t1, 0($t0)             
  803314:	ad090000 	sw	t1,0(t0)
          move  $v0, $t0                
  803318:	01001021 	move	v0,t0
          move  $sp, $fp                
  80331c:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  803320:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  803324:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  803328:	03e00008 	jr	ra
  80332c:	00000000 	nop

00803330 <_BJDeck_New>:

_BJDeck_New:                            # function entry
          sw $fp, 0($sp)                
  803330:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  803334:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  803338:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -16           
  80333c:	27bdfff0 	addiu	sp,sp,-16

00803340 <_L169>:
_L169:                                  
          li    $t0, 16                 
  803340:	24080010 	li	t0,16
          move  $a0, $t0                
  803344:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  803348:	afa80004 	sw	t0,4(sp)
          jal   _Alloc                  
  80334c:	0c20016c 	jal	8005b0 <_Alloc>
  803350:	00000000 	nop
          move  $t0, $v0                
  803354:	00404021 	move	t0,v0
          li    $t1, 0                  
  803358:	24090000 	li	t1,0
          sw    $t1, 4($t0)             
  80335c:	ad090004 	sw	t1,4(t0)
          sw    $t1, 8($t0)             
  803360:	ad090008 	sw	t1,8(t0)
          sw    $t1, 12($t0)            
  803364:	ad09000c 	sw	t1,12(t0)
          la    $t1, _BJDeck            
  803368:	3c090080 	lui	t1,0x80
  80336c:	25297058 	addiu	t1,t1,28760
          sw    $t1, 0($t0)             
  803370:	ad090000 	sw	t1,0(t0)
          move  $v0, $t0                
  803374:	01001021 	move	v0,t0
          move  $sp, $fp                
  803378:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  80337c:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  803380:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  803384:	03e00008 	jr	ra
  803388:	00000000 	nop

0080338c <_Player_New>:

_Player_New:                            # function entry
          sw $fp, 0($sp)                
  80338c:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  803390:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  803394:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -32           
  803398:	27bdffe0 	addiu	sp,sp,-32

0080339c <_L170>:
_L170:                                  
          li    $t0, 28                 
  80339c:	2408001c 	li	t0,28
          move  $a0, $t0                
  8033a0:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  8033a4:	afa80004 	sw	t0,4(sp)
          sw    $t0, -8($fp)            
  8033a8:	afc8fff8 	sw	t0,-8(s8)
          jal   _Alloc                  
  8033ac:	0c20016c 	jal	8005b0 <_Alloc>
  8033b0:	00000000 	nop
          move  $t1, $v0                
  8033b4:	00404821 	move	t1,v0
          lw    $t0, -8($fp)            
  8033b8:	8fc8fff8 	lw	t0,-8(s8)
          li    $t2, 0                  
  8033bc:	240a0000 	li	t2,0
          li    $t3, 4                  
  8033c0:	240b0004 	li	t3,4
          addu  $t4, $t1, $t0           
  8033c4:	01286021 	addu	t4,t1,t0
          sw    $t0, -8($fp)            
  8033c8:	afc8fff8 	sw	t0,-8(s8)
          sw    $t2, -12($fp)           
  8033cc:	afcafff4 	sw	t2,-12(s8)
          sw    $t3, -16($fp)           
  8033d0:	afcbfff0 	sw	t3,-16(s8)
          sw    $t4, -20($fp)           
  8033d4:	afccffec 	sw	t4,-20(s8)

008033d8 <_L171>:
_L171:                                  
          lw    $t0, -20($fp)           
  8033d8:	8fc8ffec 	lw	t0,-20(s8)
          lw    $t1, -16($fp)           
  8033dc:	8fc9fff0 	lw	t1,-16(s8)
          subu  $t2, $t0, $t1           
  8033e0:	01095023 	subu	t2,t0,t1
          move  $t0, $t2                
  8033e4:	01404021 	move	t0,t2
          lw    $t2, -8($fp)            
  8033e8:	8fcafff8 	lw	t2,-8(s8)
          subu  $t3, $t2, $t1           
  8033ec:	01495823 	subu	t3,t2,t1
          move  $t2, $t3                
  8033f0:	01605021 	move	t2,t3
          sw    $t2, -8($fp)            
  8033f4:	afcafff8 	sw	t2,-8(s8)
          sw    $t1, -16($fp)           
  8033f8:	afc9fff0 	sw	t1,-16(s8)
          sw    $t0, -20($fp)           
  8033fc:	afc8ffec 	sw	t0,-20(s8)
          beqz  $t2, _L173              
  803400:	11400008 	beqz	t2,803424 <_L173>
  803404:	00000000 	nop

00803408 <_L172>:
_L172:                                  
          lw    $t0, -20($fp)           
  803408:	8fc8ffec 	lw	t0,-20(s8)
          lw    $t1, -12($fp)           
  80340c:	8fc9fff4 	lw	t1,-12(s8)
          sw    $t1, 0($t0)             
  803410:	ad090000 	sw	t1,0(t0)
          sw    $t1, -12($fp)           
  803414:	afc9fff4 	sw	t1,-12(s8)
          sw    $t0, -20($fp)           
  803418:	afc8ffec 	sw	t0,-20(s8)
          b     _L171                   
  80341c:	1000ffee 	b	8033d8 <_L171>
  803420:	00000000 	nop

00803424 <_L173>:
_L173:                                  
          la    $t0, _Player            
  803424:	3c080080 	lui	t0,0x80
  803428:	25087070 	addiu	t0,t0,28784
          lw    $t1, -20($fp)           
  80342c:	8fc9ffec 	lw	t1,-20(s8)
          sw    $t0, 0($t1)             
  803430:	ad280000 	sw	t0,0(t1)
          move  $v0, $t1                
  803434:	01201021 	move	v0,t1
          move  $sp, $fp                
  803438:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  80343c:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  803440:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  803444:	03e00008 	jr	ra
  803448:	00000000 	nop

0080344c <_Dealer_New>:

_Dealer_New:                            # function entry
          sw $fp, 0($sp)                
  80344c:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  803450:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  803454:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -32           
  803458:	27bdffe0 	addiu	sp,sp,-32

0080345c <_L174>:
_L174:                                  
          li    $t0, 28                 
  80345c:	2408001c 	li	t0,28
          move  $a0, $t0                
  803460:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  803464:	afa80004 	sw	t0,4(sp)
          sw    $t0, -8($fp)            
  803468:	afc8fff8 	sw	t0,-8(s8)
          jal   _Alloc                  
  80346c:	0c20016c 	jal	8005b0 <_Alloc>
  803470:	00000000 	nop
          move  $t1, $v0                
  803474:	00404821 	move	t1,v0
          lw    $t0, -8($fp)            
  803478:	8fc8fff8 	lw	t0,-8(s8)
          li    $t2, 0                  
  80347c:	240a0000 	li	t2,0
          li    $t3, 4                  
  803480:	240b0004 	li	t3,4
          addu  $t4, $t1, $t0           
  803484:	01286021 	addu	t4,t1,t0
          sw    $t2, -12($fp)           
  803488:	afcafff4 	sw	t2,-12(s8)
          sw    $t3, -16($fp)           
  80348c:	afcbfff0 	sw	t3,-16(s8)
          sw    $t4, -20($fp)           
  803490:	afccffec 	sw	t4,-20(s8)
          sw    $t0, -8($fp)            
  803494:	afc8fff8 	sw	t0,-8(s8)

00803498 <_L175>:
_L175:                                  
          lw    $t0, -20($fp)           
  803498:	8fc8ffec 	lw	t0,-20(s8)
          lw    $t1, -16($fp)           
  80349c:	8fc9fff0 	lw	t1,-16(s8)
          subu  $t2, $t0, $t1           
  8034a0:	01095023 	subu	t2,t0,t1
          move  $t0, $t2                
  8034a4:	01404021 	move	t0,t2
          lw    $t2, -8($fp)            
  8034a8:	8fcafff8 	lw	t2,-8(s8)
          subu  $t3, $t2, $t1           
  8034ac:	01495823 	subu	t3,t2,t1
          move  $t2, $t3                
  8034b0:	01605021 	move	t2,t3
          sw    $t1, -16($fp)           
  8034b4:	afc9fff0 	sw	t1,-16(s8)
          sw    $t0, -20($fp)           
  8034b8:	afc8ffec 	sw	t0,-20(s8)
          sw    $t2, -8($fp)            
  8034bc:	afcafff8 	sw	t2,-8(s8)
          beqz  $t2, _L177              
  8034c0:	11400008 	beqz	t2,8034e4 <_L177>
  8034c4:	00000000 	nop

008034c8 <_L176>:
_L176:                                  
          lw    $t0, -20($fp)           
  8034c8:	8fc8ffec 	lw	t0,-20(s8)
          lw    $t1, -12($fp)           
  8034cc:	8fc9fff4 	lw	t1,-12(s8)
          sw    $t1, 0($t0)             
  8034d0:	ad090000 	sw	t1,0(t0)
          sw    $t1, -12($fp)           
  8034d4:	afc9fff4 	sw	t1,-12(s8)
          sw    $t0, -20($fp)           
  8034d8:	afc8ffec 	sw	t0,-20(s8)
          b     _L175                   
  8034dc:	1000ffee 	b	803498 <_L175>
  8034e0:	00000000 	nop

008034e4 <_L177>:
_L177:                                  
          la    $t0, _Dealer            
  8034e4:	3c080080 	lui	t0,0x80
  8034e8:	250870a0 	addiu	t0,t0,28832
          lw    $t1, -20($fp)           
  8034ec:	8fc9ffec 	lw	t1,-20(s8)
          sw    $t0, 0($t1)             
  8034f0:	ad280000 	sw	t0,0(t1)
          move  $v0, $t1                
  8034f4:	01201021 	move	v0,t1
          move  $sp, $fp                
  8034f8:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  8034fc:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  803500:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  803504:	03e00008 	jr	ra
  803508:	00000000 	nop

0080350c <_House_New>:

_House_New:                             # function entry
          sw $fp, 0($sp)                
  80350c:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  803510:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  803514:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -16           
  803518:	27bdfff0 	addiu	sp,sp,-16

0080351c <_L178>:
_L178:                                  
          li    $t0, 16                 
  80351c:	24080010 	li	t0,16
          move  $a0, $t0                
  803520:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  803524:	afa80004 	sw	t0,4(sp)
          jal   _Alloc                  
  803528:	0c20016c 	jal	8005b0 <_Alloc>
  80352c:	00000000 	nop
          move  $t0, $v0                
  803530:	00404021 	move	t0,v0
          li    $t1, 0                  
  803534:	24090000 	li	t1,0
          sw    $t1, 4($t0)             
  803538:	ad090004 	sw	t1,4(t0)
          sw    $t1, 8($t0)             
  80353c:	ad090008 	sw	t1,8(t0)
          sw    $t1, 12($t0)            
  803540:	ad09000c 	sw	t1,12(t0)
          la    $t1, _House             
  803544:	3c090080 	lui	t1,0x80
  803548:	252970d0 	addiu	t1,t1,28880
          sw    $t1, 0($t0)             
  80354c:	ad090000 	sw	t1,0(t0)
          move  $v0, $t0                
  803550:	01001021 	move	v0,t0
          move  $sp, $fp                
  803554:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  803558:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  80355c:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  803560:	03e00008 	jr	ra
  803564:	00000000 	nop

00803568 <_Main_New>:

_Main_New:                              # function entry
          sw $fp, 0($sp)                
  803568:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  80356c:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  803570:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -16           
  803574:	27bdfff0 	addiu	sp,sp,-16

00803578 <_L179>:
_L179:                                  
          li    $t0, 4                  
  803578:	24080004 	li	t0,4
          move  $a0, $t0                
  80357c:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  803580:	afa80004 	sw	t0,4(sp)
          jal   _Alloc                  
  803584:	0c20016c 	jal	8005b0 <_Alloc>
  803588:	00000000 	nop
          move  $t0, $v0                
  80358c:	00404021 	move	t0,v0
          la    $t1, _Main              
  803590:	3c090080 	lui	t1,0x80
  803594:	252970f4 	addiu	t1,t1,28916
          sw    $t1, 0($t0)             
  803598:	ad090000 	sw	t1,0(t0)
          move  $v0, $t0                
  80359c:	01001021 	move	v0,t0
          move  $sp, $fp                
  8035a0:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  8035a4:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  8035a8:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  8035ac:	03e00008 	jr	ra
  8035b0:	00000000 	nop

008035b4 <_rndModule.Init>:

_rndModule.Init:                        # function entry
          sw $fp, 0($sp)                
  8035b4:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  8035b8:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  8035bc:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -12           
  8035c0:	27bdfff4 	addiu	sp,sp,-12

008035c4 <_L180>:
_L180:                                  
          lw    $t0, 4($fp)             
  8035c4:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  8035c8:	8d090004 	lw	t1,4(t0)
          lw    $t1, 8($fp)             
  8035cc:	8fc90008 	lw	t1,8(s8)
          sw    $t1, 4($t0)             
  8035d0:	ad090004 	sw	t1,4(t0)
          sw    $t0, 4($fp)             
  8035d4:	afc80004 	sw	t0,4(s8)
          sw    $t1, 8($fp)             
  8035d8:	afc90008 	sw	t1,8(s8)
          move  $v0, $zero              
  8035dc:	00001021 	move	v0,zero
          move  $sp, $fp                
  8035e0:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  8035e4:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  8035e8:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  8035ec:	03e00008 	jr	ra
  8035f0:	00000000 	nop

008035f4 <_rndModule.Random>:

_rndModule.Random:                      # function entry
          sw $fp, 0($sp)                
  8035f4:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  8035f8:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  8035fc:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -12           
  803600:	27bdfff4 	addiu	sp,sp,-12

00803604 <_L181>:
_L181:                                  
          lw    $t0, 4($fp)             
  803604:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  803608:	8d090004 	lw	t1,4(t0)
          li    $t1, 15625              
  80360c:	24093d09 	li	t1,15625
          lw    $t2, 4($t0)             
  803610:	8d0a0004 	lw	t2,4(t0)
          li    $t3, 10000              
  803614:	240b2710 	li	t3,10000
          div   $zero, $t2, $t3         
  803618:	014b001a 	div	zero,t2,t3
          mfhi  $t4                     
  80361c:	00006010 	mfhi	t4
          mult  $t1, $t4                
  803620:	012c0018 	mult	t1,t4
          mflo  $t2                     
  803624:	00005012 	mflo	t2
          li    $t1, 22221              
  803628:	240956cd 	li	t1,22221
          addu  $t3, $t2, $t1           
  80362c:	01495821 	addu	t3,t2,t1
          lui   $t1, 1                  
  803630:	3c090001 	lui	t1,0x1
          div   $zero, $t3, $t1         
  803634:	0169001a 	div	zero,t3,t1
          mfhi  $t2                     
  803638:	00005010 	mfhi	t2
          sw    $t2, 4($t0)             
  80363c:	ad0a0004 	sw	t2,4(t0)
          lw    $t1, 4($t0)             
  803640:	8d090004 	lw	t1,4(t0)
          sw    $t0, 4($fp)             
  803644:	afc80004 	sw	t0,4(s8)
          move  $v0, $t1                
  803648:	01201021 	move	v0,t1
          move  $sp, $fp                
  80364c:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  803650:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  803654:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  803658:	03e00008 	jr	ra
  80365c:	00000000 	nop

00803660 <_rndModule.RndInt>:

_rndModule.RndInt:                      # function entry
          sw $fp, 0($sp)                
  803660:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  803664:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  803668:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -16           
  80366c:	27bdfff0 	addiu	sp,sp,-16

00803670 <_L182>:
_L182:                                  
          lw    $t0, 4($fp)             
  803670:	8fc80004 	lw	t0,4(s8)
          move  $a0, $t0                
  803674:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  803678:	afa80004 	sw	t0,4(sp)
          lw    $t1, 0($t0)             
  80367c:	8d090000 	lw	t1,0(t0)
          lw    $t2, 12($t1)            
  803680:	8d2a000c 	lw	t2,12(t1)
          sw    $t0, 4($fp)             
  803684:	afc80004 	sw	t0,4(s8)
          jalr  $t2                     
  803688:	0140f809 	jalr	t2
  80368c:	00000000 	nop
          move  $t1, $v0                
  803690:	00404821 	move	t1,v0
          lw    $t0, 4($fp)             
  803694:	8fc80004 	lw	t0,4(s8)
          lw    $t2, 8($fp)             
  803698:	8fca0008 	lw	t2,8(s8)
          div   $zero, $t1, $t2         
  80369c:	012a001a 	div	zero,t1,t2
          mfhi  $t3                     
  8036a0:	00005810 	mfhi	t3
          sw    $t0, 4($fp)             
  8036a4:	afc80004 	sw	t0,4(s8)
          sw    $t2, 8($fp)             
  8036a8:	afca0008 	sw	t2,8(s8)
          move  $v0, $t3                
  8036ac:	01601021 	move	v0,t3
          move  $sp, $fp                
  8036b0:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  8036b4:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  8036b8:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  8036bc:	03e00008 	jr	ra
  8036c0:	00000000 	nop

008036c4 <_Deck.Init>:

_Deck.Init:                             # function entry
          sw $fp, 0($sp)                
  8036c4:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  8036c8:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  8036cc:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -36           
  8036d0:	27bdffdc 	addiu	sp,sp,-36

008036d4 <_L183>:
_L183:                                  
          lw    $t0, 4($fp)             
  8036d4:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($t0)             
  8036d8:	8d090008 	lw	t1,8(t0)
          li    $t1, 52                 
  8036dc:	24090034 	li	t1,52
          li    $t2, 0                  
  8036e0:	240a0000 	li	t2,0
          slt   $t3, $t1, $t2           
  8036e4:	012a582a 	slt	t3,t1,t2
          sw    $t0, 4($fp)             
  8036e8:	afc80004 	sw	t0,4(s8)
          sw    $t1, -8($fp)            
  8036ec:	afc9fff8 	sw	t1,-8(s8)
          beqz  $t3, _L185              
  8036f0:	11600009 	beqz	t3,803718 <_L185>
  8036f4:	00000000 	nop

008036f8 <_L184>:
_L184:                                  
          la    $t0, _STRING7           
  8036f8:	3c080080 	lui	t0,0x80
  8036fc:	25087209 	addiu	t0,t0,29193
          move  $a0, $t0                
  803700:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  803704:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  803708:	0c2001d8 	jal	800760 <_PrintString>
  80370c:	00000000 	nop
          jal   _Halt                   
  803710:	0c200200 	jal	800800 <_Halt>
  803714:	00000000 	nop

00803718 <_L185>:
_L185:                                  
          li    $t0, 4                  
  803718:	24080004 	li	t0,4
          lw    $t1, -8($fp)            
  80371c:	8fc9fff8 	lw	t1,-8(s8)
          mult  $t0, $t1                
  803720:	01090018 	mult	t0,t1
          mflo  $t2                     
  803724:	00005012 	mflo	t2
          addu  $t3, $t0, $t2           
  803728:	010a5821 	addu	t3,t0,t2
          move  $a0, $t3                
  80372c:	01602021 	move	a0,t3
          sw    $t3, 4($sp)             
  803730:	afab0004 	sw	t3,4(sp)
          sw    $t0, -12($fp)           
  803734:	afc8fff4 	sw	t0,-12(s8)
          sw    $t3, -16($fp)           
  803738:	afcbfff0 	sw	t3,-16(s8)
          sw    $t1, -8($fp)            
  80373c:	afc9fff8 	sw	t1,-8(s8)
          jal   _Alloc                  
  803740:	0c20016c 	jal	8005b0 <_Alloc>
  803744:	00000000 	nop
          move  $t2, $v0                
  803748:	00405021 	move	t2,v0
          lw    $t0, -12($fp)           
  80374c:	8fc8fff4 	lw	t0,-12(s8)
          lw    $t3, -16($fp)           
  803750:	8fcbfff0 	lw	t3,-16(s8)
          lw    $t1, -8($fp)            
  803754:	8fc9fff8 	lw	t1,-8(s8)
          sw    $t1, 0($t2)             
  803758:	ad490000 	sw	t1,0(t2)
          li    $t1, 0                  
  80375c:	24090000 	li	t1,0
          addu  $t2, $t2, $t3           
  803760:	014b5021 	addu	t2,t2,t3
          sw    $t0, -12($fp)           
  803764:	afc8fff4 	sw	t0,-12(s8)
          sw    $t3, -16($fp)           
  803768:	afcbfff0 	sw	t3,-16(s8)
          sw    $t2, -20($fp)           
  80376c:	afcaffec 	sw	t2,-20(s8)
          sw    $t1, -24($fp)           
  803770:	afc9ffe8 	sw	t1,-24(s8)

00803774 <_L186>:
_L186:                                  
          lw    $t0, -16($fp)           
  803774:	8fc8fff0 	lw	t0,-16(s8)
          lw    $t1, -12($fp)           
  803778:	8fc9fff4 	lw	t1,-12(s8)
          subu  $t0, $t0, $t1           
  80377c:	01094023 	subu	t0,t0,t1
          sw    $t1, -12($fp)           
  803780:	afc9fff4 	sw	t1,-12(s8)
          sw    $t0, -16($fp)           
  803784:	afc8fff0 	sw	t0,-16(s8)
          beqz  $t0, _L188              
  803788:	1100000b 	beqz	t0,8037b8 <_L188>
  80378c:	00000000 	nop

00803790 <_L187>:
_L187:                                  
          lw    $t0, -20($fp)           
  803790:	8fc8ffec 	lw	t0,-20(s8)
          lw    $t1, -12($fp)           
  803794:	8fc9fff4 	lw	t1,-12(s8)
          subu  $t0, $t0, $t1           
  803798:	01094023 	subu	t0,t0,t1
          lw    $t2, -24($fp)           
  80379c:	8fcaffe8 	lw	t2,-24(s8)
          sw    $t2, 0($t0)             
  8037a0:	ad0a0000 	sw	t2,0(t0)
          sw    $t1, -12($fp)           
  8037a4:	afc9fff4 	sw	t1,-12(s8)
          sw    $t0, -20($fp)           
  8037a8:	afc8ffec 	sw	t0,-20(s8)
          sw    $t2, -24($fp)           
  8037ac:	afcaffe8 	sw	t2,-24(s8)
          b     _L186                   
  8037b0:	1000fff0 	b	803774 <_L186>
  8037b4:	00000000 	nop

008037b8 <_L188>:
_L188:                                  
          lw    $t0, 4($fp)             
  8037b8:	8fc80004 	lw	t0,4(s8)
          lw    $t1, -20($fp)           
  8037bc:	8fc9ffec 	lw	t1,-20(s8)
          sw    $t1, 8($t0)             
  8037c0:	ad090008 	sw	t1,8(t0)
          lw    $t1, 12($t0)            
  8037c4:	8d09000c 	lw	t1,12(t0)
          lw    $t1, 8($fp)             
  8037c8:	8fc90008 	lw	t1,8(s8)
          sw    $t1, 12($t0)            
  8037cc:	ad09000c 	sw	t1,12(t0)
          sw    $t0, 4($fp)             
  8037d0:	afc80004 	sw	t0,4(s8)
          sw    $t1, 8($fp)             
  8037d4:	afc90008 	sw	t1,8(s8)
          move  $v0, $zero              
  8037d8:	00001021 	move	v0,zero
          move  $sp, $fp                
  8037dc:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  8037e0:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  8037e4:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  8037e8:	03e00008 	jr	ra
  8037ec:	00000000 	nop

008037f0 <_Deck.Shuffle>:

_Deck.Shuffle:                          # function entry
          sw $fp, 0($sp)                
  8037f0:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  8037f4:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  8037f8:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -60           
  8037fc:	27bdffc4 	addiu	sp,sp,-60

00803800 <_L189>:
_L189:                                  
          lw    $t0, 4($fp)             
  803800:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  803804:	8d090004 	lw	t1,4(t0)
          li    $t1, 1                  
  803808:	24090001 	li	t1,1
          sw    $t1, 4($t0)             
  80380c:	ad090004 	sw	t1,4(t0)
          sw    $t0, 4($fp)             
  803810:	afc80004 	sw	t0,4(s8)

00803814 <_L191>:
_L191:                                  
          lw    $t0, 4($fp)             
  803814:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  803818:	8d090004 	lw	t1,4(t0)
          li    $t2, 52                 
  80381c:	240a0034 	li	t2,52
          sle   $t3, $t1, $t2           
  803820:	0149582a 	slt	t3,t2,t1
  803824:	396b0001 	xori	t3,t3,0x1
          sw    $t0, 4($fp)             
  803828:	afc80004 	sw	t0,4(s8)
          beqz  $t3, _L196              
  80382c:	11600036 	beqz	t3,803908 <_L196>
  803830:	00000000 	nop

00803834 <_L192>:
_L192:                                  
          lw    $t0, 4($fp)             
  803834:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($t0)             
  803838:	8d090008 	lw	t1,8(t0)
          lw    $t2, 4($t0)             
  80383c:	8d0a0004 	lw	t2,4(t0)
          li    $t3, 1                  
  803840:	240b0001 	li	t3,1
          subu  $t4, $t2, $t3           
  803844:	014b6023 	subu	t4,t2,t3
          lw    $t2, -4($t1)            
  803848:	8d2afffc 	lw	t2,-4(t1)
          slt   $t3, $t4, $t2           
  80384c:	018a582a 	slt	t3,t4,t2
          sw    $t1, -8($fp)            
  803850:	afc9fff8 	sw	t1,-8(s8)
          sw    $t4, -12($fp)           
  803854:	afccfff4 	sw	t4,-12(s8)
          sw    $t0, 4($fp)             
  803858:	afc80004 	sw	t0,4(s8)
          beqz  $t3, _L194              
  80385c:	11600007 	beqz	t3,80387c <_L194>
  803860:	00000000 	nop

00803864 <_L193>:
_L193:                                  
          li    $t0, 0                  
  803864:	24080000 	li	t0,0
          lw    $t1, -12($fp)           
  803868:	8fc9fff4 	lw	t1,-12(s8)
          slt   $t2, $t1, $t0           
  80386c:	0128502a 	slt	t2,t1,t0
          sw    $t1, -12($fp)           
  803870:	afc9fff4 	sw	t1,-12(s8)
          beqz  $t2, _L195              
  803874:	11400009 	beqz	t2,80389c <_L195>
  803878:	00000000 	nop

0080387c <_L194>:
_L194:                                  
          la    $t0, _STRING8           
  80387c:	3c080080 	lui	t0,0x80
  803880:	250873be 	addiu	t0,t0,29630
          move  $a0, $t0                
  803884:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  803888:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  80388c:	0c2001d8 	jal	800760 <_PrintString>
  803890:	00000000 	nop
          jal   _Halt                   
  803894:	0c200200 	jal	800800 <_Halt>
  803898:	00000000 	nop

0080389c <_L195>:
_L195:                                  
          li    $t0, 4                  
  80389c:	24080004 	li	t0,4
          lw    $t1, -12($fp)           
  8038a0:	8fc9fff4 	lw	t1,-12(s8)
          mult  $t1, $t0                
  8038a4:	01280018 	mult	t1,t0
          mflo  $t2                     
  8038a8:	00005012 	mflo	t2
          lw    $t0, -8($fp)            
  8038ac:	8fc8fff8 	lw	t0,-8(s8)
          addu  $t3, $t0, $t2           
  8038b0:	010a5821 	addu	t3,t0,t2
          lw    $t2, 0($t3)             
  8038b4:	8d6a0000 	lw	t2,0(t3)
          lw    $t2, 4($fp)             
  8038b8:	8fca0004 	lw	t2,4(s8)
          lw    $t3, 4($t2)             
  8038bc:	8d4b0004 	lw	t3,4(t2)
          li    $t4, 13                 
  8038c0:	240c000d 	li	t4,13
          div   $zero, $t3, $t4         
  8038c4:	016c001a 	div	zero,t3,t4
          mfhi  $t5                     
  8038c8:	00006810 	mfhi	t5
          li    $t3, 4                  
  8038cc:	240b0004 	li	t3,4
          mult  $t1, $t3                
  8038d0:	012b0018 	mult	t1,t3
          mflo  $t4                     
  8038d4:	00006012 	mflo	t4
          addu  $t1, $t0, $t4           
  8038d8:	010c4821 	addu	t1,t0,t4
          sw    $t5, 0($t1)             
  8038dc:	ad2d0000 	sw	t5,0(t1)
          sw    $t2, 4($fp)             
  8038e0:	afca0004 	sw	t2,4(s8)

008038e4 <_L190>:
_L190:                                  
          lw    $t0, 4($fp)             
  8038e4:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  8038e8:	8d090004 	lw	t1,4(t0)
          lw    $t1, 4($t0)             
  8038ec:	8d090004 	lw	t1,4(t0)
          li    $t2, 1                  
  8038f0:	240a0001 	li	t2,1
          addu  $t3, $t1, $t2           
  8038f4:	012a5821 	addu	t3,t1,t2
          sw    $t3, 4($t0)             
  8038f8:	ad0b0004 	sw	t3,4(t0)
          sw    $t0, 4($fp)             
  8038fc:	afc80004 	sw	t0,4(s8)
          b     _L191                   
  803900:	1000ffc4 	b	803814 <_L191>
  803904:	00000000 	nop

00803908 <_L196>:
_L196:                                  
          lw    $t0, 4($fp)             
  803908:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  80390c:	8d090004 	lw	t1,4(t0)
          lw    $t1, 4($t0)             
  803910:	8d090004 	lw	t1,4(t0)
          li    $t2, 1                  
  803914:	240a0001 	li	t2,1
          subu  $t3, $t1, $t2           
  803918:	012a5823 	subu	t3,t1,t2
          sw    $t3, 4($t0)             
  80391c:	ad0b0004 	sw	t3,4(t0)
          sw    $t0, 4($fp)             
  803920:	afc80004 	sw	t0,4(s8)

00803924 <_L197>:
_L197:                                  
          lw    $t0, 4($fp)             
  803924:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  803928:	8d090004 	lw	t1,4(t0)
          li    $t2, 0                  
  80392c:	240a0000 	li	t2,0
          sgt   $t3, $t1, $t2           
  803930:	0149582a 	slt	t3,t2,t1
          sw    $t0, 4($fp)             
  803934:	afc80004 	sw	t0,4(s8)
          beqz  $t3, _L211              
  803938:	116000a3 	beqz	t3,803bc8 <_L211>
  80393c:	00000000 	nop

00803940 <_L198>:
_L198:                                  
          lw    $t0, 4($fp)             
  803940:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 12($t0)            
  803944:	8d09000c 	lw	t1,12(t0)
          lw    $t2, 4($t0)             
  803948:	8d0a0004 	lw	t2,4(t0)
          move  $a0, $t1                
  80394c:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  803950:	afa90004 	sw	t1,4(sp)
          move  $a1, $t2                
  803954:	01402821 	move	a1,t2
          sw    $t2, 8($sp)             
  803958:	afaa0008 	sw	t2,8(sp)
          lw    $t2, 0($t1)             
  80395c:	8d2a0000 	lw	t2,0(t1)
          lw    $t1, 16($t2)            
  803960:	8d490010 	lw	t1,16(t2)
          sw    $t0, 4($fp)             
  803964:	afc80004 	sw	t0,4(s8)
          jalr  $t1                     
  803968:	0120f809 	jalr	t1
  80396c:	00000000 	nop
          move  $t2, $v0                
  803970:	00405021 	move	t2,v0
          lw    $t0, 4($fp)             
  803974:	8fc80004 	lw	t0,4(s8)
          move  $t1, $t2                
  803978:	01404821 	move	t1,t2
          lw    $t2, 4($t0)             
  80397c:	8d0a0004 	lw	t2,4(t0)
          lw    $t2, 4($t0)             
  803980:	8d0a0004 	lw	t2,4(t0)
          li    $t3, 1                  
  803984:	240b0001 	li	t3,1
          subu  $t4, $t2, $t3           
  803988:	014b6023 	subu	t4,t2,t3
          sw    $t4, 4($t0)             
  80398c:	ad0c0004 	sw	t4,4(t0)
          lw    $t2, 8($t0)             
  803990:	8d0a0008 	lw	t2,8(t0)
          lw    $t3, 4($t0)             
  803994:	8d0b0004 	lw	t3,4(t0)
          lw    $t4, -4($t2)            
  803998:	8d4cfffc 	lw	t4,-4(t2)
          slt   $t5, $t3, $t4           
  80399c:	016c682a 	slt	t5,t3,t4
          sw    $t2, -20($fp)           
  8039a0:	afcaffec 	sw	t2,-20(s8)
          sw    $t0, 4($fp)             
  8039a4:	afc80004 	sw	t0,4(s8)
          sw    $t3, -24($fp)           
  8039a8:	afcbffe8 	sw	t3,-24(s8)
          sw    $t1, -16($fp)           
  8039ac:	afc9fff0 	sw	t1,-16(s8)
          beqz  $t5, _L200              
  8039b0:	11a00007 	beqz	t5,8039d0 <_L200>
  8039b4:	00000000 	nop

008039b8 <_L199>:
_L199:                                  
          li    $t0, 0                  
  8039b8:	24080000 	li	t0,0
          lw    $t1, -24($fp)           
  8039bc:	8fc9ffe8 	lw	t1,-24(s8)
          slt   $t2, $t1, $t0           
  8039c0:	0128502a 	slt	t2,t1,t0
          sw    $t1, -24($fp)           
  8039c4:	afc9ffe8 	sw	t1,-24(s8)
          beqz  $t2, _L201              
  8039c8:	11400009 	beqz	t2,8039f0 <_L201>
  8039cc:	00000000 	nop

008039d0 <_L200>:
_L200:                                  
          la    $t0, _STRING8           
  8039d0:	3c080080 	lui	t0,0x80
  8039d4:	250873be 	addiu	t0,t0,29630
          move  $a0, $t0                
  8039d8:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  8039dc:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  8039e0:	0c2001d8 	jal	800760 <_PrintString>
  8039e4:	00000000 	nop
          jal   _Halt                   
  8039e8:	0c200200 	jal	800800 <_Halt>
  8039ec:	00000000 	nop

008039f0 <_L201>:
_L201:                                  
          li    $t0, 4                  
  8039f0:	24080004 	li	t0,4
          lw    $t1, -24($fp)           
  8039f4:	8fc9ffe8 	lw	t1,-24(s8)
          mult  $t1, $t0                
  8039f8:	01280018 	mult	t1,t0
          mflo  $t2                     
  8039fc:	00005012 	mflo	t2
          lw    $t0, -20($fp)           
  803a00:	8fc8ffec 	lw	t0,-20(s8)
          addu  $t1, $t0, $t2           
  803a04:	010a4821 	addu	t1,t0,t2
          lw    $t0, 0($t1)             
  803a08:	8d280000 	lw	t0,0(t1)
          move  $t1, $t0                
  803a0c:	01004821 	move	t1,t0
          lw    $t0, 4($fp)             
  803a10:	8fc80004 	lw	t0,4(s8)
          lw    $t2, 8($t0)             
  803a14:	8d0a0008 	lw	t2,8(t0)
          lw    $t3, 4($t0)             
  803a18:	8d0b0004 	lw	t3,4(t0)
          lw    $t4, -4($t2)            
  803a1c:	8d4cfffc 	lw	t4,-4(t2)
          slt   $t5, $t3, $t4           
  803a20:	016c682a 	slt	t5,t3,t4
          sw    $t2, -32($fp)           
  803a24:	afcaffe0 	sw	t2,-32(s8)
          sw    $t3, -36($fp)           
  803a28:	afcbffdc 	sw	t3,-36(s8)
          sw    $t0, 4($fp)             
  803a2c:	afc80004 	sw	t0,4(s8)
          sw    $t1, -28($fp)           
  803a30:	afc9ffe4 	sw	t1,-28(s8)
          beqz  $t5, _L203              
  803a34:	11a00007 	beqz	t5,803a54 <_L203>
  803a38:	00000000 	nop

00803a3c <_L202>:
_L202:                                  
          li    $t0, 0                  
  803a3c:	24080000 	li	t0,0
          lw    $t1, -36($fp)           
  803a40:	8fc9ffdc 	lw	t1,-36(s8)
          slt   $t2, $t1, $t0           
  803a44:	0128502a 	slt	t2,t1,t0
          sw    $t1, -36($fp)           
  803a48:	afc9ffdc 	sw	t1,-36(s8)
          beqz  $t2, _L204              
  803a4c:	11400009 	beqz	t2,803a74 <_L204>
  803a50:	00000000 	nop

00803a54 <_L203>:
_L203:                                  
          la    $t0, _STRING8           
  803a54:	3c080080 	lui	t0,0x80
  803a58:	250873be 	addiu	t0,t0,29630
          move  $a0, $t0                
  803a5c:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  803a60:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  803a64:	0c2001d8 	jal	800760 <_PrintString>
  803a68:	00000000 	nop
          jal   _Halt                   
  803a6c:	0c200200 	jal	800800 <_Halt>
  803a70:	00000000 	nop

00803a74 <_L204>:
_L204:                                  
          li    $t0, 4                  
  803a74:	24080004 	li	t0,4
          lw    $t1, -36($fp)           
  803a78:	8fc9ffdc 	lw	t1,-36(s8)
          mult  $t1, $t0                
  803a7c:	01280018 	mult	t1,t0
          mflo  $t2                     
  803a80:	00005012 	mflo	t2
          lw    $t0, -32($fp)           
  803a84:	8fc8ffe0 	lw	t0,-32(s8)
          addu  $t3, $t0, $t2           
  803a88:	010a5821 	addu	t3,t0,t2
          lw    $t2, 0($t3)             
  803a8c:	8d6a0000 	lw	t2,0(t3)
          lw    $t2, 4($fp)             
  803a90:	8fca0004 	lw	t2,4(s8)
          lw    $t3, 8($t2)             
  803a94:	8d4b0008 	lw	t3,8(t2)
          lw    $t4, -4($t3)            
  803a98:	8d6cfffc 	lw	t4,-4(t3)
          lw    $t5, -16($fp)           
  803a9c:	8fcdfff0 	lw	t5,-16(s8)
          slt   $t6, $t5, $t4           
  803aa0:	01ac702a 	slt	t6,t5,t4
          sw    $t0, -32($fp)           
  803aa4:	afc8ffe0 	sw	t0,-32(s8)
          sw    $t1, -36($fp)           
  803aa8:	afc9ffdc 	sw	t1,-36(s8)
          sw    $t2, 4($fp)             
  803aac:	afca0004 	sw	t2,4(s8)
          sw    $t5, -16($fp)           
  803ab0:	afcdfff0 	sw	t5,-16(s8)
          sw    $t3, -40($fp)           
  803ab4:	afcbffd8 	sw	t3,-40(s8)
          beqz  $t6, _L206              
  803ab8:	11c00007 	beqz	t6,803ad8 <_L206>
  803abc:	00000000 	nop

00803ac0 <_L205>:
_L205:                                  
          li    $t0, 0                  
  803ac0:	24080000 	li	t0,0
          lw    $t1, -16($fp)           
  803ac4:	8fc9fff0 	lw	t1,-16(s8)
          slt   $t2, $t1, $t0           
  803ac8:	0128502a 	slt	t2,t1,t0
          sw    $t1, -16($fp)           
  803acc:	afc9fff0 	sw	t1,-16(s8)
          beqz  $t2, _L207              
  803ad0:	11400009 	beqz	t2,803af8 <_L207>
  803ad4:	00000000 	nop

00803ad8 <_L206>:
_L206:                                  
          la    $t0, _STRING8           
  803ad8:	3c080080 	lui	t0,0x80
  803adc:	250873be 	addiu	t0,t0,29630
          move  $a0, $t0                
  803ae0:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  803ae4:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  803ae8:	0c2001d8 	jal	800760 <_PrintString>
  803aec:	00000000 	nop
          jal   _Halt                   
  803af0:	0c200200 	jal	800800 <_Halt>
  803af4:	00000000 	nop

00803af8 <_L207>:
_L207:                                  
          li    $t0, 4                  
  803af8:	24080004 	li	t0,4
          lw    $t1, -16($fp)           
  803afc:	8fc9fff0 	lw	t1,-16(s8)
          mult  $t1, $t0                
  803b00:	01280018 	mult	t1,t0
          mflo  $t2                     
  803b04:	00005012 	mflo	t2
          lw    $t0, -40($fp)           
  803b08:	8fc8ffd8 	lw	t0,-40(s8)
          addu  $t3, $t0, $t2           
  803b0c:	010a5821 	addu	t3,t0,t2
          lw    $t0, 0($t3)             
  803b10:	8d680000 	lw	t0,0(t3)
          li    $t2, 4                  
  803b14:	240a0004 	li	t2,4
          lw    $t3, -36($fp)           
  803b18:	8fcbffdc 	lw	t3,-36(s8)
          mult  $t3, $t2                
  803b1c:	016a0018 	mult	t3,t2
          mflo  $t4                     
  803b20:	00006012 	mflo	t4
          lw    $t2, -32($fp)           
  803b24:	8fcaffe0 	lw	t2,-32(s8)
          addu  $t3, $t2, $t4           
  803b28:	014c5821 	addu	t3,t2,t4
          sw    $t0, 0($t3)             
  803b2c:	ad680000 	sw	t0,0(t3)
          lw    $t0, 4($fp)             
  803b30:	8fc80004 	lw	t0,4(s8)
          lw    $t2, 8($t0)             
  803b34:	8d0a0008 	lw	t2,8(t0)
          lw    $t3, -4($t2)            
  803b38:	8d4bfffc 	lw	t3,-4(t2)
          slt   $t4, $t1, $t3           
  803b3c:	012b602a 	slt	t4,t1,t3
          sw    $t0, 4($fp)             
  803b40:	afc80004 	sw	t0,4(s8)
          sw    $t2, -44($fp)           
  803b44:	afcaffd4 	sw	t2,-44(s8)
          sw    $t1, -16($fp)           
  803b48:	afc9fff0 	sw	t1,-16(s8)
          beqz  $t4, _L209              
  803b4c:	11800007 	beqz	t4,803b6c <_L209>
  803b50:	00000000 	nop

00803b54 <_L208>:
_L208:                                  
          li    $t0, 0                  
  803b54:	24080000 	li	t0,0
          lw    $t1, -16($fp)           
  803b58:	8fc9fff0 	lw	t1,-16(s8)
          slt   $t2, $t1, $t0           
  803b5c:	0128502a 	slt	t2,t1,t0
          sw    $t1, -16($fp)           
  803b60:	afc9fff0 	sw	t1,-16(s8)
          beqz  $t2, _L210              
  803b64:	11400009 	beqz	t2,803b8c <_L210>
  803b68:	00000000 	nop

00803b6c <_L209>:
_L209:                                  
          la    $t0, _STRING8           
  803b6c:	3c080080 	lui	t0,0x80
  803b70:	250873be 	addiu	t0,t0,29630
          move  $a0, $t0                
  803b74:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  803b78:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  803b7c:	0c2001d8 	jal	800760 <_PrintString>
  803b80:	00000000 	nop
          jal   _Halt                   
  803b84:	0c200200 	jal	800800 <_Halt>
  803b88:	00000000 	nop

00803b8c <_L210>:
_L210:                                  
          li    $t0, 4                  
  803b8c:	24080004 	li	t0,4
          lw    $t1, -16($fp)           
  803b90:	8fc9fff0 	lw	t1,-16(s8)
          mult  $t1, $t0                
  803b94:	01280018 	mult	t1,t0
          mflo  $t2                     
  803b98:	00005012 	mflo	t2
          lw    $t0, -44($fp)           
  803b9c:	8fc8ffd4 	lw	t0,-44(s8)
          addu  $t3, $t0, $t2           
  803ba0:	010a5821 	addu	t3,t0,t2
          lw    $t2, 0($t3)             
  803ba4:	8d6a0000 	lw	t2,0(t3)
          li    $t2, 4                  
  803ba8:	240a0004 	li	t2,4
          mult  $t1, $t2                
  803bac:	012a0018 	mult	t1,t2
          mflo  $t3                     
  803bb0:	00005812 	mflo	t3
          addu  $t1, $t0, $t3           
  803bb4:	010b4821 	addu	t1,t0,t3
          lw    $t0, -28($fp)           
  803bb8:	8fc8ffe4 	lw	t0,-28(s8)
          sw    $t0, 0($t1)             
  803bbc:	ad280000 	sw	t0,0(t1)
          b     _L197                   
  803bc0:	1000ff58 	b	803924 <_L197>
  803bc4:	00000000 	nop

00803bc8 <_L211>:
_L211:                                  
          move  $v0, $zero              
  803bc8:	00001021 	move	v0,zero
          move  $sp, $fp                
  803bcc:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  803bd0:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  803bd4:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  803bd8:	03e00008 	jr	ra
  803bdc:	00000000 	nop

00803be0 <_Deck.GetCard>:

_Deck.GetCard:                          # function entry
          sw $fp, 0($sp)                
  803be0:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  803be4:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  803be8:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -24           
  803bec:	27bdffe8 	addiu	sp,sp,-24

00803bf0 <_L212>:
_L212:                                  
          lw    $t0, 4($fp)             
  803bf0:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  803bf4:	8d090004 	lw	t1,4(t0)
          li    $t2, 52                 
  803bf8:	240a0034 	li	t2,52
          sge   $t3, $t1, $t2           
  803bfc:	012a582a 	slt	t3,t1,t2
  803c00:	396b0001 	xori	t3,t3,0x1
          sw    $t0, 4($fp)             
  803c04:	afc80004 	sw	t0,4(s8)
          beqz  $t3, _L214              
  803c08:	11600008 	beqz	t3,803c2c <_L214>
  803c0c:	00000000 	nop

00803c10 <_L213>:
_L213:                                  
          li    $t0, 0                  
  803c10:	24080000 	li	t0,0
          move  $v0, $t0                
  803c14:	01001021 	move	v0,t0
          move  $sp, $fp                
  803c18:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  803c1c:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  803c20:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  803c24:	03e00008 	jr	ra
  803c28:	00000000 	nop

00803c2c <_L214>:
_L214:                                  
          lw    $t0, 4($fp)             
  803c2c:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($t0)             
  803c30:	8d090008 	lw	t1,8(t0)
          lw    $t2, 4($t0)             
  803c34:	8d0a0004 	lw	t2,4(t0)
          lw    $t3, -4($t1)            
  803c38:	8d2bfffc 	lw	t3,-4(t1)
          slt   $t4, $t2, $t3           
  803c3c:	014b602a 	slt	t4,t2,t3
          sw    $t0, 4($fp)             
  803c40:	afc80004 	sw	t0,4(s8)
          sw    $t1, -8($fp)            
  803c44:	afc9fff8 	sw	t1,-8(s8)
          sw    $t2, -12($fp)           
  803c48:	afcafff4 	sw	t2,-12(s8)
          beqz  $t4, _L216              
  803c4c:	11800007 	beqz	t4,803c6c <_L216>
  803c50:	00000000 	nop

00803c54 <_L215>:
_L215:                                  
          li    $t0, 0                  
  803c54:	24080000 	li	t0,0
          lw    $t1, -12($fp)           
  803c58:	8fc9fff4 	lw	t1,-12(s8)
          slt   $t2, $t1, $t0           
  803c5c:	0128502a 	slt	t2,t1,t0
          sw    $t1, -12($fp)           
  803c60:	afc9fff4 	sw	t1,-12(s8)
          beqz  $t2, _L217              
  803c64:	11400009 	beqz	t2,803c8c <_L217>
  803c68:	00000000 	nop

00803c6c <_L216>:
_L216:                                  
          la    $t0, _STRING8           
  803c6c:	3c080080 	lui	t0,0x80
  803c70:	250873be 	addiu	t0,t0,29630
          move  $a0, $t0                
  803c74:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  803c78:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  803c7c:	0c2001d8 	jal	800760 <_PrintString>
  803c80:	00000000 	nop
          jal   _Halt                   
  803c84:	0c200200 	jal	800800 <_Halt>
  803c88:	00000000 	nop

00803c8c <_L217>:
_L217:                                  
          li    $t0, 4                  
  803c8c:	24080004 	li	t0,4
          lw    $t1, -12($fp)           
  803c90:	8fc9fff4 	lw	t1,-12(s8)
          mult  $t1, $t0                
  803c94:	01280018 	mult	t1,t0
          mflo  $t2                     
  803c98:	00005012 	mflo	t2
          lw    $t0, -8($fp)            
  803c9c:	8fc8fff8 	lw	t0,-8(s8)
          addu  $t1, $t0, $t2           
  803ca0:	010a4821 	addu	t1,t0,t2
          lw    $t0, 0($t1)             
  803ca4:	8d280000 	lw	t0,0(t1)
          move  $t1, $t0                
  803ca8:	01004821 	move	t1,t0
          lw    $t0, 4($fp)             
  803cac:	8fc80004 	lw	t0,4(s8)
          lw    $t2, 4($t0)             
  803cb0:	8d0a0004 	lw	t2,4(t0)
          lw    $t2, 4($t0)             
  803cb4:	8d0a0004 	lw	t2,4(t0)
          li    $t3, 1                  
  803cb8:	240b0001 	li	t3,1
          addu  $t4, $t2, $t3           
  803cbc:	014b6021 	addu	t4,t2,t3
          sw    $t4, 4($t0)             
  803cc0:	ad0c0004 	sw	t4,4(t0)
          sw    $t0, 4($fp)             
  803cc4:	afc80004 	sw	t0,4(s8)
          move  $v0, $t1                
  803cc8:	01201021 	move	v0,t1
          move  $sp, $fp                
  803ccc:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  803cd0:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  803cd4:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  803cd8:	03e00008 	jr	ra
  803cdc:	00000000 	nop

00803ce0 <_BJDeck.Init>:

_BJDeck.Init:                           # function entry
          sw $fp, 0($sp)                
  803ce0:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  803ce4:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  803ce8:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -52           
  803cec:	27bdffcc 	addiu	sp,sp,-52

00803cf0 <_L218>:
_L218:                                  
          lw    $t0, 4($fp)             
  803cf0:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  803cf4:	8d090004 	lw	t1,4(t0)
          li    $t1, 8                  
  803cf8:	24090008 	li	t1,8
          li    $t2, 0                  
  803cfc:	240a0000 	li	t2,0
          slt   $t3, $t1, $t2           
  803d00:	012a582a 	slt	t3,t1,t2
          sw    $t0, 4($fp)             
  803d04:	afc80004 	sw	t0,4(s8)
          sw    $t1, -8($fp)            
  803d08:	afc9fff8 	sw	t1,-8(s8)
          beqz  $t3, _L220              
  803d0c:	11600009 	beqz	t3,803d34 <_L220>
  803d10:	00000000 	nop

00803d14 <_L219>:
_L219:                                  
          la    $t0, _STRING7           
  803d14:	3c080080 	lui	t0,0x80
  803d18:	25087209 	addiu	t0,t0,29193
          move  $a0, $t0                
  803d1c:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  803d20:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  803d24:	0c2001d8 	jal	800760 <_PrintString>
  803d28:	00000000 	nop
          jal   _Halt                   
  803d2c:	0c200200 	jal	800800 <_Halt>
  803d30:	00000000 	nop

00803d34 <_L220>:
_L220:                                  
          li    $t0, 4                  
  803d34:	24080004 	li	t0,4
          lw    $t1, -8($fp)            
  803d38:	8fc9fff8 	lw	t1,-8(s8)
          mult  $t0, $t1                
  803d3c:	01090018 	mult	t0,t1
          mflo  $t2                     
  803d40:	00005012 	mflo	t2
          addu  $t3, $t0, $t2           
  803d44:	010a5821 	addu	t3,t0,t2
          move  $a0, $t3                
  803d48:	01602021 	move	a0,t3
          sw    $t3, 4($sp)             
  803d4c:	afab0004 	sw	t3,4(sp)
          sw    $t0, -12($fp)           
  803d50:	afc8fff4 	sw	t0,-12(s8)
          sw    $t3, -16($fp)           
  803d54:	afcbfff0 	sw	t3,-16(s8)
          sw    $t1, -8($fp)            
  803d58:	afc9fff8 	sw	t1,-8(s8)
          jal   _Alloc                  
  803d5c:	0c20016c 	jal	8005b0 <_Alloc>
  803d60:	00000000 	nop
          move  $t2, $v0                
  803d64:	00405021 	move	t2,v0
          lw    $t0, -12($fp)           
  803d68:	8fc8fff4 	lw	t0,-12(s8)
          lw    $t3, -16($fp)           
  803d6c:	8fcbfff0 	lw	t3,-16(s8)
          lw    $t1, -8($fp)            
  803d70:	8fc9fff8 	lw	t1,-8(s8)
          sw    $t1, 0($t2)             
  803d74:	ad490000 	sw	t1,0(t2)
          li    $t1, 0                  
  803d78:	24090000 	li	t1,0
          addu  $t2, $t2, $t3           
  803d7c:	014b5021 	addu	t2,t2,t3
          sw    $t0, -12($fp)           
  803d80:	afc8fff4 	sw	t0,-12(s8)
          sw    $t3, -16($fp)           
  803d84:	afcbfff0 	sw	t3,-16(s8)
          sw    $t2, -20($fp)           
  803d88:	afcaffec 	sw	t2,-20(s8)
          sw    $t1, -24($fp)           
  803d8c:	afc9ffe8 	sw	t1,-24(s8)

00803d90 <_L221>:
_L221:                                  
          lw    $t0, -16($fp)           
  803d90:	8fc8fff0 	lw	t0,-16(s8)
          lw    $t1, -12($fp)           
  803d94:	8fc9fff4 	lw	t1,-12(s8)
          subu  $t0, $t0, $t1           
  803d98:	01094023 	subu	t0,t0,t1
          sw    $t1, -12($fp)           
  803d9c:	afc9fff4 	sw	t1,-12(s8)
          sw    $t0, -16($fp)           
  803da0:	afc8fff0 	sw	t0,-16(s8)
          beqz  $t0, _L223              
  803da4:	1100000b 	beqz	t0,803dd4 <_L223>
  803da8:	00000000 	nop

00803dac <_L222>:
_L222:                                  
          lw    $t0, -20($fp)           
  803dac:	8fc8ffec 	lw	t0,-20(s8)
          lw    $t1, -12($fp)           
  803db0:	8fc9fff4 	lw	t1,-12(s8)
          subu  $t0, $t0, $t1           
  803db4:	01094023 	subu	t0,t0,t1
          lw    $t2, -24($fp)           
  803db8:	8fcaffe8 	lw	t2,-24(s8)
          sw    $t2, 0($t0)             
  803dbc:	ad0a0000 	sw	t2,0(t0)
          sw    $t1, -12($fp)           
  803dc0:	afc9fff4 	sw	t1,-12(s8)
          sw    $t0, -20($fp)           
  803dc4:	afc8ffec 	sw	t0,-20(s8)
          sw    $t2, -24($fp)           
  803dc8:	afcaffe8 	sw	t2,-24(s8)
          b     _L221                   
  803dcc:	1000fff0 	b	803d90 <_L221>
  803dd0:	00000000 	nop

00803dd4 <_L223>:
_L223:                                  
          lw    $t0, 4($fp)             
  803dd4:	8fc80004 	lw	t0,4(s8)
          lw    $t1, -20($fp)           
  803dd8:	8fc9ffec 	lw	t1,-20(s8)
          sw    $t1, 4($t0)             
  803ddc:	ad090004 	sw	t1,4(t0)
          li    $t1, 0                  
  803de0:	24090000 	li	t1,0
          move  $t2, $t1                
  803de4:	01205021 	move	t2,t1
          sw    $t0, 4($fp)             
  803de8:	afc80004 	sw	t0,4(s8)
          sw    $t2, -28($fp)           
  803dec:	afcaffe4 	sw	t2,-28(s8)

00803df0 <_L225>:
_L225:                                  
          li    $t0, 8                  
  803df0:	24080008 	li	t0,8
          lw    $t1, -28($fp)           
  803df4:	8fc9ffe4 	lw	t1,-28(s8)
          slt   $t2, $t1, $t0           
  803df8:	0128502a 	slt	t2,t1,t0
          sw    $t1, -28($fp)           
  803dfc:	afc9ffe4 	sw	t1,-28(s8)
          beqz  $t2, _L233              
  803e00:	11400060 	beqz	t2,803f84 <_L233>
  803e04:	00000000 	nop

00803e08 <_L226>:
_L226:                                  
          lw    $t0, 4($fp)             
  803e08:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  803e0c:	8d090004 	lw	t1,4(t0)
          lw    $t2, -4($t1)            
  803e10:	8d2afffc 	lw	t2,-4(t1)
          lw    $t3, -28($fp)           
  803e14:	8fcbffe4 	lw	t3,-28(s8)
          slt   $t4, $t3, $t2           
  803e18:	016a602a 	slt	t4,t3,t2
          sw    $t0, 4($fp)             
  803e1c:	afc80004 	sw	t0,4(s8)
          sw    $t3, -28($fp)           
  803e20:	afcbffe4 	sw	t3,-28(s8)
          sw    $t1, -32($fp)           
  803e24:	afc9ffe0 	sw	t1,-32(s8)
          beqz  $t4, _L228              
  803e28:	11800007 	beqz	t4,803e48 <_L228>
  803e2c:	00000000 	nop

00803e30 <_L227>:
_L227:                                  
          li    $t0, 0                  
  803e30:	24080000 	li	t0,0
          lw    $t1, -28($fp)           
  803e34:	8fc9ffe4 	lw	t1,-28(s8)
          slt   $t2, $t1, $t0           
  803e38:	0128502a 	slt	t2,t1,t0
          sw    $t1, -28($fp)           
  803e3c:	afc9ffe4 	sw	t1,-28(s8)
          beqz  $t2, _L229              
  803e40:	11400009 	beqz	t2,803e68 <_L229>
  803e44:	00000000 	nop

00803e48 <_L228>:
_L228:                                  
          la    $t0, _STRING8           
  803e48:	3c080080 	lui	t0,0x80
  803e4c:	250873be 	addiu	t0,t0,29630
          move  $a0, $t0                
  803e50:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  803e54:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  803e58:	0c2001d8 	jal	800760 <_PrintString>
  803e5c:	00000000 	nop
          jal   _Halt                   
  803e60:	0c200200 	jal	800800 <_Halt>
  803e64:	00000000 	nop

00803e68 <_L229>:
_L229:                                  
          li    $t0, 4                  
  803e68:	24080004 	li	t0,4
          lw    $t1, -28($fp)           
  803e6c:	8fc9ffe4 	lw	t1,-28(s8)
          mult  $t1, $t0                
  803e70:	01280018 	mult	t1,t0
          mflo  $t2                     
  803e74:	00005012 	mflo	t2
          lw    $t0, -32($fp)           
  803e78:	8fc8ffe0 	lw	t0,-32(s8)
          addu  $t3, $t0, $t2           
  803e7c:	010a5821 	addu	t3,t0,t2
          lw    $t2, 0($t3)             
  803e80:	8d6a0000 	lw	t2,0(t3)
          sw    $t1, -28($fp)           
  803e84:	afc9ffe4 	sw	t1,-28(s8)
          sw    $t0, -32($fp)           
  803e88:	afc8ffe0 	sw	t0,-32(s8)
          jal   _Deck_New               
  803e8c:	0c200cb5 	jal	8032d4 <_Deck_New>
  803e90:	00000000 	nop
          move  $t2, $v0                
  803e94:	00405021 	move	t2,v0
          lw    $t1, -28($fp)           
  803e98:	8fc9ffe4 	lw	t1,-28(s8)
          lw    $t0, -32($fp)           
  803e9c:	8fc8ffe0 	lw	t0,-32(s8)
          li    $t3, 4                  
  803ea0:	240b0004 	li	t3,4
          mult  $t1, $t3                
  803ea4:	012b0018 	mult	t1,t3
          mflo  $t4                     
  803ea8:	00006012 	mflo	t4
          addu  $t3, $t0, $t4           
  803eac:	010c5821 	addu	t3,t0,t4
          sw    $t2, 0($t3)             
  803eb0:	ad6a0000 	sw	t2,0(t3)
          lw    $t0, 4($fp)             
  803eb4:	8fc80004 	lw	t0,4(s8)
          lw    $t2, 4($t0)             
  803eb8:	8d0a0004 	lw	t2,4(t0)
          lw    $t3, -4($t2)            
  803ebc:	8d4bfffc 	lw	t3,-4(t2)
          slt   $t4, $t1, $t3           
  803ec0:	012b602a 	slt	t4,t1,t3
          sw    $t2, -36($fp)           
  803ec4:	afcaffdc 	sw	t2,-36(s8)
          sw    $t0, 4($fp)             
  803ec8:	afc80004 	sw	t0,4(s8)
          sw    $t1, -28($fp)           
  803ecc:	afc9ffe4 	sw	t1,-28(s8)
          beqz  $t4, _L231              
  803ed0:	11800007 	beqz	t4,803ef0 <_L231>
  803ed4:	00000000 	nop

00803ed8 <_L230>:
_L230:                                  
          li    $t0, 0                  
  803ed8:	24080000 	li	t0,0
          lw    $t1, -28($fp)           
  803edc:	8fc9ffe4 	lw	t1,-28(s8)
          slt   $t2, $t1, $t0           
  803ee0:	0128502a 	slt	t2,t1,t0
          sw    $t1, -28($fp)           
  803ee4:	afc9ffe4 	sw	t1,-28(s8)
          beqz  $t2, _L232              
  803ee8:	11400009 	beqz	t2,803f10 <_L232>
  803eec:	00000000 	nop

00803ef0 <_L231>:
_L231:                                  
          la    $t0, _STRING8           
  803ef0:	3c080080 	lui	t0,0x80
  803ef4:	250873be 	addiu	t0,t0,29630
          move  $a0, $t0                
  803ef8:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  803efc:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  803f00:	0c2001d8 	jal	800760 <_PrintString>
  803f04:	00000000 	nop
          jal   _Halt                   
  803f08:	0c200200 	jal	800800 <_Halt>
  803f0c:	00000000 	nop

00803f10 <_L232>:
_L232:                                  
          li    $t0, 4                  
  803f10:	24080004 	li	t0,4
          lw    $t1, -28($fp)           
  803f14:	8fc9ffe4 	lw	t1,-28(s8)
          mult  $t1, $t0                
  803f18:	01280018 	mult	t1,t0
          mflo  $t2                     
  803f1c:	00005012 	mflo	t2
          lw    $t0, -36($fp)           
  803f20:	8fc8ffdc 	lw	t0,-36(s8)
          addu  $t3, $t0, $t2           
  803f24:	010a5821 	addu	t3,t0,t2
          lw    $t0, 0($t3)             
  803f28:	8d680000 	lw	t0,0(t3)
          move  $a0, $t0                
  803f2c:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  803f30:	afa80004 	sw	t0,4(sp)
          lw    $t2, 8($fp)             
  803f34:	8fca0008 	lw	t2,8(s8)
          move  $a1, $t2                
  803f38:	01402821 	move	a1,t2
          sw    $t2, 8($sp)             
  803f3c:	afaa0008 	sw	t2,8(sp)
          lw    $t3, 0($t0)             
  803f40:	8d0b0000 	lw	t3,0(t0)
          lw    $t0, 8($t3)             
  803f44:	8d680008 	lw	t0,8(t3)
          sw    $t2, 8($fp)             
  803f48:	afca0008 	sw	t2,8(s8)
          sw    $t1, -28($fp)           
  803f4c:	afc9ffe4 	sw	t1,-28(s8)
          jalr  $t0                     
  803f50:	0100f809 	jalr	t0
  803f54:	00000000 	nop
          lw    $t2, 8($fp)             
  803f58:	8fca0008 	lw	t2,8(s8)
          lw    $t1, -28($fp)           
  803f5c:	8fc9ffe4 	lw	t1,-28(s8)
          sw    $t2, 8($fp)             
  803f60:	afca0008 	sw	t2,8(s8)
          sw    $t1, -28($fp)           
  803f64:	afc9ffe4 	sw	t1,-28(s8)

00803f68 <_L224>:
_L224:                                  
          li    $t0, 1                  
  803f68:	24080001 	li	t0,1
          lw    $t1, -28($fp)           
  803f6c:	8fc9ffe4 	lw	t1,-28(s8)
          addu  $t2, $t1, $t0           
  803f70:	01285021 	addu	t2,t1,t0
          move  $t1, $t2                
  803f74:	01404821 	move	t1,t2
          sw    $t1, -28($fp)           
  803f78:	afc9ffe4 	sw	t1,-28(s8)
          b     _L225                   
  803f7c:	1000ff9c 	b	803df0 <_L225>
  803f80:	00000000 	nop

00803f84 <_L233>:
_L233:                                  
          lw    $t0, 4($fp)             
  803f84:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 12($t0)            
  803f88:	8d09000c 	lw	t1,12(t0)
          lw    $t1, 8($fp)             
  803f8c:	8fc90008 	lw	t1,8(s8)
          sw    $t1, 12($t0)            
  803f90:	ad09000c 	sw	t1,12(t0)
          sw    $t0, 4($fp)             
  803f94:	afc80004 	sw	t0,4(s8)
          sw    $t1, 8($fp)             
  803f98:	afc90008 	sw	t1,8(s8)
          move  $v0, $zero              
  803f9c:	00001021 	move	v0,zero
          move  $sp, $fp                
  803fa0:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  803fa4:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  803fa8:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  803fac:	03e00008 	jr	ra
  803fb0:	00000000 	nop

00803fb4 <_BJDeck.DealCard>:

_BJDeck.DealCard:                       # function entry
          sw $fp, 0($sp)                
  803fb4:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  803fb8:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  803fbc:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -32           
  803fc0:	27bdffe0 	addiu	sp,sp,-32

00803fc4 <_L234>:
_L234:                                  
          li    $t0, 0                  
  803fc4:	24080000 	li	t0,0
          move  $t1, $t0                
  803fc8:	01004821 	move	t1,t0
          lw    $t0, 4($fp)             
  803fcc:	8fc80004 	lw	t0,4(s8)
          lw    $t2, 8($t0)             
  803fd0:	8d0a0008 	lw	t2,8(t0)
          li    $t3, 8                  
  803fd4:	240b0008 	li	t3,8
          li    $t4, 52                 
  803fd8:	240c0034 	li	t4,52
          mult  $t3, $t4                
  803fdc:	016c0018 	mult	t3,t4
          mflo  $t5                     
  803fe0:	00006812 	mflo	t5
          sge   $t3, $t2, $t5           
  803fe4:	014d582a 	slt	t3,t2,t5
  803fe8:	396b0001 	xori	t3,t3,0x1
          sw    $t1, -8($fp)            
  803fec:	afc9fff8 	sw	t1,-8(s8)
          sw    $t0, 4($fp)             
  803ff0:	afc80004 	sw	t0,4(s8)
          beqz  $t3, _L236              
  803ff4:	11600008 	beqz	t3,804018 <_L236>
  803ff8:	00000000 	nop

00803ffc <_L235>:
_L235:                                  
          li    $t0, 11                 
  803ffc:	2408000b 	li	t0,11
          move  $v0, $t0                
  804000:	01001021 	move	v0,t0
          move  $sp, $fp                
  804004:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  804008:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  80400c:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  804010:	03e00008 	jr	ra
  804014:	00000000 	nop

00804018 <_L236>:
_L236:                                  
          li    $t0, 0                  
  804018:	24080000 	li	t0,0
          lw    $t1, -8($fp)            
  80401c:	8fc9fff8 	lw	t1,-8(s8)
          seq   $t2, $t1, $t0           
  804020:	01285026 	xor	t2,t1,t0
  804024:	2d4a0001 	sltiu	t2,t2,1
          sw    $t1, -8($fp)            
  804028:	afc9fff8 	sw	t1,-8(s8)
          beqz  $t2, _L241              
  80402c:	11400038 	beqz	t2,804110 <_L241>
  804030:	00000000 	nop

00804034 <_L237>:
_L237:                                  
          lw    $t0, 4($fp)             
  804034:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 12($t0)            
  804038:	8d09000c 	lw	t1,12(t0)
          li    $t2, 8                  
  80403c:	240a0008 	li	t2,8
          move  $a0, $t1                
  804040:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804044:	afa90004 	sw	t1,4(sp)
          move  $a1, $t2                
  804048:	01402821 	move	a1,t2
          sw    $t2, 8($sp)             
  80404c:	afaa0008 	sw	t2,8(sp)
          lw    $t2, 0($t1)             
  804050:	8d2a0000 	lw	t2,0(t1)
          lw    $t1, 16($t2)            
  804054:	8d490010 	lw	t1,16(t2)
          sw    $t0, 4($fp)             
  804058:	afc80004 	sw	t0,4(s8)
          jalr  $t1                     
  80405c:	0120f809 	jalr	t1
  804060:	00000000 	nop
          move  $t2, $v0                
  804064:	00405021 	move	t2,v0
          lw    $t0, 4($fp)             
  804068:	8fc80004 	lw	t0,4(s8)
          move  $t1, $t2                
  80406c:	01404821 	move	t1,t2
          lw    $t2, 4($t0)             
  804070:	8d0a0004 	lw	t2,4(t0)
          lw    $t3, -4($t2)            
  804074:	8d4bfffc 	lw	t3,-4(t2)
          slt   $t4, $t1, $t3           
  804078:	012b602a 	slt	t4,t1,t3
          sw    $t2, -16($fp)           
  80407c:	afcafff0 	sw	t2,-16(s8)
          sw    $t0, 4($fp)             
  804080:	afc80004 	sw	t0,4(s8)
          sw    $t1, -12($fp)           
  804084:	afc9fff4 	sw	t1,-12(s8)
          beqz  $t4, _L239              
  804088:	11800007 	beqz	t4,8040a8 <_L239>
  80408c:	00000000 	nop

00804090 <_L238>:
_L238:                                  
          li    $t0, 0                  
  804090:	24080000 	li	t0,0
          lw    $t1, -12($fp)           
  804094:	8fc9fff4 	lw	t1,-12(s8)
          slt   $t2, $t1, $t0           
  804098:	0128502a 	slt	t2,t1,t0
          sw    $t1, -12($fp)           
  80409c:	afc9fff4 	sw	t1,-12(s8)
          beqz  $t2, _L240              
  8040a0:	11400009 	beqz	t2,8040c8 <_L240>
  8040a4:	00000000 	nop

008040a8 <_L239>:
_L239:                                  
          la    $t0, _STRING8           
  8040a8:	3c080080 	lui	t0,0x80
  8040ac:	250873be 	addiu	t0,t0,29630
          move  $a0, $t0                
  8040b0:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  8040b4:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  8040b8:	0c2001d8 	jal	800760 <_PrintString>
  8040bc:	00000000 	nop
          jal   _Halt                   
  8040c0:	0c200200 	jal	800800 <_Halt>
  8040c4:	00000000 	nop

008040c8 <_L240>:
_L240:                                  
          li    $t0, 4                  
  8040c8:	24080004 	li	t0,4
          lw    $t1, -12($fp)           
  8040cc:	8fc9fff4 	lw	t1,-12(s8)
          mult  $t1, $t0                
  8040d0:	01280018 	mult	t1,t0
          mflo  $t2                     
  8040d4:	00005012 	mflo	t2
          lw    $t0, -16($fp)           
  8040d8:	8fc8fff0 	lw	t0,-16(s8)
          addu  $t1, $t0, $t2           
  8040dc:	010a4821 	addu	t1,t0,t2
          lw    $t0, 0($t1)             
  8040e0:	8d280000 	lw	t0,0(t1)
          move  $a0, $t0                
  8040e4:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  8040e8:	afa80004 	sw	t0,4(sp)
          lw    $t1, 0($t0)             
  8040ec:	8d090000 	lw	t1,0(t0)
          lw    $t0, 16($t1)            
  8040f0:	8d280010 	lw	t0,16(t1)
          jalr  $t0                     
  8040f4:	0100f809 	jalr	t0
  8040f8:	00000000 	nop
          move  $t1, $v0                
  8040fc:	00404821 	move	t1,v0
          move  $t0, $t1                
  804100:	01204021 	move	t0,t1
          sw    $t0, -8($fp)            
  804104:	afc8fff8 	sw	t0,-8(s8)
          b     _L236                   
  804108:	1000ffc3 	b	804018 <_L236>
  80410c:	00000000 	nop

00804110 <_L241>:
_L241:                                  
          li    $t0, 10                 
  804110:	2408000a 	li	t0,10
          lw    $t1, -8($fp)            
  804114:	8fc9fff8 	lw	t1,-8(s8)
          sgt   $t2, $t1, $t0           
  804118:	0109502a 	slt	t2,t0,t1
          sw    $t1, -8($fp)            
  80411c:	afc9fff8 	sw	t1,-8(s8)
          beqz  $t2, _L243              
  804120:	11400012 	beqz	t2,80416c <_L243>
  804124:	00000000 	nop

00804128 <_L242>:
_L242:                                  
          li    $t0, 10                 
  804128:	2408000a 	li	t0,10
          move  $t1, $t0                
  80412c:	01004821 	move	t1,t0
          sw    $t1, -8($fp)            
  804130:	afc9fff8 	sw	t1,-8(s8)

00804134 <_L245>:
_L245:                                  
          lw    $t0, 4($fp)             
  804134:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($t0)             
  804138:	8d090008 	lw	t1,8(t0)
          lw    $t1, 8($t0)             
  80413c:	8d090008 	lw	t1,8(t0)
          li    $t2, 1                  
  804140:	240a0001 	li	t2,1
          addu  $t3, $t1, $t2           
  804144:	012a5821 	addu	t3,t1,t2
          sw    $t3, 8($t0)             
  804148:	ad0b0008 	sw	t3,8(t0)
          lw    $t0, -8($fp)            
  80414c:	8fc8fff8 	lw	t0,-8(s8)
          sw    $t0, 4($fp)             
  804150:	afc80004 	sw	t0,4(s8)
          move  $v0, $t0                
  804154:	01001021 	move	v0,t0
          move  $sp, $fp                
  804158:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  80415c:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  804160:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  804164:	03e00008 	jr	ra
  804168:	00000000 	nop

0080416c <_L243>:
_L243:                                  
          li    $t0, 1                  
  80416c:	24080001 	li	t0,1
          lw    $t1, -8($fp)            
  804170:	8fc9fff8 	lw	t1,-8(s8)
          seq   $t2, $t1, $t0           
  804174:	01285026 	xor	t2,t1,t0
  804178:	2d4a0001 	sltiu	t2,t2,1
          sw    $t1, -8($fp)            
  80417c:	afc9fff8 	sw	t1,-8(s8)
          beqz  $t2, _L245              
  804180:	1140ffec 	beqz	t2,804134 <_L245>
  804184:	00000000 	nop

00804188 <_L244>:
_L244:                                  
          li    $t0, 11                 
  804188:	2408000b 	li	t0,11
          move  $t1, $t0                
  80418c:	01004821 	move	t1,t0
          sw    $t1, -8($fp)            
  804190:	afc9fff8 	sw	t1,-8(s8)
          b     _L245                   
  804194:	1000ffe7 	b	804134 <_L245>
  804198:	00000000 	nop

0080419c <_BJDeck.Shuffle>:

_BJDeck.Shuffle:                        # function entry
          sw $fp, 0($sp)                
  80419c:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  8041a0:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  8041a4:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -24           
  8041a8:	27bdffe8 	addiu	sp,sp,-24

008041ac <_L246>:
_L246:                                  
          la    $t0, _STRING9           
  8041ac:	3c080080 	lui	t0,0x80
  8041b0:	250870fc 	addiu	t0,t0,28924
          move  $a0, $t0                
  8041b4:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  8041b8:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  8041bc:	0c2001d8 	jal	800760 <_PrintString>
  8041c0:	00000000 	nop
          li    $t0, 0                  
  8041c4:	24080000 	li	t0,0
          move  $t1, $t0                
  8041c8:	01004821 	move	t1,t0
          sw    $t1, -8($fp)            
  8041cc:	afc9fff8 	sw	t1,-8(s8)

008041d0 <_L248>:
_L248:                                  
          li    $t0, 8                  
  8041d0:	24080008 	li	t0,8
          lw    $t1, -8($fp)            
  8041d4:	8fc9fff8 	lw	t1,-8(s8)
          slt   $t2, $t1, $t0           
  8041d8:	0128502a 	slt	t2,t1,t0
          sw    $t1, -8($fp)            
  8041dc:	afc9fff8 	sw	t1,-8(s8)
          beqz  $t2, _L253              
  8041e0:	11400030 	beqz	t2,8042a4 <_L253>
  8041e4:	00000000 	nop

008041e8 <_L249>:
_L249:                                  
          lw    $t0, 4($fp)             
  8041e8:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  8041ec:	8d090004 	lw	t1,4(t0)
          lw    $t2, -4($t1)            
  8041f0:	8d2afffc 	lw	t2,-4(t1)
          lw    $t3, -8($fp)            
  8041f4:	8fcbfff8 	lw	t3,-8(s8)
          slt   $t4, $t3, $t2           
  8041f8:	016a602a 	slt	t4,t3,t2
          sw    $t1, -12($fp)           
  8041fc:	afc9fff4 	sw	t1,-12(s8)
          sw    $t0, 4($fp)             
  804200:	afc80004 	sw	t0,4(s8)
          sw    $t3, -8($fp)            
  804204:	afcbfff8 	sw	t3,-8(s8)
          beqz  $t4, _L251              
  804208:	11800007 	beqz	t4,804228 <_L251>
  80420c:	00000000 	nop

00804210 <_L250>:
_L250:                                  
          li    $t0, 0                  
  804210:	24080000 	li	t0,0
          lw    $t1, -8($fp)            
  804214:	8fc9fff8 	lw	t1,-8(s8)
          slt   $t2, $t1, $t0           
  804218:	0128502a 	slt	t2,t1,t0
          sw    $t1, -8($fp)            
  80421c:	afc9fff8 	sw	t1,-8(s8)
          beqz  $t2, _L252              
  804220:	11400009 	beqz	t2,804248 <_L252>
  804224:	00000000 	nop

00804228 <_L251>:
_L251:                                  
          la    $t0, _STRING8           
  804228:	3c080080 	lui	t0,0x80
  80422c:	250873be 	addiu	t0,t0,29630
          move  $a0, $t0                
  804230:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  804234:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  804238:	0c2001d8 	jal	800760 <_PrintString>
  80423c:	00000000 	nop
          jal   _Halt                   
  804240:	0c200200 	jal	800800 <_Halt>
  804244:	00000000 	nop

00804248 <_L252>:
_L252:                                  
          li    $t0, 4                  
  804248:	24080004 	li	t0,4
          lw    $t1, -8($fp)            
  80424c:	8fc9fff8 	lw	t1,-8(s8)
          mult  $t1, $t0                
  804250:	01280018 	mult	t1,t0
          mflo  $t2                     
  804254:	00005012 	mflo	t2
          lw    $t0, -12($fp)           
  804258:	8fc8fff4 	lw	t0,-12(s8)
          addu  $t3, $t0, $t2           
  80425c:	010a5821 	addu	t3,t0,t2
          lw    $t0, 0($t3)             
  804260:	8d680000 	lw	t0,0(t3)
          move  $a0, $t0                
  804264:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  804268:	afa80004 	sw	t0,4(sp)
          lw    $t2, 0($t0)             
  80426c:	8d0a0000 	lw	t2,0(t0)
          lw    $t0, 12($t2)            
  804270:	8d48000c 	lw	t0,12(t2)
          sw    $t1, -8($fp)            
  804274:	afc9fff8 	sw	t1,-8(s8)
          jalr  $t0                     
  804278:	0100f809 	jalr	t0
  80427c:	00000000 	nop
          lw    $t1, -8($fp)            
  804280:	8fc9fff8 	lw	t1,-8(s8)
          sw    $t1, -8($fp)            
  804284:	afc9fff8 	sw	t1,-8(s8)

00804288 <_L247>:
_L247:                                  
          li    $t0, 1                  
  804288:	24080001 	li	t0,1
          lw    $t1, -8($fp)            
  80428c:	8fc9fff8 	lw	t1,-8(s8)
          addu  $t2, $t1, $t0           
  804290:	01285021 	addu	t2,t1,t0
          move  $t1, $t2                
  804294:	01404821 	move	t1,t2
          sw    $t1, -8($fp)            
  804298:	afc9fff8 	sw	t1,-8(s8)
          b     _L248                   
  80429c:	1000ffcc 	b	8041d0 <_L248>
  8042a0:	00000000 	nop

008042a4 <_L253>:
_L253:                                  
          lw    $t0, 4($fp)             
  8042a4:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($t0)             
  8042a8:	8d090008 	lw	t1,8(t0)
          li    $t1, 0                  
  8042ac:	24090000 	li	t1,0
          sw    $t1, 8($t0)             
  8042b0:	ad090008 	sw	t1,8(t0)
          la    $t1, _STRING10          
  8042b4:	3c090080 	lui	t1,0x80
  8042b8:	252972bb 	addiu	t1,t1,29371
          move  $a0, $t1                
  8042bc:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  8042c0:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  8042c4:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  8042c8:	0c2001d8 	jal	800760 <_PrintString>
  8042cc:	00000000 	nop
          lw    $t0, 4($fp)             
  8042d0:	8fc80004 	lw	t0,4(s8)
          sw    $t0, 4($fp)             
  8042d4:	afc80004 	sw	t0,4(s8)
          move  $v0, $zero              
  8042d8:	00001021 	move	v0,zero
          move  $sp, $fp                
  8042dc:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  8042e0:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  8042e4:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  8042e8:	03e00008 	jr	ra
  8042ec:	00000000 	nop

008042f0 <_BJDeck.NumCardsRemaining>:

_BJDeck.NumCardsRemaining:              # function entry
          sw $fp, 0($sp)                
  8042f0:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  8042f4:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  8042f8:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -12           
  8042fc:	27bdfff4 	addiu	sp,sp,-12

00804300 <_L254>:
_L254:                                  
          li    $t0, 8                  
  804300:	24080008 	li	t0,8
          li    $t1, 52                 
  804304:	24090034 	li	t1,52
          mult  $t0, $t1                
  804308:	01090018 	mult	t0,t1
          mflo  $t2                     
  80430c:	00005012 	mflo	t2
          lw    $t0, 4($fp)             
  804310:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($t0)             
  804314:	8d090008 	lw	t1,8(t0)
          subu  $t3, $t2, $t1           
  804318:	01495823 	subu	t3,t2,t1
          sw    $t0, 4($fp)             
  80431c:	afc80004 	sw	t0,4(s8)
          move  $v0, $t3                
  804320:	01601021 	move	v0,t3
          move  $sp, $fp                
  804324:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  804328:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  80432c:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  804330:	03e00008 	jr	ra
  804334:	00000000 	nop

00804338 <_Player.Init>:

_Player.Init:                           # function entry
          sw $fp, 0($sp)                
  804338:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  80433c:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  804340:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -16           
  804344:	27bdfff0 	addiu	sp,sp,-16

00804348 <_L255>:
_L255:                                  
          lw    $t0, 4($fp)             
  804348:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 20($t0)            
  80434c:	8d090014 	lw	t1,20(t0)
          li    $t1, 1000               
  804350:	240903e8 	li	t1,1000
          sw    $t1, 20($t0)            
  804354:	ad090014 	sw	t1,20(t0)
          la    $t1, _STRING11          
  804358:	3c090080 	lui	t1,0x80
  80435c:	25297287 	addiu	t1,t1,29319
          move  $a0, $t1                
  804360:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804364:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804368:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  80436c:	0c2001d8 	jal	800760 <_PrintString>
  804370:	00000000 	nop
          lw    $t0, 4($fp)             
  804374:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($fp)             
  804378:	8fc90008 	lw	t1,8(s8)
          move  $a0, $t1                
  80437c:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804380:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804384:	afc80004 	sw	t0,4(s8)
          sw    $t1, 8($fp)             
  804388:	afc90008 	sw	t1,8(s8)
          jal   _PrintInt               
  80438c:	0c2001b6 	jal	8006d8 <_PrintInt>
  804390:	00000000 	nop
          lw    $t0, 4($fp)             
  804394:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($fp)             
  804398:	8fc90008 	lw	t1,8(s8)
          la    $t2, _STRING12          
  80439c:	3c0a0080 	lui	t2,0x80
  8043a0:	254a7109 	addiu	t2,t2,28937
          move  $a0, $t2                
  8043a4:	01402021 	move	a0,t2
          sw    $t2, 4($sp)             
  8043a8:	afaa0004 	sw	t2,4(sp)
          sw    $t0, 4($fp)             
  8043ac:	afc80004 	sw	t0,4(s8)
          sw    $t1, 8($fp)             
  8043b0:	afc90008 	sw	t1,8(s8)
          jal   _PrintString            
  8043b4:	0c2001d8 	jal	800760 <_PrintString>
  8043b8:	00000000 	nop
          lw    $t0, 4($fp)             
  8043bc:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($fp)             
  8043c0:	8fc90008 	lw	t1,8(s8)
          lw    $t2, 24($t0)            
  8043c4:	8d0a0018 	lw	t2,24(t0)
          sw    $t0, 4($fp)             
  8043c8:	afc80004 	sw	t0,4(s8)
          sw    $t1, 8($fp)             
  8043cc:	afc90008 	sw	t1,8(s8)
          jal   _ReadLine               
  8043d0:	0c200207 	jal	80081c <_ReadLine>
  8043d4:	00000000 	nop
          move  $t2, $v0                
  8043d8:	00405021 	move	t2,v0
          lw    $t0, 4($fp)             
  8043dc:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($fp)             
  8043e0:	8fc90008 	lw	t1,8(s8)
          sw    $t2, 24($t0)            
  8043e4:	ad0a0018 	sw	t2,24(t0)
          sw    $t0, 4($fp)             
  8043e8:	afc80004 	sw	t0,4(s8)
          sw    $t1, 8($fp)             
  8043ec:	afc90008 	sw	t1,8(s8)
          move  $v0, $zero              
  8043f0:	00001021 	move	v0,zero
          move  $sp, $fp                
  8043f4:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  8043f8:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  8043fc:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  804400:	03e00008 	jr	ra
  804404:	00000000 	nop

00804408 <_Player.Hit>:

_Player.Hit:                            # function entry
          sw $fp, 0($sp)                
  804408:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  80440c:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  804410:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -20           
  804414:	27bdffec 	addiu	sp,sp,-20

00804418 <_L256>:
_L256:                                  
          lw    $t0, 8($fp)             
  804418:	8fc80008 	lw	t0,8(s8)
          move  $a0, $t0                
  80441c:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  804420:	afa80004 	sw	t0,4(sp)
          lw    $t1, 0($t0)             
  804424:	8d090000 	lw	t1,0(t0)
          lw    $t2, 12($t1)            
  804428:	8d2a000c 	lw	t2,12(t1)
          sw    $t0, 8($fp)             
  80442c:	afc80008 	sw	t0,8(s8)
          jalr  $t2                     
  804430:	0140f809 	jalr	t2
  804434:	00000000 	nop
          move  $t1, $v0                
  804438:	00404821 	move	t1,v0
          lw    $t0, 8($fp)             
  80443c:	8fc80008 	lw	t0,8(s8)
          move  $t2, $t1                
  804440:	01205021 	move	t2,t1
          lw    $t1, 4($fp)             
  804444:	8fc90004 	lw	t1,4(s8)
          lw    $t3, 24($t1)            
  804448:	8d2b0018 	lw	t3,24(t1)
          move  $a0, $t3                
  80444c:	01602021 	move	a0,t3
          sw    $t3, 4($sp)             
  804450:	afab0004 	sw	t3,4(sp)
          sw    $t1, 4($fp)             
  804454:	afc90004 	sw	t1,4(s8)
          sw    $t0, 8($fp)             
  804458:	afc80008 	sw	t0,8(s8)
          sw    $t2, -8($fp)            
  80445c:	afcafff8 	sw	t2,-8(s8)
          jal   _PrintString            
  804460:	0c2001d8 	jal	800760 <_PrintString>
  804464:	00000000 	nop
          lw    $t1, 4($fp)             
  804468:	8fc90004 	lw	t1,4(s8)
          lw    $t0, 8($fp)             
  80446c:	8fc80008 	lw	t0,8(s8)
          lw    $t2, -8($fp)            
  804470:	8fcafff8 	lw	t2,-8(s8)
          la    $t3, _STRING13          
  804474:	3c0b0080 	lui	t3,0x80
  804478:	256b7174 	addiu	t3,t3,29044
          move  $a0, $t3                
  80447c:	01602021 	move	a0,t3
          sw    $t3, 4($sp)             
  804480:	afab0004 	sw	t3,4(sp)
          sw    $t1, 4($fp)             
  804484:	afc90004 	sw	t1,4(s8)
          sw    $t0, 8($fp)             
  804488:	afc80008 	sw	t0,8(s8)
          sw    $t2, -8($fp)            
  80448c:	afcafff8 	sw	t2,-8(s8)
          jal   _PrintString            
  804490:	0c2001d8 	jal	800760 <_PrintString>
  804494:	00000000 	nop
          lw    $t1, 4($fp)             
  804498:	8fc90004 	lw	t1,4(s8)
          lw    $t0, 8($fp)             
  80449c:	8fc80008 	lw	t0,8(s8)
          lw    $t2, -8($fp)            
  8044a0:	8fcafff8 	lw	t2,-8(s8)
          move  $a0, $t2                
  8044a4:	01402021 	move	a0,t2
          sw    $t2, 4($sp)             
  8044a8:	afaa0004 	sw	t2,4(sp)
          sw    $t1, 4($fp)             
  8044ac:	afc90004 	sw	t1,4(s8)
          sw    $t0, 8($fp)             
  8044b0:	afc80008 	sw	t0,8(s8)
          sw    $t2, -8($fp)            
  8044b4:	afcafff8 	sw	t2,-8(s8)
          jal   _PrintInt               
  8044b8:	0c2001b6 	jal	8006d8 <_PrintInt>
  8044bc:	00000000 	nop
          lw    $t1, 4($fp)             
  8044c0:	8fc90004 	lw	t1,4(s8)
          lw    $t0, 8($fp)             
  8044c4:	8fc80008 	lw	t0,8(s8)
          lw    $t2, -8($fp)            
  8044c8:	8fcafff8 	lw	t2,-8(s8)
          la    $t3, _STRING14          
  8044cc:	3c0b0080 	lui	t3,0x80
  8044d0:	256b71ff 	addiu	t3,t3,29183
          move  $a0, $t3                
  8044d4:	01602021 	move	a0,t3
          sw    $t3, 4($sp)             
  8044d8:	afab0004 	sw	t3,4(sp)
          sw    $t1, 4($fp)             
  8044dc:	afc90004 	sw	t1,4(s8)
          sw    $t0, 8($fp)             
  8044e0:	afc80008 	sw	t0,8(s8)
          sw    $t2, -8($fp)            
  8044e4:	afcafff8 	sw	t2,-8(s8)
          jal   _PrintString            
  8044e8:	0c2001d8 	jal	800760 <_PrintString>
  8044ec:	00000000 	nop
          lw    $t1, 4($fp)             
  8044f0:	8fc90004 	lw	t1,4(s8)
          lw    $t0, 8($fp)             
  8044f4:	8fc80008 	lw	t0,8(s8)
          lw    $t2, -8($fp)            
  8044f8:	8fcafff8 	lw	t2,-8(s8)
          lw    $t3, 4($t1)             
  8044fc:	8d2b0004 	lw	t3,4(t1)
          lw    $t3, 4($t1)             
  804500:	8d2b0004 	lw	t3,4(t1)
          addu  $t4, $t3, $t2           
  804504:	016a6021 	addu	t4,t3,t2
          sw    $t4, 4($t1)             
  804508:	ad2c0004 	sw	t4,4(t1)
          lw    $t3, 12($t1)            
  80450c:	8d2b000c 	lw	t3,12(t1)
          lw    $t3, 12($t1)            
  804510:	8d2b000c 	lw	t3,12(t1)
          li    $t4, 1                  
  804514:	240c0001 	li	t4,1
          addu  $t5, $t3, $t4           
  804518:	016c6821 	addu	t5,t3,t4
          sw    $t5, 12($t1)            
  80451c:	ad2d000c 	sw	t5,12(t1)
          li    $t3, 11                 
  804520:	240b000b 	li	t3,11
          seq   $t4, $t2, $t3           
  804524:	014b6026 	xor	t4,t2,t3
  804528:	2d8c0001 	sltiu	t4,t4,1
          sw    $t1, 4($fp)             
  80452c:	afc90004 	sw	t1,4(s8)
          sw    $t0, 8($fp)             
  804530:	afc80008 	sw	t0,8(s8)
          beqz  $t4, _L258              
  804534:	11800008 	beqz	t4,804558 <_L258>
  804538:	00000000 	nop

0080453c <_L257>:
_L257:                                  
          lw    $t0, 4($fp)             
  80453c:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($t0)             
  804540:	8d090008 	lw	t1,8(t0)
          lw    $t1, 8($t0)             
  804544:	8d090008 	lw	t1,8(t0)
          li    $t2, 1                  
  804548:	240a0001 	li	t2,1
          addu  $t3, $t1, $t2           
  80454c:	012a5821 	addu	t3,t1,t2
          sw    $t3, 8($t0)             
  804550:	ad0b0008 	sw	t3,8(t0)
          sw    $t0, 4($fp)             
  804554:	afc80004 	sw	t0,4(s8)

00804558 <_L258>:
_L258:                                  
          lw    $t0, 4($fp)             
  804558:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  80455c:	8d090004 	lw	t1,4(t0)
          li    $t2, 21                 
  804560:	240a0015 	li	t2,21
          sgt   $t3, $t1, $t2           
  804564:	0149582a 	slt	t3,t2,t1
          lw    $t1, 8($t0)             
  804568:	8d090008 	lw	t1,8(t0)
          li    $t2, 0                  
  80456c:	240a0000 	li	t2,0
          sgt   $t4, $t1, $t2           
  804570:	0149602a 	slt	t4,t2,t1
          and   $t1, $t3, $t4           
  804574:	016c4824 	and	t1,t3,t4
          sw    $t0, 4($fp)             
  804578:	afc80004 	sw	t0,4(s8)
          beqz  $t1, _L260              
  80457c:	1120000f 	beqz	t1,8045bc <_L260>
  804580:	00000000 	nop

00804584 <_L259>:
_L259:                                  
          lw    $t0, 4($fp)             
  804584:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  804588:	8d090004 	lw	t1,4(t0)
          lw    $t1, 4($t0)             
  80458c:	8d090004 	lw	t1,4(t0)
          li    $t2, 10                 
  804590:	240a000a 	li	t2,10
          subu  $t3, $t1, $t2           
  804594:	012a5823 	subu	t3,t1,t2
          sw    $t3, 4($t0)             
  804598:	ad0b0004 	sw	t3,4(t0)
          lw    $t1, 8($t0)             
  80459c:	8d090008 	lw	t1,8(t0)
          lw    $t1, 8($t0)             
  8045a0:	8d090008 	lw	t1,8(t0)
          li    $t2, 1                  
  8045a4:	240a0001 	li	t2,1
          subu  $t3, $t1, $t2           
  8045a8:	012a5823 	subu	t3,t1,t2
          sw    $t3, 8($t0)             
  8045ac:	ad0b0008 	sw	t3,8(t0)
          sw    $t0, 4($fp)             
  8045b0:	afc80004 	sw	t0,4(s8)
          b     _L258                   
  8045b4:	1000ffe8 	b	804558 <_L258>
  8045b8:	00000000 	nop

008045bc <_L260>:
_L260:                                  
          move  $v0, $zero              
  8045bc:	00001021 	move	v0,zero
          move  $sp, $fp                
  8045c0:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  8045c4:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  8045c8:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  8045cc:	03e00008 	jr	ra
  8045d0:	00000000 	nop

008045d4 <_Player.DoubleDown>:

_Player.DoubleDown:                     # function entry
          sw $fp, 0($sp)                
  8045d4:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  8045d8:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  8045dc:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -20           
  8045e0:	27bdffec 	addiu	sp,sp,-20

008045e4 <_L261>:
_L261:                                  
          lw    $t0, 4($fp)             
  8045e4:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  8045e8:	8d090004 	lw	t1,4(t0)
          li    $t2, 10                 
  8045ec:	240a000a 	li	t2,10
          sne   $t3, $t1, $t2           
  8045f0:	012a5826 	xor	t3,t1,t2
  8045f4:	000b582b 	sltu	t3,zero,t3
          lw    $t1, 4($t0)             
  8045f8:	8d090004 	lw	t1,4(t0)
          li    $t2, 11                 
  8045fc:	240a000b 	li	t2,11
          sne   $t4, $t1, $t2           
  804600:	012a6026 	xor	t4,t1,t2
  804604:	000c602b 	sltu	t4,zero,t4
          and   $t1, $t3, $t4           
  804608:	016c4824 	and	t1,t3,t4
          sw    $t0, 4($fp)             
  80460c:	afc80004 	sw	t0,4(s8)
          beqz  $t1, _L263              
  804610:	11200008 	beqz	t1,804634 <_L263>
  804614:	00000000 	nop

00804618 <_L262>:
_L262:                                  
          li    $t0, 0                  
  804618:	24080000 	li	t0,0
          move  $v0, $t0                
  80461c:	01001021 	move	v0,t0
          move  $sp, $fp                
  804620:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  804624:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  804628:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  80462c:	03e00008 	jr	ra
  804630:	00000000 	nop

00804634 <_L263>:
_L263:                                  
          la    $t0, _STRING15          
  804634:	3c080080 	lui	t0,0x80
  804638:	250872fd 	addiu	t0,t0,29437
          lw    $t1, 4($fp)             
  80463c:	8fc90004 	lw	t1,4(s8)
          move  $a0, $t1                
  804640:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804644:	afa90004 	sw	t1,4(sp)
          move  $a1, $t0                
  804648:	01002821 	move	a1,t0
          sw    $t0, 8($sp)             
  80464c:	afa80008 	sw	t0,8(sp)
          lw    $t0, 0($t1)             
  804650:	8d280000 	lw	t0,0(t1)
          lw    $t2, 44($t0)            
  804654:	8d0a002c 	lw	t2,44(t0)
          sw    $t1, 4($fp)             
  804658:	afc90004 	sw	t1,4(s8)
          jalr  $t2                     
  80465c:	0140f809 	jalr	t2
  804660:	00000000 	nop
          move  $t0, $v0                
  804664:	00404021 	move	t0,v0
          lw    $t1, 4($fp)             
  804668:	8fc90004 	lw	t1,4(s8)
          sw    $t1, 4($fp)             
  80466c:	afc90004 	sw	t1,4(s8)
          beqz  $t0, _L265              
  804670:	11000044 	beqz	t0,804784 <_L265>
  804674:	00000000 	nop

00804678 <_L264>:
_L264:                                  
          lw    $t0, 4($fp)             
  804678:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 16($t0)            
  80467c:	8d090010 	lw	t1,16(t0)
          lw    $t1, 16($t0)            
  804680:	8d090010 	lw	t1,16(t0)
          li    $t2, 2                  
  804684:	240a0002 	li	t2,2
          mult  $t1, $t2                
  804688:	012a0018 	mult	t1,t2
          mflo  $t3                     
  80468c:	00005812 	mflo	t3
          sw    $t3, 16($t0)            
  804690:	ad0b0010 	sw	t3,16(t0)
          move  $a0, $t0                
  804694:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  804698:	afa80004 	sw	t0,4(sp)
          lw    $t1, 8($fp)             
  80469c:	8fc90008 	lw	t1,8(s8)
          move  $a1, $t1                
  8046a0:	01202821 	move	a1,t1
          sw    $t1, 8($sp)             
  8046a4:	afa90008 	sw	t1,8(sp)
          lw    $t2, 0($t0)             
  8046a8:	8d0a0000 	lw	t2,0(t0)
          lw    $t3, 12($t2)            
  8046ac:	8d4b000c 	lw	t3,12(t2)
          sw    $t0, 4($fp)             
  8046b0:	afc80004 	sw	t0,4(s8)
          sw    $t1, 8($fp)             
  8046b4:	afc90008 	sw	t1,8(s8)
          jalr  $t3                     
  8046b8:	0160f809 	jalr	t3
  8046bc:	00000000 	nop
          lw    $t0, 4($fp)             
  8046c0:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($fp)             
  8046c4:	8fc90008 	lw	t1,8(s8)
          lw    $t2, 24($t0)            
  8046c8:	8d0a0018 	lw	t2,24(t0)
          move  $a0, $t2                
  8046cc:	01402021 	move	a0,t2
          sw    $t2, 4($sp)             
  8046d0:	afaa0004 	sw	t2,4(sp)
          sw    $t0, 4($fp)             
  8046d4:	afc80004 	sw	t0,4(s8)
          sw    $t1, 8($fp)             
  8046d8:	afc90008 	sw	t1,8(s8)
          jal   _PrintString            
  8046dc:	0c2001d8 	jal	800760 <_PrintString>
  8046e0:	00000000 	nop
          lw    $t0, 4($fp)             
  8046e4:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($fp)             
  8046e8:	8fc90008 	lw	t1,8(s8)
          la    $t2, _STRING16          
  8046ec:	3c0a0080 	lui	t2,0x80
  8046f0:	254a7366 	addiu	t2,t2,29542
          move  $a0, $t2                
  8046f4:	01402021 	move	a0,t2
          sw    $t2, 4($sp)             
  8046f8:	afaa0004 	sw	t2,4(sp)
          sw    $t0, 4($fp)             
  8046fc:	afc80004 	sw	t0,4(s8)
          sw    $t1, 8($fp)             
  804700:	afc90008 	sw	t1,8(s8)
          jal   _PrintString            
  804704:	0c2001d8 	jal	800760 <_PrintString>
  804708:	00000000 	nop
          lw    $t0, 4($fp)             
  80470c:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($fp)             
  804710:	8fc90008 	lw	t1,8(s8)
          lw    $t2, 4($t0)             
  804714:	8d0a0004 	lw	t2,4(t0)
          move  $a0, $t2                
  804718:	01402021 	move	a0,t2
          sw    $t2, 4($sp)             
  80471c:	afaa0004 	sw	t2,4(sp)
          sw    $t0, 4($fp)             
  804720:	afc80004 	sw	t0,4(s8)
          sw    $t1, 8($fp)             
  804724:	afc90008 	sw	t1,8(s8)
          jal   _PrintInt               
  804728:	0c2001b6 	jal	8006d8 <_PrintInt>
  80472c:	00000000 	nop
          lw    $t0, 4($fp)             
  804730:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($fp)             
  804734:	8fc90008 	lw	t1,8(s8)
          la    $t2, _STRING14          
  804738:	3c0a0080 	lui	t2,0x80
  80473c:	254a71ff 	addiu	t2,t2,29183
          move  $a0, $t2                
  804740:	01402021 	move	a0,t2
          sw    $t2, 4($sp)             
  804744:	afaa0004 	sw	t2,4(sp)
          sw    $t0, 4($fp)             
  804748:	afc80004 	sw	t0,4(s8)
          sw    $t1, 8($fp)             
  80474c:	afc90008 	sw	t1,8(s8)
          jal   _PrintString            
  804750:	0c2001d8 	jal	800760 <_PrintString>
  804754:	00000000 	nop
          lw    $t0, 4($fp)             
  804758:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($fp)             
  80475c:	8fc90008 	lw	t1,8(s8)
          li    $t2, 1                  
  804760:	240a0001 	li	t2,1
          sw    $t0, 4($fp)             
  804764:	afc80004 	sw	t0,4(s8)
          sw    $t1, 8($fp)             
  804768:	afc90008 	sw	t1,8(s8)
          move  $v0, $t2                
  80476c:	01401021 	move	v0,t2
          move  $sp, $fp                
  804770:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  804774:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  804778:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  80477c:	03e00008 	jr	ra
  804780:	00000000 	nop

00804784 <_L265>:
_L265:                                  
          li    $t0, 0                  
  804784:	24080000 	li	t0,0
          move  $v0, $t0                
  804788:	01001021 	move	v0,t0
          move  $sp, $fp                
  80478c:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  804790:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  804794:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  804798:	03e00008 	jr	ra
  80479c:	00000000 	nop

008047a0 <_Player.TakeTurn>:

_Player.TakeTurn:                       # function entry
          sw $fp, 0($sp)                
  8047a0:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  8047a4:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  8047a8:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -24           
  8047ac:	27bdffe8 	addiu	sp,sp,-24

008047b0 <_L267>:
_L267:                                  
          la    $t0, _STRING17          
  8047b0:	3c080080 	lui	t0,0x80
  8047b4:	25087161 	addiu	t0,t0,29025
          move  $a0, $t0                
  8047b8:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  8047bc:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  8047c0:	0c2001d8 	jal	800760 <_PrintString>
  8047c4:	00000000 	nop
          lw    $t0, 4($fp)             
  8047c8:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 24($t0)            
  8047cc:	8d090018 	lw	t1,24(t0)
          move  $a0, $t1                
  8047d0:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  8047d4:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  8047d8:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  8047dc:	0c2001d8 	jal	800760 <_PrintString>
  8047e0:	00000000 	nop
          lw    $t0, 4($fp)             
  8047e4:	8fc80004 	lw	t0,4(s8)
          la    $t1, _STRING18          
  8047e8:	3c090080 	lui	t1,0x80
  8047ec:	25297398 	addiu	t1,t1,29592
          move  $a0, $t1                
  8047f0:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  8047f4:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  8047f8:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  8047fc:	0c2001d8 	jal	800760 <_PrintString>
  804800:	00000000 	nop
          lw    $t0, 4($fp)             
  804804:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  804808:	8d090004 	lw	t1,4(t0)
          li    $t1, 0                  
  80480c:	24090000 	li	t1,0
          sw    $t1, 4($t0)             
  804810:	ad090004 	sw	t1,4(t0)
          lw    $t1, 8($t0)             
  804814:	8d090008 	lw	t1,8(t0)
          li    $t1, 0                  
  804818:	24090000 	li	t1,0
          sw    $t1, 8($t0)             
  80481c:	ad090008 	sw	t1,8(t0)
          lw    $t1, 12($t0)            
  804820:	8d09000c 	lw	t1,12(t0)
          li    $t1, 0                  
  804824:	24090000 	li	t1,0
          sw    $t1, 12($t0)            
  804828:	ad09000c 	sw	t1,12(t0)
          move  $a0, $t0                
  80482c:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  804830:	afa80004 	sw	t0,4(sp)
          lw    $t1, 8($fp)             
  804834:	8fc90008 	lw	t1,8(s8)
          move  $a1, $t1                
  804838:	01202821 	move	a1,t1
          sw    $t1, 8($sp)             
  80483c:	afa90008 	sw	t1,8(sp)
          lw    $t2, 0($t0)             
  804840:	8d0a0000 	lw	t2,0(t0)
          lw    $t3, 12($t2)            
  804844:	8d4b000c 	lw	t3,12(t2)
          sw    $t0, 4($fp)             
  804848:	afc80004 	sw	t0,4(s8)
          sw    $t1, 8($fp)             
  80484c:	afc90008 	sw	t1,8(s8)
          jalr  $t3                     
  804850:	0160f809 	jalr	t3
  804854:	00000000 	nop
          lw    $t0, 4($fp)             
  804858:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($fp)             
  80485c:	8fc90008 	lw	t1,8(s8)
          move  $a0, $t0                
  804860:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  804864:	afa80004 	sw	t0,4(sp)
          move  $a1, $t1                
  804868:	01202821 	move	a1,t1
          sw    $t1, 8($sp)             
  80486c:	afa90008 	sw	t1,8(sp)
          lw    $t2, 0($t0)             
  804870:	8d0a0000 	lw	t2,0(t0)
          lw    $t3, 12($t2)            
  804874:	8d4b000c 	lw	t3,12(t2)
          sw    $t0, 4($fp)             
  804878:	afc80004 	sw	t0,4(s8)
          sw    $t1, 8($fp)             
  80487c:	afc90008 	sw	t1,8(s8)
          jalr  $t3                     
  804880:	0160f809 	jalr	t3
  804884:	00000000 	nop
          lw    $t0, 4($fp)             
  804888:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($fp)             
  80488c:	8fc90008 	lw	t1,8(s8)
          move  $a0, $t0                
  804890:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  804894:	afa80004 	sw	t0,4(sp)
          move  $a1, $t1                
  804898:	01202821 	move	a1,t1
          sw    $t1, 8($sp)             
  80489c:	afa90008 	sw	t1,8(sp)
          lw    $t2, 0($t0)             
  8048a0:	8d0a0000 	lw	t2,0(t0)
          lw    $t3, 16($t2)            
  8048a4:	8d4b0010 	lw	t3,16(t2)
          sw    $t0, 4($fp)             
  8048a8:	afc80004 	sw	t0,4(s8)
          sw    $t1, 8($fp)             
  8048ac:	afc90008 	sw	t1,8(s8)
          jalr  $t3                     
  8048b0:	0160f809 	jalr	t3
  8048b4:	00000000 	nop
          move  $t2, $v0                
  8048b8:	00405021 	move	t2,v0
          lw    $t0, 4($fp)             
  8048bc:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($fp)             
  8048c0:	8fc90008 	lw	t1,8(s8)
          not   $t3, $t2                
  8048c4:	01405827 	nor	t3,t2,zero
          sw    $t0, 4($fp)             
  8048c8:	afc80004 	sw	t0,4(s8)
          sw    $t1, 8($fp)             
  8048cc:	afc90008 	sw	t1,8(s8)
          beqz  $t3, _L272              
  8048d0:	11600051 	beqz	t3,804a18 <_L272>
  8048d4:	00000000 	nop

008048d8 <_L268>:
_L268:                                  
          li    $t0, 1                  
  8048d8:	24080001 	li	t0,1
          move  $t1, $t0                
  8048dc:	01004821 	move	t1,t0
          sw    $t1, -8($fp)            
  8048e0:	afc9fff8 	sw	t1,-8(s8)

008048e4 <_L269>:
_L269:                                  
          lw    $t0, 4($fp)             
  8048e4:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  8048e8:	8d090004 	lw	t1,4(t0)
          li    $t2, 21                 
  8048ec:	240a0015 	li	t2,21
          sle   $t3, $t1, $t2           
  8048f0:	0149582a 	slt	t3,t2,t1
  8048f4:	396b0001 	xori	t3,t3,0x1
          lw    $t1, -8($fp)            
  8048f8:	8fc9fff8 	lw	t1,-8(s8)
          and   $t2, $t3, $t1           
  8048fc:	01695024 	and	t2,t3,t1
          sw    $t0, 4($fp)             
  804900:	afc80004 	sw	t0,4(s8)
          beqz  $t2, _L272              
  804904:	11400044 	beqz	t2,804a18 <_L272>
  804908:	00000000 	nop

0080490c <_L270>:
_L270:                                  
          lw    $t0, 4($fp)             
  80490c:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 24($t0)            
  804910:	8d090018 	lw	t1,24(t0)
          move  $a0, $t1                
  804914:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804918:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  80491c:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  804920:	0c2001d8 	jal	800760 <_PrintString>
  804924:	00000000 	nop
          lw    $t0, 4($fp)             
  804928:	8fc80004 	lw	t0,4(s8)
          la    $t1, _STRING16          
  80492c:	3c090080 	lui	t1,0x80
  804930:	25297366 	addiu	t1,t1,29542
          move  $a0, $t1                
  804934:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804938:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  80493c:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  804940:	0c2001d8 	jal	800760 <_PrintString>
  804944:	00000000 	nop
          lw    $t0, 4($fp)             
  804948:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  80494c:	8d090004 	lw	t1,4(t0)
          move  $a0, $t1                
  804950:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804954:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804958:	afc80004 	sw	t0,4(s8)
          jal   _PrintInt               
  80495c:	0c2001b6 	jal	8006d8 <_PrintInt>
  804960:	00000000 	nop
          lw    $t0, 4($fp)             
  804964:	8fc80004 	lw	t0,4(s8)
          la    $t1, _STRING14          
  804968:	3c090080 	lui	t1,0x80
  80496c:	252971ff 	addiu	t1,t1,29183
          move  $a0, $t1                
  804970:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804974:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804978:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  80497c:	0c2001d8 	jal	800760 <_PrintString>
  804980:	00000000 	nop
          lw    $t0, 4($fp)             
  804984:	8fc80004 	lw	t0,4(s8)
          la    $t1, _STRING19          
  804988:	3c090080 	lui	t1,0x80
  80498c:	25297113 	addiu	t1,t1,28947
          move  $a0, $t0                
  804990:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  804994:	afa80004 	sw	t0,4(sp)
          move  $a1, $t1                
  804998:	01202821 	move	a1,t1
          sw    $t1, 8($sp)             
  80499c:	afa90008 	sw	t1,8(sp)
          lw    $t1, 0($t0)             
  8049a0:	8d090000 	lw	t1,0(t0)
          lw    $t2, 44($t1)            
  8049a4:	8d2a002c 	lw	t2,44(t1)
          sw    $t0, 4($fp)             
  8049a8:	afc80004 	sw	t0,4(s8)
          jalr  $t2                     
  8049ac:	0140f809 	jalr	t2
  8049b0:	00000000 	nop
          move  $t1, $v0                
  8049b4:	00404821 	move	t1,v0
          lw    $t0, 4($fp)             
  8049b8:	8fc80004 	lw	t0,4(s8)
          move  $t2, $t1                
  8049bc:	01205021 	move	t2,t1
          sw    $t0, 4($fp)             
  8049c0:	afc80004 	sw	t0,4(s8)
          sw    $t2, -8($fp)            
  8049c4:	afcafff8 	sw	t2,-8(s8)
          beqz  $t2, _L269              
  8049c8:	1140ffc6 	beqz	t2,8048e4 <_L269>
  8049cc:	00000000 	nop

008049d0 <_L271>:
_L271:                                  
          lw    $t0, 4($fp)             
  8049d0:	8fc80004 	lw	t0,4(s8)
          move  $a0, $t0                
  8049d4:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  8049d8:	afa80004 	sw	t0,4(sp)
          lw    $t1, 8($fp)             
  8049dc:	8fc90008 	lw	t1,8(s8)
          move  $a1, $t1                
  8049e0:	01202821 	move	a1,t1
          sw    $t1, 8($sp)             
  8049e4:	afa90008 	sw	t1,8(sp)
          lw    $t2, 0($t0)             
  8049e8:	8d0a0000 	lw	t2,0(t0)
          lw    $t3, 12($t2)            
  8049ec:	8d4b000c 	lw	t3,12(t2)
          sw    $t0, 4($fp)             
  8049f0:	afc80004 	sw	t0,4(s8)
          sw    $t1, 8($fp)             
  8049f4:	afc90008 	sw	t1,8(s8)
          jalr  $t3                     
  8049f8:	0160f809 	jalr	t3
  8049fc:	00000000 	nop
          lw    $t0, 4($fp)             
  804a00:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($fp)             
  804a04:	8fc90008 	lw	t1,8(s8)
          sw    $t0, 4($fp)             
  804a08:	afc80004 	sw	t0,4(s8)
          sw    $t1, 8($fp)             
  804a0c:	afc90008 	sw	t1,8(s8)
          b     _L269                   
  804a10:	1000ffb4 	b	8048e4 <_L269>
  804a14:	00000000 	nop

00804a18 <_L272>:
_L272:                                  
          lw    $t0, 4($fp)             
  804a18:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  804a1c:	8d090004 	lw	t1,4(t0)
          li    $t2, 21                 
  804a20:	240a0015 	li	t2,21
          sgt   $t3, $t1, $t2           
  804a24:	0149582a 	slt	t3,t2,t1
          sw    $t0, 4($fp)             
  804a28:	afc80004 	sw	t0,4(s8)
          beqz  $t3, _L274              
  804a2c:	11600027 	beqz	t3,804acc <_L274>
  804a30:	00000000 	nop

00804a34 <_L273>:
_L273:                                  
          lw    $t0, 4($fp)             
  804a34:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 24($t0)            
  804a38:	8d090018 	lw	t1,24(t0)
          move  $a0, $t1                
  804a3c:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804a40:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804a44:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  804a48:	0c2001d8 	jal	800760 <_PrintString>
  804a4c:	00000000 	nop
          lw    $t0, 4($fp)             
  804a50:	8fc80004 	lw	t0,4(s8)
          la    $t1, _STRING20          
  804a54:	3c090080 	lui	t1,0x80
  804a58:	252973a2 	addiu	t1,t1,29602
          move  $a0, $t1                
  804a5c:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804a60:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804a64:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  804a68:	0c2001d8 	jal	800760 <_PrintString>
  804a6c:	00000000 	nop
          lw    $t0, 4($fp)             
  804a70:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  804a74:	8d090004 	lw	t1,4(t0)
          move  $a0, $t1                
  804a78:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804a7c:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804a80:	afc80004 	sw	t0,4(s8)
          jal   _PrintInt               
  804a84:	0c2001b6 	jal	8006d8 <_PrintInt>
  804a88:	00000000 	nop
          lw    $t0, 4($fp)             
  804a8c:	8fc80004 	lw	t0,4(s8)
          la    $t1, _STRING21          
  804a90:	3c090080 	lui	t1,0x80
  804a94:	25297134 	addiu	t1,t1,28980
          move  $a0, $t1                
  804a98:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804a9c:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804aa0:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  804aa4:	0c2001d8 	jal	800760 <_PrintString>
  804aa8:	00000000 	nop
          lw    $t0, 4($fp)             
  804aac:	8fc80004 	lw	t0,4(s8)
          sw    $t0, 4($fp)             
  804ab0:	afc80004 	sw	t0,4(s8)

00804ab4 <_L275>:
_L275:                                  
          move  $v0, $zero              
  804ab4:	00001021 	move	v0,zero
          move  $sp, $fp                
  804ab8:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  804abc:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  804ac0:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  804ac4:	03e00008 	jr	ra
  804ac8:	00000000 	nop

00804acc <_L274>:
_L274:                                  
          lw    $t0, 4($fp)             
  804acc:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 24($t0)            
  804ad0:	8d090018 	lw	t1,24(t0)
          move  $a0, $t1                
  804ad4:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804ad8:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804adc:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  804ae0:	0c2001d8 	jal	800760 <_PrintString>
  804ae4:	00000000 	nop
          lw    $t0, 4($fp)             
  804ae8:	8fc80004 	lw	t0,4(s8)
          la    $t1, _STRING22          
  804aec:	3c090080 	lui	t1,0x80
  804af0:	25297129 	addiu	t1,t1,28969
          move  $a0, $t1                
  804af4:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804af8:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804afc:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  804b00:	0c2001d8 	jal	800760 <_PrintString>
  804b04:	00000000 	nop
          lw    $t0, 4($fp)             
  804b08:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  804b0c:	8d090004 	lw	t1,4(t0)
          move  $a0, $t1                
  804b10:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804b14:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804b18:	afc80004 	sw	t0,4(s8)
          jal   _PrintInt               
  804b1c:	0c2001b6 	jal	8006d8 <_PrintInt>
  804b20:	00000000 	nop
          lw    $t0, 4($fp)             
  804b24:	8fc80004 	lw	t0,4(s8)
          la    $t1, _STRING14          
  804b28:	3c090080 	lui	t1,0x80
  804b2c:	252971ff 	addiu	t1,t1,29183
          move  $a0, $t1                
  804b30:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804b34:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804b38:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  804b3c:	0c2001d8 	jal	800760 <_PrintString>
  804b40:	00000000 	nop
          lw    $t0, 4($fp)             
  804b44:	8fc80004 	lw	t0,4(s8)
          sw    $t0, 4($fp)             
  804b48:	afc80004 	sw	t0,4(s8)
          b     _L275                   
  804b4c:	1000ffd9 	b	804ab4 <_L275>
  804b50:	00000000 	nop

00804b54 <_Player.HasMoney>:

_Player.HasMoney:                       # function entry
          sw $fp, 0($sp)                
  804b54:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  804b58:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  804b5c:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -12           
  804b60:	27bdfff4 	addiu	sp,sp,-12

00804b64 <_L276>:
_L276:                                  
          lw    $t0, 4($fp)             
  804b64:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 20($t0)            
  804b68:	8d090014 	lw	t1,20(t0)
          li    $t2, 0                  
  804b6c:	240a0000 	li	t2,0
          sgt   $t3, $t1, $t2           
  804b70:	0149582a 	slt	t3,t2,t1
          sw    $t0, 4($fp)             
  804b74:	afc80004 	sw	t0,4(s8)
          move  $v0, $t3                
  804b78:	01601021 	move	v0,t3
          move  $sp, $fp                
  804b7c:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  804b80:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  804b84:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  804b88:	03e00008 	jr	ra
  804b8c:	00000000 	nop

00804b90 <_Player.PrintMoney>:

_Player.PrintMoney:                     # function entry
          sw $fp, 0($sp)                
  804b90:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  804b94:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  804b98:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -16           
  804b9c:	27bdfff0 	addiu	sp,sp,-16

00804ba0 <_L277>:
_L277:                                  
          lw    $t0, 4($fp)             
  804ba0:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 24($t0)            
  804ba4:	8d090018 	lw	t1,24(t0)
          move  $a0, $t1                
  804ba8:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804bac:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804bb0:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  804bb4:	0c2001d8 	jal	800760 <_PrintString>
  804bb8:	00000000 	nop
          lw    $t0, 4($fp)             
  804bbc:	8fc80004 	lw	t0,4(s8)
          la    $t1, _STRING23          
  804bc0:	3c090080 	lui	t1,0x80
  804bc4:	25297377 	addiu	t1,t1,29559
          move  $a0, $t1                
  804bc8:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804bcc:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804bd0:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  804bd4:	0c2001d8 	jal	800760 <_PrintString>
  804bd8:	00000000 	nop
          lw    $t0, 4($fp)             
  804bdc:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 20($t0)            
  804be0:	8d090014 	lw	t1,20(t0)
          move  $a0, $t1                
  804be4:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804be8:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804bec:	afc80004 	sw	t0,4(s8)
          jal   _PrintInt               
  804bf0:	0c2001b6 	jal	8006d8 <_PrintInt>
  804bf4:	00000000 	nop
          lw    $t0, 4($fp)             
  804bf8:	8fc80004 	lw	t0,4(s8)
          la    $t1, _STRING14          
  804bfc:	3c090080 	lui	t1,0x80
  804c00:	252971ff 	addiu	t1,t1,29183
          move  $a0, $t1                
  804c04:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804c08:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804c0c:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  804c10:	0c2001d8 	jal	800760 <_PrintString>
  804c14:	00000000 	nop
          lw    $t0, 4($fp)             
  804c18:	8fc80004 	lw	t0,4(s8)
          sw    $t0, 4($fp)             
  804c1c:	afc80004 	sw	t0,4(s8)
          move  $v0, $zero              
  804c20:	00001021 	move	v0,zero
          move  $sp, $fp                
  804c24:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  804c28:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  804c2c:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  804c30:	03e00008 	jr	ra
  804c34:	00000000 	nop

00804c38 <_Player.PlaceBet>:

_Player.PlaceBet:                       # function entry
          sw $fp, 0($sp)                
  804c38:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  804c3c:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  804c40:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -16           
  804c44:	27bdfff0 	addiu	sp,sp,-16

00804c48 <_L278>:
_L278:                                  
          lw    $t0, 4($fp)             
  804c48:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 16($t0)            
  804c4c:	8d090010 	lw	t1,16(t0)
          li    $t1, 0                  
  804c50:	24090000 	li	t1,0
          sw    $t1, 16($t0)            
  804c54:	ad090010 	sw	t1,16(t0)
          move  $a0, $t0                
  804c58:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  804c5c:	afa80004 	sw	t0,4(sp)
          lw    $t1, 0($t0)             
  804c60:	8d090000 	lw	t1,0(t0)
          lw    $t2, 28($t1)            
  804c64:	8d2a001c 	lw	t2,28(t1)
          sw    $t0, 4($fp)             
  804c68:	afc80004 	sw	t0,4(s8)
          jalr  $t2                     
  804c6c:	0140f809 	jalr	t2
  804c70:	00000000 	nop
          lw    $t0, 4($fp)             
  804c74:	8fc80004 	lw	t0,4(s8)
          sw    $t0, 4($fp)             
  804c78:	afc80004 	sw	t0,4(s8)

00804c7c <_L279>:
_L279:                                  
          lw    $t0, 4($fp)             
  804c7c:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 16($t0)            
  804c80:	8d090010 	lw	t1,16(t0)
          li    $t2, 0                  
  804c84:	240a0000 	li	t2,0
          sle   $t3, $t1, $t2           
  804c88:	0149582a 	slt	t3,t2,t1
  804c8c:	396b0001 	xori	t3,t3,0x1
          lw    $t1, 16($t0)            
  804c90:	8d090010 	lw	t1,16(t0)
          lw    $t2, 20($t0)            
  804c94:	8d0a0014 	lw	t2,20(t0)
          sgt   $t4, $t1, $t2           
  804c98:	0149602a 	slt	t4,t2,t1
          or    $t1, $t3, $t4           
  804c9c:	016c4825 	or	t1,t3,t4
          sw    $t0, 4($fp)             
  804ca0:	afc80004 	sw	t0,4(s8)
          beqz  $t1, _L281              
  804ca4:	11200012 	beqz	t1,804cf0 <_L281>
  804ca8:	00000000 	nop

00804cac <_L280>:
_L280:                                  
          la    $t0, _STRING24          
  804cac:	3c080080 	lui	t0,0x80
  804cb0:	25087242 	addiu	t0,t0,29250
          move  $a0, $t0                
  804cb4:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  804cb8:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  804cbc:	0c2001d8 	jal	800760 <_PrintString>
  804cc0:	00000000 	nop
          lw    $t0, 4($fp)             
  804cc4:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 16($t0)            
  804cc8:	8d090010 	lw	t1,16(t0)
          sw    $t0, 4($fp)             
  804ccc:	afc80004 	sw	t0,4(s8)
          jal   _ReadInteger            
  804cd0:	0c20023f 	jal	8008fc <_ReadInteger>
  804cd4:	00000000 	nop
          move  $t1, $v0                
  804cd8:	00404821 	move	t1,v0
          lw    $t0, 4($fp)             
  804cdc:	8fc80004 	lw	t0,4(s8)
          sw    $t1, 16($t0)            
  804ce0:	ad090010 	sw	t1,16(t0)
          sw    $t0, 4($fp)             
  804ce4:	afc80004 	sw	t0,4(s8)
          b     _L279                   
  804ce8:	1000ffe4 	b	804c7c <_L279>
  804cec:	00000000 	nop

00804cf0 <_L281>:
_L281:                                  
          move  $v0, $zero              
  804cf0:	00001021 	move	v0,zero
          move  $sp, $fp                
  804cf4:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  804cf8:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  804cfc:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  804d00:	03e00008 	jr	ra
  804d04:	00000000 	nop

00804d08 <_Player.GetTotal>:

_Player.GetTotal:                       # function entry
          sw $fp, 0($sp)                
  804d08:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  804d0c:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  804d10:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -12           
  804d14:	27bdfff4 	addiu	sp,sp,-12

00804d18 <_L282>:
_L282:                                  
          lw    $t0, 4($fp)             
  804d18:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  804d1c:	8d090004 	lw	t1,4(t0)
          sw    $t0, 4($fp)             
  804d20:	afc80004 	sw	t0,4(s8)
          move  $v0, $t1                
  804d24:	01201021 	move	v0,t1
          move  $sp, $fp                
  804d28:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  804d2c:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  804d30:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  804d34:	03e00008 	jr	ra
  804d38:	00000000 	nop

00804d3c <_Player.Resolve>:

_Player.Resolve:                        # function entry
          sw $fp, 0($sp)                
  804d3c:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  804d40:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  804d44:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -24           
  804d48:	27bdffe8 	addiu	sp,sp,-24

00804d4c <_L283>:
_L283:                                  
          li    $t0, 0                  
  804d4c:	24080000 	li	t0,0
          move  $t1, $t0                
  804d50:	01004821 	move	t1,t0
          li    $t0, 0                  
  804d54:	24080000 	li	t0,0
          move  $t2, $t0                
  804d58:	01005021 	move	t2,t0
          lw    $t0, 4($fp)             
  804d5c:	8fc80004 	lw	t0,4(s8)
          lw    $t3, 4($t0)             
  804d60:	8d0b0004 	lw	t3,4(t0)
          li    $t4, 21                 
  804d64:	240c0015 	li	t4,21
          seq   $t5, $t3, $t4           
  804d68:	016c6826 	xor	t5,t3,t4
  804d6c:	2dad0001 	sltiu	t5,t5,1
          lw    $t3, 12($t0)            
  804d70:	8d0b000c 	lw	t3,12(t0)
          li    $t4, 2                  
  804d74:	240c0002 	li	t4,2
          seq   $t6, $t3, $t4           
  804d78:	016c7026 	xor	t6,t3,t4
  804d7c:	2dce0001 	sltiu	t6,t6,1
          and   $t3, $t5, $t6           
  804d80:	01ae5824 	and	t3,t5,t6
          sw    $t0, 4($fp)             
  804d84:	afc80004 	sw	t0,4(s8)
          sw    $t1, -8($fp)            
  804d88:	afc9fff8 	sw	t1,-8(s8)
          sw    $t2, -12($fp)           
  804d8c:	afcafff4 	sw	t2,-12(s8)
          beqz  $t3, _L285              
  804d90:	1160007e 	beqz	t3,804f8c <_L285>
  804d94:	00000000 	nop

00804d98 <_L284>:
_L284:                                  
          li    $t0, 2                  
  804d98:	24080002 	li	t0,2
          move  $t1, $t0                
  804d9c:	01004821 	move	t1,t0
          sw    $t1, -8($fp)            
  804da0:	afc9fff8 	sw	t1,-8(s8)

00804da4 <_L293>:
_L293:                                  
          li    $t0, 1                  
  804da4:	24080001 	li	t0,1
          lw    $t1, -8($fp)            
  804da8:	8fc9fff8 	lw	t1,-8(s8)
          sge   $t2, $t1, $t0           
  804dac:	0128502a 	slt	t2,t1,t0
  804db0:	394a0001 	xori	t2,t2,0x1
          sw    $t1, -8($fp)            
  804db4:	afc9fff8 	sw	t1,-8(s8)
          beqz  $t2, _L295              
  804db8:	11400038 	beqz	t2,804e9c <_L295>
  804dbc:	00000000 	nop

00804dc0 <_L294>:
_L294:                                  
          lw    $t0, 4($fp)             
  804dc0:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 24($t0)            
  804dc4:	8d090018 	lw	t1,24(t0)
          move  $a0, $t1                
  804dc8:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804dcc:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804dd0:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  804dd4:	0c2001d8 	jal	800760 <_PrintString>
  804dd8:	00000000 	nop
          lw    $t0, 4($fp)             
  804ddc:	8fc80004 	lw	t0,4(s8)
          la    $t1, _STRING25          
  804de0:	3c090080 	lui	t1,0x80
  804de4:	252972a9 	addiu	t1,t1,29353
          move  $a0, $t1                
  804de8:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804dec:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804df0:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  804df4:	0c2001d8 	jal	800760 <_PrintString>
  804df8:	00000000 	nop
          lw    $t0, 4($fp)             
  804dfc:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 16($t0)            
  804e00:	8d090010 	lw	t1,16(t0)
          move  $a0, $t1                
  804e04:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804e08:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804e0c:	afc80004 	sw	t0,4(s8)
          jal   _PrintInt               
  804e10:	0c2001b6 	jal	8006d8 <_PrintInt>
  804e14:	00000000 	nop
          lw    $t0, 4($fp)             
  804e18:	8fc80004 	lw	t0,4(s8)
          la    $t1, _STRING14          
  804e1c:	3c090080 	lui	t1,0x80
  804e20:	252971ff 	addiu	t1,t1,29183
          move  $a0, $t1                
  804e24:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804e28:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804e2c:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  804e30:	0c2001d8 	jal	800760 <_PrintString>
  804e34:	00000000 	nop
          lw    $t0, 4($fp)             
  804e38:	8fc80004 	lw	t0,4(s8)
          sw    $t0, 4($fp)             
  804e3c:	afc80004 	sw	t0,4(s8)

00804e40 <_L298>:
_L298:                                  
          lw    $t0, 4($fp)             
  804e40:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 16($t0)            
  804e44:	8d090010 	lw	t1,16(t0)
          lw    $t2, -8($fp)            
  804e48:	8fcafff8 	lw	t2,-8(s8)
          mult  $t2, $t1                
  804e4c:	01490018 	mult	t2,t1
          mflo  $t3                     
  804e50:	00005812 	mflo	t3
          move  $t2, $t3                
  804e54:	01605021 	move	t2,t3
          lw    $t1, 16($t0)            
  804e58:	8d090010 	lw	t1,16(t0)
          lw    $t3, -12($fp)           
  804e5c:	8fcbfff4 	lw	t3,-12(s8)
          mult  $t3, $t1                
  804e60:	01690018 	mult	t3,t1
          mflo  $t4                     
  804e64:	00006012 	mflo	t4
          move  $t3, $t4                
  804e68:	01805821 	move	t3,t4
          lw    $t1, 20($t0)            
  804e6c:	8d090014 	lw	t1,20(t0)
          lw    $t1, 20($t0)            
  804e70:	8d090014 	lw	t1,20(t0)
          addu  $t4, $t1, $t2           
  804e74:	012a6021 	addu	t4,t1,t2
          subu  $t1, $t4, $t3           
  804e78:	018b4823 	subu	t1,t4,t3
          sw    $t1, 20($t0)            
  804e7c:	ad090014 	sw	t1,20(t0)
          sw    $t0, 4($fp)             
  804e80:	afc80004 	sw	t0,4(s8)
          move  $v0, $zero              
  804e84:	00001021 	move	v0,zero
          move  $sp, $fp                
  804e88:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  804e8c:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  804e90:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  804e94:	03e00008 	jr	ra
  804e98:	00000000 	nop

00804e9c <_L295>:
_L295:                                  
          li    $t0, 1                  
  804e9c:	24080001 	li	t0,1
          lw    $t1, -12($fp)           
  804ea0:	8fc9fff4 	lw	t1,-12(s8)
          sge   $t2, $t1, $t0           
  804ea4:	0128502a 	slt	t2,t1,t0
  804ea8:	394a0001 	xori	t2,t2,0x1
          sw    $t1, -12($fp)           
  804eac:	afc9fff4 	sw	t1,-12(s8)
          beqz  $t2, _L297              
  804eb0:	11400023 	beqz	t2,804f40 <_L297>
  804eb4:	00000000 	nop

00804eb8 <_L296>:
_L296:                                  
          lw    $t0, 4($fp)             
  804eb8:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 24($t0)            
  804ebc:	8d090018 	lw	t1,24(t0)
          move  $a0, $t1                
  804ec0:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804ec4:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804ec8:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  804ecc:	0c2001d8 	jal	800760 <_PrintString>
  804ed0:	00000000 	nop
          lw    $t0, 4($fp)             
  804ed4:	8fc80004 	lw	t0,4(s8)
          la    $t1, _STRING26          
  804ed8:	3c090080 	lui	t1,0x80
  804edc:	2529731c 	addiu	t1,t1,29468
          move  $a0, $t1                
  804ee0:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804ee4:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804ee8:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  804eec:	0c2001d8 	jal	800760 <_PrintString>
  804ef0:	00000000 	nop
          lw    $t0, 4($fp)             
  804ef4:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 16($t0)            
  804ef8:	8d090010 	lw	t1,16(t0)
          move  $a0, $t1                
  804efc:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804f00:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804f04:	afc80004 	sw	t0,4(s8)
          jal   _PrintInt               
  804f08:	0c2001b6 	jal	8006d8 <_PrintInt>
  804f0c:	00000000 	nop
          lw    $t0, 4($fp)             
  804f10:	8fc80004 	lw	t0,4(s8)
          la    $t1, _STRING14          
  804f14:	3c090080 	lui	t1,0x80
  804f18:	252971ff 	addiu	t1,t1,29183
          move  $a0, $t1                
  804f1c:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804f20:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804f24:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  804f28:	0c2001d8 	jal	800760 <_PrintString>
  804f2c:	00000000 	nop
          lw    $t0, 4($fp)             
  804f30:	8fc80004 	lw	t0,4(s8)
          sw    $t0, 4($fp)             
  804f34:	afc80004 	sw	t0,4(s8)
          b     _L298                   
  804f38:	1000ffc1 	b	804e40 <_L298>
  804f3c:	00000000 	nop

00804f40 <_L297>:
_L297:                                  
          lw    $t0, 4($fp)             
  804f40:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 24($t0)            
  804f44:	8d090018 	lw	t1,24(t0)
          move  $a0, $t1                
  804f48:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804f4c:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804f50:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  804f54:	0c2001d8 	jal	800760 <_PrintString>
  804f58:	00000000 	nop
          lw    $t0, 4($fp)             
  804f5c:	8fc80004 	lw	t0,4(s8)
          la    $t1, _STRING27          
  804f60:	3c090080 	lui	t1,0x80
  804f64:	25297182 	addiu	t1,t1,29058
          move  $a0, $t1                
  804f68:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  804f6c:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  804f70:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  804f74:	0c2001d8 	jal	800760 <_PrintString>
  804f78:	00000000 	nop
          lw    $t0, 4($fp)             
  804f7c:	8fc80004 	lw	t0,4(s8)
          sw    $t0, 4($fp)             
  804f80:	afc80004 	sw	t0,4(s8)
          b     _L298                   
  804f84:	1000ffae 	b	804e40 <_L298>
  804f88:	00000000 	nop

00804f8c <_L285>:
_L285:                                  
          lw    $t0, 4($fp)             
  804f8c:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  804f90:	8d090004 	lw	t1,4(t0)
          li    $t2, 21                 
  804f94:	240a0015 	li	t2,21
          sgt   $t3, $t1, $t2           
  804f98:	0149582a 	slt	t3,t2,t1
          sw    $t0, 4($fp)             
  804f9c:	afc80004 	sw	t0,4(s8)
          beqz  $t3, _L287              
  804fa0:	11600006 	beqz	t3,804fbc <_L287>
  804fa4:	00000000 	nop

00804fa8 <_L286>:
_L286:                                  
          li    $t0, 1                  
  804fa8:	24080001 	li	t0,1
          move  $t1, $t0                
  804fac:	01004821 	move	t1,t0
          sw    $t1, -12($fp)           
  804fb0:	afc9fff4 	sw	t1,-12(s8)
          b     _L293                   
  804fb4:	1000ff7b 	b	804da4 <_L293>
  804fb8:	00000000 	nop

00804fbc <_L287>:
_L287:                                  
          li    $t0, 21                 
  804fbc:	24080015 	li	t0,21
          lw    $t1, 8($fp)             
  804fc0:	8fc90008 	lw	t1,8(s8)
          sgt   $t2, $t1, $t0           
  804fc4:	0109502a 	slt	t2,t0,t1
          sw    $t1, 8($fp)             
  804fc8:	afc90008 	sw	t1,8(s8)
          beqz  $t2, _L289              
  804fcc:	11400006 	beqz	t2,804fe8 <_L289>
  804fd0:	00000000 	nop

00804fd4 <_L288>:
_L288:                                  
          li    $t0, 1                  
  804fd4:	24080001 	li	t0,1
          move  $t1, $t0                
  804fd8:	01004821 	move	t1,t0
          sw    $t1, -8($fp)            
  804fdc:	afc9fff8 	sw	t1,-8(s8)
          b     _L293                   
  804fe0:	1000ff70 	b	804da4 <_L293>
  804fe4:	00000000 	nop

00804fe8 <_L289>:
_L289:                                  
          lw    $t0, 4($fp)             
  804fe8:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  804fec:	8d090004 	lw	t1,4(t0)
          lw    $t2, 8($fp)             
  804ff0:	8fca0008 	lw	t2,8(s8)
          sgt   $t3, $t1, $t2           
  804ff4:	0149582a 	slt	t3,t2,t1
          sw    $t0, 4($fp)             
  804ff8:	afc80004 	sw	t0,4(s8)
          sw    $t2, 8($fp)             
  804ffc:	afca0008 	sw	t2,8(s8)
          beqz  $t3, _L291              
  805000:	11600006 	beqz	t3,80501c <_L291>
  805004:	00000000 	nop

00805008 <_L290>:
_L290:                                  
          li    $t0, 1                  
  805008:	24080001 	li	t0,1
          move  $t1, $t0                
  80500c:	01004821 	move	t1,t0
          sw    $t1, -8($fp)            
  805010:	afc9fff8 	sw	t1,-8(s8)
          b     _L293                   
  805014:	1000ff63 	b	804da4 <_L293>
  805018:	00000000 	nop

0080501c <_L291>:
_L291:                                  
          lw    $t0, 4($fp)             
  80501c:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  805020:	8d090004 	lw	t1,4(t0)
          lw    $t2, 8($fp)             
  805024:	8fca0008 	lw	t2,8(s8)
          sgt   $t3, $t2, $t1           
  805028:	012a582a 	slt	t3,t1,t2
          sw    $t0, 4($fp)             
  80502c:	afc80004 	sw	t0,4(s8)
          sw    $t2, 8($fp)             
  805030:	afca0008 	sw	t2,8(s8)
          beqz  $t3, _L293              
  805034:	1160ff5b 	beqz	t3,804da4 <_L293>
  805038:	00000000 	nop

0080503c <_L292>:
_L292:                                  
          li    $t0, 1                  
  80503c:	24080001 	li	t0,1
          move  $t1, $t0                
  805040:	01004821 	move	t1,t0
          sw    $t1, -12($fp)           
  805044:	afc9fff4 	sw	t1,-12(s8)
          b     _L293                   
  805048:	1000ff56 	b	804da4 <_L293>
  80504c:	00000000 	nop

00805050 <_Player.GetYesOrNo>:

_Player.GetYesOrNo:                     # function entry
          sw $fp, 0($sp)                
  805050:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  805054:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  805058:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -16           
  80505c:	27bdfff0 	addiu	sp,sp,-16

00805060 <_L299>:
_L299:                                  
          lw    $t0, 8($fp)             
  805060:	8fc80008 	lw	t0,8(s8)
          move  $a0, $t0                
  805064:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  805068:	afa80004 	sw	t0,4(sp)
          sw    $t0, 8($fp)             
  80506c:	afc80008 	sw	t0,8(s8)
          jal   _PrintString            
  805070:	0c2001d8 	jal	800760 <_PrintString>
  805074:	00000000 	nop
          lw    $t0, 8($fp)             
  805078:	8fc80008 	lw	t0,8(s8)
          la    $t1, _STRING28          
  80507c:	3c090080 	lui	t1,0x80
  805080:	25297384 	addiu	t1,t1,29572
          move  $a0, $t1                
  805084:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  805088:	afa90004 	sw	t1,4(sp)
          sw    $t0, 8($fp)             
  80508c:	afc80008 	sw	t0,8(s8)
          jal   _PrintString            
  805090:	0c2001d8 	jal	800760 <_PrintString>
  805094:	00000000 	nop
          lw    $t0, 8($fp)             
  805098:	8fc80008 	lw	t0,8(s8)
          sw    $t0, 8($fp)             
  80509c:	afc80008 	sw	t0,8(s8)
          jal   _ReadInteger            
  8050a0:	0c20023f 	jal	8008fc <_ReadInteger>
  8050a4:	00000000 	nop
          move  $t1, $v0                
  8050a8:	00404821 	move	t1,v0
          lw    $t0, 8($fp)             
  8050ac:	8fc80008 	lw	t0,8(s8)
          li    $t2, 0                  
  8050b0:	240a0000 	li	t2,0
          sne   $t3, $t1, $t2           
  8050b4:	012a5826 	xor	t3,t1,t2
  8050b8:	000b582b 	sltu	t3,zero,t3
          sw    $t0, 8($fp)             
  8050bc:	afc80008 	sw	t0,8(s8)
          move  $v0, $t3                
  8050c0:	01601021 	move	v0,t3
          move  $sp, $fp                
  8050c4:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  8050c8:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  8050cc:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  8050d0:	03e00008 	jr	ra
  8050d4:	00000000 	nop

008050d8 <_Dealer.Init>:

_Dealer.Init:                           # function entry
          sw $fp, 0($sp)                
  8050d8:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  8050dc:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  8050e0:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -12           
  8050e4:	27bdfff4 	addiu	sp,sp,-12

008050e8 <_L300>:
_L300:                                  
          lw    $t0, 4($fp)             
  8050e8:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  8050ec:	8d090004 	lw	t1,4(t0)
          li    $t1, 0                  
  8050f0:	24090000 	li	t1,0
          sw    $t1, 4($t0)             
  8050f4:	ad090004 	sw	t1,4(t0)
          lw    $t1, 8($t0)             
  8050f8:	8d090008 	lw	t1,8(t0)
          li    $t1, 0                  
  8050fc:	24090000 	li	t1,0
          sw    $t1, 8($t0)             
  805100:	ad090008 	sw	t1,8(t0)
          lw    $t1, 12($t0)            
  805104:	8d09000c 	lw	t1,12(t0)
          li    $t1, 0                  
  805108:	24090000 	li	t1,0
          sw    $t1, 12($t0)            
  80510c:	ad09000c 	sw	t1,12(t0)
          la    $t1, _STRING4           
  805110:	3c090080 	lui	t1,0x80
  805114:	252973b7 	addiu	t1,t1,29623
          move  $t2, $t1                
  805118:	01205021 	move	t2,t1
          lw    $t1, 24($t0)            
  80511c:	8d090018 	lw	t1,24(t0)
          sw    $t2, 24($t0)            
  805120:	ad0a0018 	sw	t2,24(t0)
          sw    $t0, 4($fp)             
  805124:	afc80004 	sw	t0,4(s8)
          move  $v0, $zero              
  805128:	00001021 	move	v0,zero
          move  $sp, $fp                
  80512c:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  805130:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  805134:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  805138:	03e00008 	jr	ra
  80513c:	00000000 	nop

00805140 <_Dealer.TakeTurn>:

_Dealer.TakeTurn:                       # function entry
          sw $fp, 0($sp)                
  805140:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  805144:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  805148:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -20           
  80514c:	27bdffec 	addiu	sp,sp,-20

00805150 <_L301>:
_L301:                                  
          la    $t0, _STRING17          
  805150:	3c080080 	lui	t0,0x80
  805154:	25087161 	addiu	t0,t0,29025
          move  $a0, $t0                
  805158:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  80515c:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  805160:	0c2001d8 	jal	800760 <_PrintString>
  805164:	00000000 	nop
          lw    $t0, 4($fp)             
  805168:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 24($t0)            
  80516c:	8d090018 	lw	t1,24(t0)
          move  $a0, $t1                
  805170:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  805174:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  805178:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  80517c:	0c2001d8 	jal	800760 <_PrintString>
  805180:	00000000 	nop
          lw    $t0, 4($fp)             
  805184:	8fc80004 	lw	t0,4(s8)
          la    $t1, _STRING18          
  805188:	3c090080 	lui	t1,0x80
  80518c:	25297398 	addiu	t1,t1,29592
          move  $a0, $t1                
  805190:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  805194:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  805198:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  80519c:	0c2001d8 	jal	800760 <_PrintString>
  8051a0:	00000000 	nop
          lw    $t0, 4($fp)             
  8051a4:	8fc80004 	lw	t0,4(s8)
          sw    $t0, 4($fp)             
  8051a8:	afc80004 	sw	t0,4(s8)

008051ac <_L302>:
_L302:                                  
          lw    $t0, 4($fp)             
  8051ac:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  8051b0:	8d090004 	lw	t1,4(t0)
          li    $t2, 16                 
  8051b4:	240a0010 	li	t2,16
          sle   $t3, $t1, $t2           
  8051b8:	0149582a 	slt	t3,t2,t1
  8051bc:	396b0001 	xori	t3,t3,0x1
          sw    $t0, 4($fp)             
  8051c0:	afc80004 	sw	t0,4(s8)
          beqz  $t3, _L304              
  8051c4:	11600013 	beqz	t3,805214 <_L304>
  8051c8:	00000000 	nop

008051cc <_L303>:
_L303:                                  
          lw    $t0, 4($fp)             
  8051cc:	8fc80004 	lw	t0,4(s8)
          move  $a0, $t0                
  8051d0:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  8051d4:	afa80004 	sw	t0,4(sp)
          lw    $t1, 8($fp)             
  8051d8:	8fc90008 	lw	t1,8(s8)
          move  $a1, $t1                
  8051dc:	01202821 	move	a1,t1
          sw    $t1, 8($sp)             
  8051e0:	afa90008 	sw	t1,8(sp)
          lw    $t2, 0($t0)             
  8051e4:	8d0a0000 	lw	t2,0(t0)
          lw    $t3, 12($t2)            
  8051e8:	8d4b000c 	lw	t3,12(t2)
          sw    $t0, 4($fp)             
  8051ec:	afc80004 	sw	t0,4(s8)
          sw    $t1, 8($fp)             
  8051f0:	afc90008 	sw	t1,8(s8)
          jalr  $t3                     
  8051f4:	0160f809 	jalr	t3
  8051f8:	00000000 	nop
          lw    $t0, 4($fp)             
  8051fc:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($fp)             
  805200:	8fc90008 	lw	t1,8(s8)
          sw    $t0, 4($fp)             
  805204:	afc80004 	sw	t0,4(s8)
          sw    $t1, 8($fp)             
  805208:	afc90008 	sw	t1,8(s8)
          b     _L302                   
  80520c:	1000ffe7 	b	8051ac <_L302>
  805210:	00000000 	nop

00805214 <_L304>:
_L304:                                  
          lw    $t0, 4($fp)             
  805214:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  805218:	8d090004 	lw	t1,4(t0)
          li    $t2, 21                 
  80521c:	240a0015 	li	t2,21
          sgt   $t3, $t1, $t2           
  805220:	0149582a 	slt	t3,t2,t1
          sw    $t0, 4($fp)             
  805224:	afc80004 	sw	t0,4(s8)
          beqz  $t3, _L306              
  805228:	11600027 	beqz	t3,8052c8 <_L306>
  80522c:	00000000 	nop

00805230 <_L305>:
_L305:                                  
          lw    $t0, 4($fp)             
  805230:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 24($t0)            
  805234:	8d090018 	lw	t1,24(t0)
          move  $a0, $t1                
  805238:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  80523c:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  805240:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  805244:	0c2001d8 	jal	800760 <_PrintString>
  805248:	00000000 	nop
          lw    $t0, 4($fp)             
  80524c:	8fc80004 	lw	t0,4(s8)
          la    $t1, _STRING20          
  805250:	3c090080 	lui	t1,0x80
  805254:	252973a2 	addiu	t1,t1,29602
          move  $a0, $t1                
  805258:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  80525c:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  805260:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  805264:	0c2001d8 	jal	800760 <_PrintString>
  805268:	00000000 	nop
          lw    $t0, 4($fp)             
  80526c:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  805270:	8d090004 	lw	t1,4(t0)
          move  $a0, $t1                
  805274:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  805278:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  80527c:	afc80004 	sw	t0,4(s8)
          jal   _PrintInt               
  805280:	0c2001b6 	jal	8006d8 <_PrintInt>
  805284:	00000000 	nop
          lw    $t0, 4($fp)             
  805288:	8fc80004 	lw	t0,4(s8)
          la    $t1, _STRING21          
  80528c:	3c090080 	lui	t1,0x80
  805290:	25297134 	addiu	t1,t1,28980
          move  $a0, $t1                
  805294:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  805298:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  80529c:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  8052a0:	0c2001d8 	jal	800760 <_PrintString>
  8052a4:	00000000 	nop
          lw    $t0, 4($fp)             
  8052a8:	8fc80004 	lw	t0,4(s8)
          sw    $t0, 4($fp)             
  8052ac:	afc80004 	sw	t0,4(s8)

008052b0 <_L307>:
_L307:                                  
          move  $v0, $zero              
  8052b0:	00001021 	move	v0,zero
          move  $sp, $fp                
  8052b4:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  8052b8:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  8052bc:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  8052c0:	03e00008 	jr	ra
  8052c4:	00000000 	nop

008052c8 <_L306>:
_L306:                                  
          lw    $t0, 4($fp)             
  8052c8:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 24($t0)            
  8052cc:	8d090018 	lw	t1,24(t0)
          move  $a0, $t1                
  8052d0:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  8052d4:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  8052d8:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  8052dc:	0c2001d8 	jal	800760 <_PrintString>
  8052e0:	00000000 	nop
          lw    $t0, 4($fp)             
  8052e4:	8fc80004 	lw	t0,4(s8)
          la    $t1, _STRING22          
  8052e8:	3c090080 	lui	t1,0x80
  8052ec:	25297129 	addiu	t1,t1,28969
          move  $a0, $t1                
  8052f0:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  8052f4:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  8052f8:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  8052fc:	0c2001d8 	jal	800760 <_PrintString>
  805300:	00000000 	nop
          lw    $t0, 4($fp)             
  805304:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  805308:	8d090004 	lw	t1,4(t0)
          move  $a0, $t1                
  80530c:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  805310:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  805314:	afc80004 	sw	t0,4(s8)
          jal   _PrintInt               
  805318:	0c2001b6 	jal	8006d8 <_PrintInt>
  80531c:	00000000 	nop
          lw    $t0, 4($fp)             
  805320:	8fc80004 	lw	t0,4(s8)
          la    $t1, _STRING14          
  805324:	3c090080 	lui	t1,0x80
  805328:	252971ff 	addiu	t1,t1,29183
          move  $a0, $t1                
  80532c:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  805330:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  805334:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  805338:	0c2001d8 	jal	800760 <_PrintString>
  80533c:	00000000 	nop
          lw    $t0, 4($fp)             
  805340:	8fc80004 	lw	t0,4(s8)
          sw    $t0, 4($fp)             
  805344:	afc80004 	sw	t0,4(s8)
          b     _L307                   
  805348:	1000ffd9 	b	8052b0 <_L307>
  80534c:	00000000 	nop

00805350 <_House.SetupGame>:

_House.SetupGame:                       # function entry
          sw $fp, 0($sp)                
  805350:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  805354:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  805358:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -24           
  80535c:	27bdffe8 	addiu	sp,sp,-24

00805360 <_L308>:
_L308:                                  
          la    $t0, _STRING29          
  805360:	3c080080 	lui	t0,0x80
  805364:	250873f2 	addiu	t0,t0,29682
          move  $a0, $t0                
  805368:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  80536c:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  805370:	0c2001d8 	jal	800760 <_PrintString>
  805374:	00000000 	nop
          la    $t0, _STRING30          
  805378:	3c080080 	lui	t0,0x80
  80537c:	250872c2 	addiu	t0,t0,29378
          move  $a0, $t0                
  805380:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  805384:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  805388:	0c2001d8 	jal	800760 <_PrintString>
  80538c:	00000000 	nop
          jal   _rndModule_New          
  805390:	0c200ca0 	jal	803280 <_rndModule_New>
  805394:	00000000 	nop
          move  $t0, $v0                
  805398:	00404021 	move	t0,v0
          move  $t1, $t0                
  80539c:	01004821 	move	t1,t0
          la    $t0, _STRING31          
  8053a0:	3c080080 	lui	t0,0x80
  8053a4:	25087263 	addiu	t0,t0,29283
          move  $a0, $t0                
  8053a8:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  8053ac:	afa80004 	sw	t0,4(sp)
          sw    $t1, -8($fp)            
  8053b0:	afc9fff8 	sw	t1,-8(s8)
          jal   _PrintString            
  8053b4:	0c2001d8 	jal	800760 <_PrintString>
  8053b8:	00000000 	nop
          lw    $t1, -8($fp)            
  8053bc:	8fc9fff8 	lw	t1,-8(s8)
          sw    $t1, -8($fp)            
  8053c0:	afc9fff8 	sw	t1,-8(s8)
          jal   _ReadInteger            
  8053c4:	0c20023f 	jal	8008fc <_ReadInteger>
  8053c8:	00000000 	nop
          move  $t0, $v0                
  8053cc:	00404021 	move	t0,v0
          lw    $t1, -8($fp)            
  8053d0:	8fc9fff8 	lw	t1,-8(s8)
          move  $a0, $t1                
  8053d4:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  8053d8:	afa90004 	sw	t1,4(sp)
          move  $a1, $t0                
  8053dc:	01002821 	move	a1,t0
          sw    $t0, 8($sp)             
  8053e0:	afa80008 	sw	t0,8(sp)
          lw    $t0, 0($t1)             
  8053e4:	8d280000 	lw	t0,0(t1)
          lw    $t2, 8($t0)             
  8053e8:	8d0a0008 	lw	t2,8(t0)
          sw    $t1, -8($fp)            
  8053ec:	afc9fff8 	sw	t1,-8(s8)
          jalr  $t2                     
  8053f0:	0140f809 	jalr	t2
  8053f4:	00000000 	nop
          lw    $t1, -8($fp)            
  8053f8:	8fc9fff8 	lw	t1,-8(s8)
          lw    $t0, 4($fp)             
  8053fc:	8fc80004 	lw	t0,4(s8)
          lw    $t2, 12($t0)            
  805400:	8d0a000c 	lw	t2,12(t0)
          sw    $t0, 4($fp)             
  805404:	afc80004 	sw	t0,4(s8)
          sw    $t1, -8($fp)            
  805408:	afc9fff8 	sw	t1,-8(s8)
          jal   _BJDeck_New             
  80540c:	0c200ccc 	jal	803330 <_BJDeck_New>
  805410:	00000000 	nop
          move  $t2, $v0                
  805414:	00405021 	move	t2,v0
          lw    $t0, 4($fp)             
  805418:	8fc80004 	lw	t0,4(s8)
          lw    $t1, -8($fp)            
  80541c:	8fc9fff8 	lw	t1,-8(s8)
          sw    $t2, 12($t0)            
  805420:	ad0a000c 	sw	t2,12(t0)
          lw    $t2, 8($t0)             
  805424:	8d0a0008 	lw	t2,8(t0)
          sw    $t0, 4($fp)             
  805428:	afc80004 	sw	t0,4(s8)
          sw    $t1, -8($fp)            
  80542c:	afc9fff8 	sw	t1,-8(s8)
          jal   _Dealer_New             
  805430:	0c200d13 	jal	80344c <_Dealer_New>
  805434:	00000000 	nop
          move  $t2, $v0                
  805438:	00405021 	move	t2,v0
          lw    $t0, 4($fp)             
  80543c:	8fc80004 	lw	t0,4(s8)
          lw    $t1, -8($fp)            
  805440:	8fc9fff8 	lw	t1,-8(s8)
          sw    $t2, 8($t0)             
  805444:	ad0a0008 	sw	t2,8(t0)
          lw    $t2, 12($t0)            
  805448:	8d0a000c 	lw	t2,12(t0)
          move  $a0, $t2                
  80544c:	01402021 	move	a0,t2
          sw    $t2, 4($sp)             
  805450:	afaa0004 	sw	t2,4(sp)
          move  $a1, $t1                
  805454:	01202821 	move	a1,t1
          sw    $t1, 8($sp)             
  805458:	afa90008 	sw	t1,8(sp)
          lw    $t1, 0($t2)             
  80545c:	8d490000 	lw	t1,0(t2)
          lw    $t2, 8($t1)             
  805460:	8d2a0008 	lw	t2,8(t1)
          sw    $t0, 4($fp)             
  805464:	afc80004 	sw	t0,4(s8)
          jalr  $t2                     
  805468:	0140f809 	jalr	t2
  80546c:	00000000 	nop
          lw    $t0, 4($fp)             
  805470:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 12($t0)            
  805474:	8d09000c 	lw	t1,12(t0)
          move  $a0, $t1                
  805478:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  80547c:	afa90004 	sw	t1,4(sp)
          lw    $t2, 0($t1)             
  805480:	8d2a0000 	lw	t2,0(t1)
          lw    $t1, 16($t2)            
  805484:	8d490010 	lw	t1,16(t2)
          sw    $t0, 4($fp)             
  805488:	afc80004 	sw	t0,4(s8)
          jalr  $t1                     
  80548c:	0120f809 	jalr	t1
  805490:	00000000 	nop
          lw    $t0, 4($fp)             
  805494:	8fc80004 	lw	t0,4(s8)
          sw    $t0, 4($fp)             
  805498:	afc80004 	sw	t0,4(s8)
          move  $v0, $zero              
  80549c:	00001021 	move	v0,zero
          move  $sp, $fp                
  8054a0:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  8054a4:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  8054a8:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  8054ac:	03e00008 	jr	ra
  8054b0:	00000000 	nop

008054b4 <_House.SetupPlayers>:

_House.SetupPlayers:                    # function entry
          sw $fp, 0($sp)                
  8054b4:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  8054b8:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  8054bc:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -52           
  8054c0:	27bdffcc 	addiu	sp,sp,-52

008054c4 <_L309>:
_L309:                                  
          la    $t0, _STRING32          
  8054c4:	3c080080 	lui	t0,0x80
  8054c8:	250871a7 	addiu	t0,t0,29095
          move  $a0, $t0                
  8054cc:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  8054d0:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  8054d4:	0c2001d8 	jal	800760 <_PrintString>
  8054d8:	00000000 	nop
          jal   _ReadInteger            
  8054dc:	0c20023f 	jal	8008fc <_ReadInteger>
  8054e0:	00000000 	nop
          move  $t0, $v0                
  8054e4:	00404021 	move	t0,v0
          move  $t1, $t0                
  8054e8:	01004821 	move	t1,t0
          lw    $t0, 4($fp)             
  8054ec:	8fc80004 	lw	t0,4(s8)
          lw    $t2, 4($t0)             
  8054f0:	8d0a0004 	lw	t2,4(t0)
          li    $t2, 0                  
  8054f4:	240a0000 	li	t2,0
          slt   $t3, $t1, $t2           
  8054f8:	012a582a 	slt	t3,t1,t2
          sw    $t0, 4($fp)             
  8054fc:	afc80004 	sw	t0,4(s8)
          sw    $t1, -8($fp)            
  805500:	afc9fff8 	sw	t1,-8(s8)
          beqz  $t3, _L311              
  805504:	11600009 	beqz	t3,80552c <_L311>
  805508:	00000000 	nop

0080550c <_L310>:
_L310:                                  
          la    $t0, _STRING7           
  80550c:	3c080080 	lui	t0,0x80
  805510:	25087209 	addiu	t0,t0,29193
          move  $a0, $t0                
  805514:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  805518:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  80551c:	0c2001d8 	jal	800760 <_PrintString>
  805520:	00000000 	nop
          jal   _Halt                   
  805524:	0c200200 	jal	800800 <_Halt>
  805528:	00000000 	nop

0080552c <_L311>:
_L311:                                  
          li    $t0, 4                  
  80552c:	24080004 	li	t0,4
          lw    $t1, -8($fp)            
  805530:	8fc9fff8 	lw	t1,-8(s8)
          mult  $t0, $t1                
  805534:	01090018 	mult	t0,t1
          mflo  $t2                     
  805538:	00005012 	mflo	t2
          addu  $t3, $t0, $t2           
  80553c:	010a5821 	addu	t3,t0,t2
          move  $a0, $t3                
  805540:	01602021 	move	a0,t3
          sw    $t3, 4($sp)             
  805544:	afab0004 	sw	t3,4(sp)
          sw    $t0, -12($fp)           
  805548:	afc8fff4 	sw	t0,-12(s8)
          sw    $t3, -16($fp)           
  80554c:	afcbfff0 	sw	t3,-16(s8)
          sw    $t1, -8($fp)            
  805550:	afc9fff8 	sw	t1,-8(s8)
          jal   _Alloc                  
  805554:	0c20016c 	jal	8005b0 <_Alloc>
  805558:	00000000 	nop
          move  $t2, $v0                
  80555c:	00405021 	move	t2,v0
          lw    $t0, -12($fp)           
  805560:	8fc8fff4 	lw	t0,-12(s8)
          lw    $t3, -16($fp)           
  805564:	8fcbfff0 	lw	t3,-16(s8)
          lw    $t1, -8($fp)            
  805568:	8fc9fff8 	lw	t1,-8(s8)
          sw    $t1, 0($t2)             
  80556c:	ad490000 	sw	t1,0(t2)
          li    $t1, 0                  
  805570:	24090000 	li	t1,0
          addu  $t2, $t2, $t3           
  805574:	014b5021 	addu	t2,t2,t3
          sw    $t0, -12($fp)           
  805578:	afc8fff4 	sw	t0,-12(s8)
          sw    $t3, -16($fp)           
  80557c:	afcbfff0 	sw	t3,-16(s8)
          sw    $t2, -20($fp)           
  805580:	afcaffec 	sw	t2,-20(s8)
          sw    $t1, -24($fp)           
  805584:	afc9ffe8 	sw	t1,-24(s8)

00805588 <_L312>:
_L312:                                  
          lw    $t0, -16($fp)           
  805588:	8fc8fff0 	lw	t0,-16(s8)
          lw    $t1, -12($fp)           
  80558c:	8fc9fff4 	lw	t1,-12(s8)
          subu  $t0, $t0, $t1           
  805590:	01094023 	subu	t0,t0,t1
          sw    $t1, -12($fp)           
  805594:	afc9fff4 	sw	t1,-12(s8)
          sw    $t0, -16($fp)           
  805598:	afc8fff0 	sw	t0,-16(s8)
          beqz  $t0, _L314              
  80559c:	1100000b 	beqz	t0,8055cc <_L314>
  8055a0:	00000000 	nop

008055a4 <_L313>:
_L313:                                  
          lw    $t0, -20($fp)           
  8055a4:	8fc8ffec 	lw	t0,-20(s8)
          lw    $t1, -12($fp)           
  8055a8:	8fc9fff4 	lw	t1,-12(s8)
          subu  $t0, $t0, $t1           
  8055ac:	01094023 	subu	t0,t0,t1
          lw    $t2, -24($fp)           
  8055b0:	8fcaffe8 	lw	t2,-24(s8)
          sw    $t2, 0($t0)             
  8055b4:	ad0a0000 	sw	t2,0(t0)
          sw    $t1, -12($fp)           
  8055b8:	afc9fff4 	sw	t1,-12(s8)
          sw    $t0, -20($fp)           
  8055bc:	afc8ffec 	sw	t0,-20(s8)
          sw    $t2, -24($fp)           
  8055c0:	afcaffe8 	sw	t2,-24(s8)
          b     _L312                   
  8055c4:	1000fff0 	b	805588 <_L312>
  8055c8:	00000000 	nop

008055cc <_L314>:
_L314:                                  
          lw    $t0, 4($fp)             
  8055cc:	8fc80004 	lw	t0,4(s8)
          lw    $t1, -20($fp)           
  8055d0:	8fc9ffec 	lw	t1,-20(s8)
          sw    $t1, 4($t0)             
  8055d4:	ad090004 	sw	t1,4(t0)
          li    $t1, 0                  
  8055d8:	24090000 	li	t1,0
          move  $t2, $t1                
  8055dc:	01205021 	move	t2,t1
          sw    $t0, 4($fp)             
  8055e0:	afc80004 	sw	t0,4(s8)
          sw    $t2, -28($fp)           
  8055e4:	afcaffe4 	sw	t2,-28(s8)

008055e8 <_L316>:
_L316:                                  
          lw    $t0, 4($fp)             
  8055e8:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  8055ec:	8d090004 	lw	t1,4(t0)
          lw    $t2, -4($t1)            
  8055f0:	8d2afffc 	lw	t2,-4(t1)
          lw    $t1, -28($fp)           
  8055f4:	8fc9ffe4 	lw	t1,-28(s8)
          slt   $t3, $t1, $t2           
  8055f8:	012a582a 	slt	t3,t1,t2
          sw    $t0, 4($fp)             
  8055fc:	afc80004 	sw	t0,4(s8)
          sw    $t1, -28($fp)           
  805600:	afc9ffe4 	sw	t1,-28(s8)
          beqz  $t3, _L324              
  805604:	1160005e 	beqz	t3,805780 <_L324>
  805608:	00000000 	nop

0080560c <_L317>:
_L317:                                  
          lw    $t0, 4($fp)             
  80560c:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  805610:	8d090004 	lw	t1,4(t0)
          lw    $t2, -4($t1)            
  805614:	8d2afffc 	lw	t2,-4(t1)
          lw    $t3, -28($fp)           
  805618:	8fcbffe4 	lw	t3,-28(s8)
          slt   $t4, $t3, $t2           
  80561c:	016a602a 	slt	t4,t3,t2
          sw    $t0, 4($fp)             
  805620:	afc80004 	sw	t0,4(s8)
          sw    $t3, -28($fp)           
  805624:	afcbffe4 	sw	t3,-28(s8)
          sw    $t1, -32($fp)           
  805628:	afc9ffe0 	sw	t1,-32(s8)
          beqz  $t4, _L319              
  80562c:	11800007 	beqz	t4,80564c <_L319>
  805630:	00000000 	nop

00805634 <_L318>:
_L318:                                  
          li    $t0, 0                  
  805634:	24080000 	li	t0,0
          lw    $t1, -28($fp)           
  805638:	8fc9ffe4 	lw	t1,-28(s8)
          slt   $t2, $t1, $t0           
  80563c:	0128502a 	slt	t2,t1,t0
          sw    $t1, -28($fp)           
  805640:	afc9ffe4 	sw	t1,-28(s8)
          beqz  $t2, _L320              
  805644:	11400009 	beqz	t2,80566c <_L320>
  805648:	00000000 	nop

0080564c <_L319>:
_L319:                                  
          la    $t0, _STRING8           
  80564c:	3c080080 	lui	t0,0x80
  805650:	250873be 	addiu	t0,t0,29630
          move  $a0, $t0                
  805654:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  805658:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  80565c:	0c2001d8 	jal	800760 <_PrintString>
  805660:	00000000 	nop
          jal   _Halt                   
  805664:	0c200200 	jal	800800 <_Halt>
  805668:	00000000 	nop

0080566c <_L320>:
_L320:                                  
          li    $t0, 4                  
  80566c:	24080004 	li	t0,4
          lw    $t1, -28($fp)           
  805670:	8fc9ffe4 	lw	t1,-28(s8)
          mult  $t1, $t0                
  805674:	01280018 	mult	t1,t0
          mflo  $t2                     
  805678:	00005012 	mflo	t2
          lw    $t0, -32($fp)           
  80567c:	8fc8ffe0 	lw	t0,-32(s8)
          addu  $t3, $t0, $t2           
  805680:	010a5821 	addu	t3,t0,t2
          lw    $t2, 0($t3)             
  805684:	8d6a0000 	lw	t2,0(t3)
          sw    $t1, -28($fp)           
  805688:	afc9ffe4 	sw	t1,-28(s8)
          sw    $t0, -32($fp)           
  80568c:	afc8ffe0 	sw	t0,-32(s8)
          jal   _Player_New             
  805690:	0c200ce3 	jal	80338c <_Player_New>
  805694:	00000000 	nop
          move  $t2, $v0                
  805698:	00405021 	move	t2,v0
          lw    $t1, -28($fp)           
  80569c:	8fc9ffe4 	lw	t1,-28(s8)
          lw    $t0, -32($fp)           
  8056a0:	8fc8ffe0 	lw	t0,-32(s8)
          li    $t3, 4                  
  8056a4:	240b0004 	li	t3,4
          mult  $t1, $t3                
  8056a8:	012b0018 	mult	t1,t3
          mflo  $t4                     
  8056ac:	00006012 	mflo	t4
          addu  $t3, $t0, $t4           
  8056b0:	010c5821 	addu	t3,t0,t4
          sw    $t2, 0($t3)             
  8056b4:	ad6a0000 	sw	t2,0(t3)
          lw    $t0, 4($fp)             
  8056b8:	8fc80004 	lw	t0,4(s8)
          lw    $t2, 4($t0)             
  8056bc:	8d0a0004 	lw	t2,4(t0)
          lw    $t3, -4($t2)            
  8056c0:	8d4bfffc 	lw	t3,-4(t2)
          slt   $t4, $t1, $t3           
  8056c4:	012b602a 	slt	t4,t1,t3
          sw    $t0, 4($fp)             
  8056c8:	afc80004 	sw	t0,4(s8)
          sw    $t1, -28($fp)           
  8056cc:	afc9ffe4 	sw	t1,-28(s8)
          sw    $t2, -36($fp)           
  8056d0:	afcaffdc 	sw	t2,-36(s8)
          beqz  $t4, _L322              
  8056d4:	11800007 	beqz	t4,8056f4 <_L322>
  8056d8:	00000000 	nop

008056dc <_L321>:
_L321:                                  
          li    $t0, 0                  
  8056dc:	24080000 	li	t0,0
          lw    $t1, -28($fp)           
  8056e0:	8fc9ffe4 	lw	t1,-28(s8)
          slt   $t2, $t1, $t0           
  8056e4:	0128502a 	slt	t2,t1,t0
          sw    $t1, -28($fp)           
  8056e8:	afc9ffe4 	sw	t1,-28(s8)
          beqz  $t2, _L323              
  8056ec:	11400009 	beqz	t2,805714 <_L323>
  8056f0:	00000000 	nop

008056f4 <_L322>:
_L322:                                  
          la    $t0, _STRING8           
  8056f4:	3c080080 	lui	t0,0x80
  8056f8:	250873be 	addiu	t0,t0,29630
          move  $a0, $t0                
  8056fc:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  805700:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  805704:	0c2001d8 	jal	800760 <_PrintString>
  805708:	00000000 	nop
          jal   _Halt                   
  80570c:	0c200200 	jal	800800 <_Halt>
  805710:	00000000 	nop

00805714 <_L323>:
_L323:                                  
          li    $t0, 4                  
  805714:	24080004 	li	t0,4
          lw    $t1, -28($fp)           
  805718:	8fc9ffe4 	lw	t1,-28(s8)
          mult  $t1, $t0                
  80571c:	01280018 	mult	t1,t0
          mflo  $t2                     
  805720:	00005012 	mflo	t2
          lw    $t0, -36($fp)           
  805724:	8fc8ffdc 	lw	t0,-36(s8)
          addu  $t3, $t0, $t2           
  805728:	010a5821 	addu	t3,t0,t2
          lw    $t0, 0($t3)             
  80572c:	8d680000 	lw	t0,0(t3)
          li    $t2, 1                  
  805730:	240a0001 	li	t2,1
          addu  $t3, $t1, $t2           
  805734:	012a5821 	addu	t3,t1,t2
          move  $a0, $t0                
  805738:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  80573c:	afa80004 	sw	t0,4(sp)
          move  $a1, $t3                
  805740:	01602821 	move	a1,t3
          sw    $t3, 8($sp)             
  805744:	afab0008 	sw	t3,8(sp)
          lw    $t2, 0($t0)             
  805748:	8d0a0000 	lw	t2,0(t0)
          lw    $t0, 8($t2)             
  80574c:	8d480008 	lw	t0,8(t2)
          sw    $t1, -28($fp)           
  805750:	afc9ffe4 	sw	t1,-28(s8)
          jalr  $t0                     
  805754:	0100f809 	jalr	t0
  805758:	00000000 	nop
          lw    $t1, -28($fp)           
  80575c:	8fc9ffe4 	lw	t1,-28(s8)
          sw    $t1, -28($fp)           
  805760:	afc9ffe4 	sw	t1,-28(s8)

00805764 <_L315>:
_L315:                                  
          li    $t0, 1                  
  805764:	24080001 	li	t0,1
          lw    $t1, -28($fp)           
  805768:	8fc9ffe4 	lw	t1,-28(s8)
          addu  $t2, $t1, $t0           
  80576c:	01285021 	addu	t2,t1,t0
          move  $t1, $t2                
  805770:	01404821 	move	t1,t2
          sw    $t1, -28($fp)           
  805774:	afc9ffe4 	sw	t1,-28(s8)
          b     _L316                   
  805778:	1000ff9b 	b	8055e8 <_L316>
  80577c:	00000000 	nop

00805780 <_L324>:
_L324:                                  
          move  $v0, $zero              
  805780:	00001021 	move	v0,zero
          move  $sp, $fp                
  805784:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  805788:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  80578c:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  805790:	03e00008 	jr	ra
  805794:	00000000 	nop

00805798 <_House.TakeAllBets>:

_House.TakeAllBets:                     # function entry
          sw $fp, 0($sp)                
  805798:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  80579c:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  8057a0:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -28           
  8057a4:	27bdffe4 	addiu	sp,sp,-28

008057a8 <_L325>:
_L325:                                  
          la    $t0, _STRING33          
  8057a8:	3c080080 	lui	t0,0x80
  8057ac:	2508734c 	addiu	t0,t0,29516
          move  $a0, $t0                
  8057b0:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  8057b4:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  8057b8:	0c2001d8 	jal	800760 <_PrintString>
  8057bc:	00000000 	nop
          li    $t0, 0                  
  8057c0:	24080000 	li	t0,0
          move  $t1, $t0                
  8057c4:	01004821 	move	t1,t0
          sw    $t1, -8($fp)            
  8057c8:	afc9fff8 	sw	t1,-8(s8)

008057cc <_L327>:
_L327:                                  
          lw    $t0, 4($fp)             
  8057cc:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  8057d0:	8d090004 	lw	t1,4(t0)
          lw    $t2, -4($t1)            
  8057d4:	8d2afffc 	lw	t2,-4(t1)
          lw    $t1, -8($fp)            
  8057d8:	8fc9fff8 	lw	t1,-8(s8)
          slt   $t3, $t1, $t2           
  8057dc:	012a582a 	slt	t3,t1,t2
          sw    $t0, 4($fp)             
  8057e0:	afc80004 	sw	t0,4(s8)
          sw    $t1, -8($fp)            
  8057e4:	afc9fff8 	sw	t1,-8(s8)
          beqz  $t3, _L336              
  8057e8:	1160005b 	beqz	t3,805958 <_L336>
  8057ec:	00000000 	nop

008057f0 <_L328>:
_L328:                                  
          lw    $t0, 4($fp)             
  8057f0:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  8057f4:	8d090004 	lw	t1,4(t0)
          lw    $t2, -4($t1)            
  8057f8:	8d2afffc 	lw	t2,-4(t1)
          lw    $t3, -8($fp)            
  8057fc:	8fcbfff8 	lw	t3,-8(s8)
          slt   $t4, $t3, $t2           
  805800:	016a602a 	slt	t4,t3,t2
          sw    $t1, -12($fp)           
  805804:	afc9fff4 	sw	t1,-12(s8)
          sw    $t0, 4($fp)             
  805808:	afc80004 	sw	t0,4(s8)
          sw    $t3, -8($fp)            
  80580c:	afcbfff8 	sw	t3,-8(s8)
          beqz  $t4, _L330              
  805810:	11800007 	beqz	t4,805830 <_L330>
  805814:	00000000 	nop

00805818 <_L329>:
_L329:                                  
          li    $t0, 0                  
  805818:	24080000 	li	t0,0
          lw    $t1, -8($fp)            
  80581c:	8fc9fff8 	lw	t1,-8(s8)
          slt   $t2, $t1, $t0           
  805820:	0128502a 	slt	t2,t1,t0
          sw    $t1, -8($fp)            
  805824:	afc9fff8 	sw	t1,-8(s8)
          beqz  $t2, _L331              
  805828:	11400009 	beqz	t2,805850 <_L331>
  80582c:	00000000 	nop

00805830 <_L330>:
_L330:                                  
          la    $t0, _STRING8           
  805830:	3c080080 	lui	t0,0x80
  805834:	250873be 	addiu	t0,t0,29630
          move  $a0, $t0                
  805838:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  80583c:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  805840:	0c2001d8 	jal	800760 <_PrintString>
  805844:	00000000 	nop
          jal   _Halt                   
  805848:	0c200200 	jal	800800 <_Halt>
  80584c:	00000000 	nop

00805850 <_L331>:
_L331:                                  
          li    $t0, 4                  
  805850:	24080004 	li	t0,4
          lw    $t1, -8($fp)            
  805854:	8fc9fff8 	lw	t1,-8(s8)
          mult  $t1, $t0                
  805858:	01280018 	mult	t1,t0
          mflo  $t2                     
  80585c:	00005012 	mflo	t2
          lw    $t0, -12($fp)           
  805860:	8fc8fff4 	lw	t0,-12(s8)
          addu  $t3, $t0, $t2           
  805864:	010a5821 	addu	t3,t0,t2
          lw    $t0, 0($t3)             
  805868:	8d680000 	lw	t0,0(t3)
          move  $a0, $t0                
  80586c:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  805870:	afa80004 	sw	t0,4(sp)
          lw    $t2, 0($t0)             
  805874:	8d0a0000 	lw	t2,0(t0)
          lw    $t0, 24($t2)            
  805878:	8d480018 	lw	t0,24(t2)
          sw    $t1, -8($fp)            
  80587c:	afc9fff8 	sw	t1,-8(s8)
          jalr  $t0                     
  805880:	0100f809 	jalr	t0
  805884:	00000000 	nop
          move  $t2, $v0                
  805888:	00405021 	move	t2,v0
          lw    $t1, -8($fp)            
  80588c:	8fc9fff8 	lw	t1,-8(s8)
          sw    $t1, -8($fp)            
  805890:	afc9fff8 	sw	t1,-8(s8)
          beqz  $t2, _L326              
  805894:	11400029 	beqz	t2,80593c <_L326>
  805898:	00000000 	nop

0080589c <_L332>:
_L332:                                  
          lw    $t0, 4($fp)             
  80589c:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  8058a0:	8d090004 	lw	t1,4(t0)
          lw    $t2, -4($t1)            
  8058a4:	8d2afffc 	lw	t2,-4(t1)
          lw    $t3, -8($fp)            
  8058a8:	8fcbfff8 	lw	t3,-8(s8)
          slt   $t4, $t3, $t2           
  8058ac:	016a602a 	slt	t4,t3,t2
          sw    $t1, -16($fp)           
  8058b0:	afc9fff0 	sw	t1,-16(s8)
          sw    $t0, 4($fp)             
  8058b4:	afc80004 	sw	t0,4(s8)
          sw    $t3, -8($fp)            
  8058b8:	afcbfff8 	sw	t3,-8(s8)
          beqz  $t4, _L334              
  8058bc:	11800007 	beqz	t4,8058dc <_L334>
  8058c0:	00000000 	nop

008058c4 <_L333>:
_L333:                                  
          li    $t0, 0                  
  8058c4:	24080000 	li	t0,0
          lw    $t1, -8($fp)            
  8058c8:	8fc9fff8 	lw	t1,-8(s8)
          slt   $t2, $t1, $t0           
  8058cc:	0128502a 	slt	t2,t1,t0
          sw    $t1, -8($fp)            
  8058d0:	afc9fff8 	sw	t1,-8(s8)
          beqz  $t2, _L335              
  8058d4:	11400009 	beqz	t2,8058fc <_L335>
  8058d8:	00000000 	nop

008058dc <_L334>:
_L334:                                  
          la    $t0, _STRING8           
  8058dc:	3c080080 	lui	t0,0x80
  8058e0:	250873be 	addiu	t0,t0,29630
          move  $a0, $t0                
  8058e4:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  8058e8:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  8058ec:	0c2001d8 	jal	800760 <_PrintString>
  8058f0:	00000000 	nop
          jal   _Halt                   
  8058f4:	0c200200 	jal	800800 <_Halt>
  8058f8:	00000000 	nop

008058fc <_L335>:
_L335:                                  
          li    $t0, 4                  
  8058fc:	24080004 	li	t0,4
          lw    $t1, -8($fp)            
  805900:	8fc9fff8 	lw	t1,-8(s8)
          mult  $t1, $t0                
  805904:	01280018 	mult	t1,t0
          mflo  $t2                     
  805908:	00005012 	mflo	t2
          lw    $t0, -16($fp)           
  80590c:	8fc8fff0 	lw	t0,-16(s8)
          addu  $t3, $t0, $t2           
  805910:	010a5821 	addu	t3,t0,t2
          lw    $t0, 0($t3)             
  805914:	8d680000 	lw	t0,0(t3)
          move  $a0, $t0                
  805918:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  80591c:	afa80004 	sw	t0,4(sp)
          lw    $t2, 0($t0)             
  805920:	8d0a0000 	lw	t2,0(t0)
          lw    $t0, 32($t2)            
  805924:	8d480020 	lw	t0,32(t2)
          sw    $t1, -8($fp)            
  805928:	afc9fff8 	sw	t1,-8(s8)
          jalr  $t0                     
  80592c:	0100f809 	jalr	t0
  805930:	00000000 	nop
          lw    $t1, -8($fp)            
  805934:	8fc9fff8 	lw	t1,-8(s8)
          sw    $t1, -8($fp)            
  805938:	afc9fff8 	sw	t1,-8(s8)

0080593c <_L326>:
_L326:                                  
          li    $t0, 1                  
  80593c:	24080001 	li	t0,1
          lw    $t1, -8($fp)            
  805940:	8fc9fff8 	lw	t1,-8(s8)
          addu  $t2, $t1, $t0           
  805944:	01285021 	addu	t2,t1,t0
          move  $t1, $t2                
  805948:	01404821 	move	t1,t2
          sw    $t1, -8($fp)            
  80594c:	afc9fff8 	sw	t1,-8(s8)
          b     _L327                   
  805950:	1000ff9e 	b	8057cc <_L327>
  805954:	00000000 	nop

00805958 <_L336>:
_L336:                                  
          move  $v0, $zero              
  805958:	00001021 	move	v0,zero
          move  $sp, $fp                
  80595c:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  805960:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  805964:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  805968:	03e00008 	jr	ra
  80596c:	00000000 	nop

00805970 <_House.TakeAllTurns>:

_House.TakeAllTurns:                    # function entry
          sw $fp, 0($sp)                
  805970:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  805974:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  805978:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -32           
  80597c:	27bdffe0 	addiu	sp,sp,-32

00805980 <_L337>:
_L337:                                  
          li    $t0, 0                  
  805980:	24080000 	li	t0,0
          move  $t1, $t0                
  805984:	01004821 	move	t1,t0
          sw    $t1, -8($fp)            
  805988:	afc9fff8 	sw	t1,-8(s8)

0080598c <_L339>:
_L339:                                  
          lw    $t0, 4($fp)             
  80598c:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  805990:	8d090004 	lw	t1,4(t0)
          lw    $t2, -4($t1)            
  805994:	8d2afffc 	lw	t2,-4(t1)
          lw    $t1, -8($fp)            
  805998:	8fc9fff8 	lw	t1,-8(s8)
          slt   $t3, $t1, $t2           
  80599c:	012a582a 	slt	t3,t1,t2
          sw    $t0, 4($fp)             
  8059a0:	afc80004 	sw	t0,4(s8)
          sw    $t1, -8($fp)            
  8059a4:	afc9fff8 	sw	t1,-8(s8)
          beqz  $t3, _L348              
  8059a8:	11600062 	beqz	t3,805b34 <_L348>
  8059ac:	00000000 	nop

008059b0 <_L340>:
_L340:                                  
          lw    $t0, 4($fp)             
  8059b0:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  8059b4:	8d090004 	lw	t1,4(t0)
          lw    $t2, -4($t1)            
  8059b8:	8d2afffc 	lw	t2,-4(t1)
          lw    $t3, -8($fp)            
  8059bc:	8fcbfff8 	lw	t3,-8(s8)
          slt   $t4, $t3, $t2           
  8059c0:	016a602a 	slt	t4,t3,t2
          sw    $t1, -12($fp)           
  8059c4:	afc9fff4 	sw	t1,-12(s8)
          sw    $t0, 4($fp)             
  8059c8:	afc80004 	sw	t0,4(s8)
          sw    $t3, -8($fp)            
  8059cc:	afcbfff8 	sw	t3,-8(s8)
          beqz  $t4, _L342              
  8059d0:	11800007 	beqz	t4,8059f0 <_L342>
  8059d4:	00000000 	nop

008059d8 <_L341>:
_L341:                                  
          li    $t0, 0                  
  8059d8:	24080000 	li	t0,0
          lw    $t1, -8($fp)            
  8059dc:	8fc9fff8 	lw	t1,-8(s8)
          slt   $t2, $t1, $t0           
  8059e0:	0128502a 	slt	t2,t1,t0
          sw    $t1, -8($fp)            
  8059e4:	afc9fff8 	sw	t1,-8(s8)
          beqz  $t2, _L343              
  8059e8:	11400009 	beqz	t2,805a10 <_L343>
  8059ec:	00000000 	nop

008059f0 <_L342>:
_L342:                                  
          la    $t0, _STRING8           
  8059f0:	3c080080 	lui	t0,0x80
  8059f4:	250873be 	addiu	t0,t0,29630
          move  $a0, $t0                
  8059f8:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  8059fc:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  805a00:	0c2001d8 	jal	800760 <_PrintString>
  805a04:	00000000 	nop
          jal   _Halt                   
  805a08:	0c200200 	jal	800800 <_Halt>
  805a0c:	00000000 	nop

00805a10 <_L343>:
_L343:                                  
          li    $t0, 4                  
  805a10:	24080004 	li	t0,4
          lw    $t1, -8($fp)            
  805a14:	8fc9fff8 	lw	t1,-8(s8)
          mult  $t1, $t0                
  805a18:	01280018 	mult	t1,t0
          mflo  $t2                     
  805a1c:	00005012 	mflo	t2
          lw    $t0, -12($fp)           
  805a20:	8fc8fff4 	lw	t0,-12(s8)
          addu  $t3, $t0, $t2           
  805a24:	010a5821 	addu	t3,t0,t2
          lw    $t0, 0($t3)             
  805a28:	8d680000 	lw	t0,0(t3)
          move  $a0, $t0                
  805a2c:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  805a30:	afa80004 	sw	t0,4(sp)
          lw    $t2, 0($t0)             
  805a34:	8d0a0000 	lw	t2,0(t0)
          lw    $t0, 24($t2)            
  805a38:	8d480018 	lw	t0,24(t2)
          sw    $t1, -8($fp)            
  805a3c:	afc9fff8 	sw	t1,-8(s8)
          jalr  $t0                     
  805a40:	0100f809 	jalr	t0
  805a44:	00000000 	nop
          move  $t2, $v0                
  805a48:	00405021 	move	t2,v0
          lw    $t1, -8($fp)            
  805a4c:	8fc9fff8 	lw	t1,-8(s8)
          sw    $t1, -8($fp)            
  805a50:	afc9fff8 	sw	t1,-8(s8)
          beqz  $t2, _L338              
  805a54:	11400030 	beqz	t2,805b18 <_L338>
  805a58:	00000000 	nop

00805a5c <_L344>:
_L344:                                  
          lw    $t0, 4($fp)             
  805a5c:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  805a60:	8d090004 	lw	t1,4(t0)
          lw    $t2, -4($t1)            
  805a64:	8d2afffc 	lw	t2,-4(t1)
          lw    $t3, -8($fp)            
  805a68:	8fcbfff8 	lw	t3,-8(s8)
          slt   $t4, $t3, $t2           
  805a6c:	016a602a 	slt	t4,t3,t2
          sw    $t1, -16($fp)           
  805a70:	afc9fff0 	sw	t1,-16(s8)
          sw    $t0, 4($fp)             
  805a74:	afc80004 	sw	t0,4(s8)
          sw    $t3, -8($fp)            
  805a78:	afcbfff8 	sw	t3,-8(s8)
          beqz  $t4, _L346              
  805a7c:	11800007 	beqz	t4,805a9c <_L346>
  805a80:	00000000 	nop

00805a84 <_L345>:
_L345:                                  
          li    $t0, 0                  
  805a84:	24080000 	li	t0,0
          lw    $t1, -8($fp)            
  805a88:	8fc9fff8 	lw	t1,-8(s8)
          slt   $t2, $t1, $t0           
  805a8c:	0128502a 	slt	t2,t1,t0
          sw    $t1, -8($fp)            
  805a90:	afc9fff8 	sw	t1,-8(s8)
          beqz  $t2, _L347              
  805a94:	11400009 	beqz	t2,805abc <_L347>
  805a98:	00000000 	nop

00805a9c <_L346>:
_L346:                                  
          la    $t0, _STRING8           
  805a9c:	3c080080 	lui	t0,0x80
  805aa0:	250873be 	addiu	t0,t0,29630
          move  $a0, $t0                
  805aa4:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  805aa8:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  805aac:	0c2001d8 	jal	800760 <_PrintString>
  805ab0:	00000000 	nop
          jal   _Halt                   
  805ab4:	0c200200 	jal	800800 <_Halt>
  805ab8:	00000000 	nop

00805abc <_L347>:
_L347:                                  
          li    $t0, 4                  
  805abc:	24080004 	li	t0,4
          lw    $t1, -8($fp)            
  805ac0:	8fc9fff8 	lw	t1,-8(s8)
          mult  $t1, $t0                
  805ac4:	01280018 	mult	t1,t0
          mflo  $t2                     
  805ac8:	00005012 	mflo	t2
          lw    $t0, -16($fp)           
  805acc:	8fc8fff0 	lw	t0,-16(s8)
          addu  $t3, $t0, $t2           
  805ad0:	010a5821 	addu	t3,t0,t2
          lw    $t0, 0($t3)             
  805ad4:	8d680000 	lw	t0,0(t3)
          lw    $t2, 4($fp)             
  805ad8:	8fca0004 	lw	t2,4(s8)
          lw    $t3, 12($t2)            
  805adc:	8d4b000c 	lw	t3,12(t2)
          move  $a0, $t0                
  805ae0:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  805ae4:	afa80004 	sw	t0,4(sp)
          move  $a1, $t3                
  805ae8:	01602821 	move	a1,t3
          sw    $t3, 8($sp)             
  805aec:	afab0008 	sw	t3,8(sp)
          lw    $t3, 0($t0)             
  805af0:	8d0b0000 	lw	t3,0(t0)
          lw    $t0, 20($t3)            
  805af4:	8d680014 	lw	t0,20(t3)
          sw    $t2, 4($fp)             
  805af8:	afca0004 	sw	t2,4(s8)
          sw    $t1, -8($fp)            
  805afc:	afc9fff8 	sw	t1,-8(s8)
          jalr  $t0                     
  805b00:	0100f809 	jalr	t0
  805b04:	00000000 	nop
          lw    $t2, 4($fp)             
  805b08:	8fca0004 	lw	t2,4(s8)
          lw    $t1, -8($fp)            
  805b0c:	8fc9fff8 	lw	t1,-8(s8)
          sw    $t2, 4($fp)             
  805b10:	afca0004 	sw	t2,4(s8)
          sw    $t1, -8($fp)            
  805b14:	afc9fff8 	sw	t1,-8(s8)

00805b18 <_L338>:
_L338:                                  
          li    $t0, 1                  
  805b18:	24080001 	li	t0,1
          lw    $t1, -8($fp)            
  805b1c:	8fc9fff8 	lw	t1,-8(s8)
          addu  $t2, $t1, $t0           
  805b20:	01285021 	addu	t2,t1,t0
          move  $t1, $t2                
  805b24:	01404821 	move	t1,t2
          sw    $t1, -8($fp)            
  805b28:	afc9fff8 	sw	t1,-8(s8)
          b     _L339                   
  805b2c:	1000ff97 	b	80598c <_L339>
  805b30:	00000000 	nop

00805b34 <_L348>:
_L348:                                  
          move  $v0, $zero              
  805b34:	00001021 	move	v0,zero
          move  $sp, $fp                
  805b38:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  805b3c:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  805b40:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  805b44:	03e00008 	jr	ra
  805b48:	00000000 	nop

00805b4c <_House.ResolveAllPlayers>:

_House.ResolveAllPlayers:               # function entry
          sw $fp, 0($sp)                
  805b4c:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  805b50:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  805b54:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -36           
  805b58:	27bdffdc 	addiu	sp,sp,-36

00805b5c <_L349>:
_L349:                                  
          la    $t0, _STRING34          
  805b5c:	3c080080 	lui	t0,0x80
  805b60:	2508718f 	addiu	t0,t0,29071
          move  $a0, $t0                
  805b64:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  805b68:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  805b6c:	0c2001d8 	jal	800760 <_PrintString>
  805b70:	00000000 	nop
          li    $t0, 0                  
  805b74:	24080000 	li	t0,0
          move  $t1, $t0                
  805b78:	01004821 	move	t1,t0
          sw    $t1, -8($fp)            
  805b7c:	afc9fff8 	sw	t1,-8(s8)

00805b80 <_L351>:
_L351:                                  
          lw    $t0, 4($fp)             
  805b80:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  805b84:	8d090004 	lw	t1,4(t0)
          lw    $t2, -4($t1)            
  805b88:	8d2afffc 	lw	t2,-4(t1)
          lw    $t1, -8($fp)            
  805b8c:	8fc9fff8 	lw	t1,-8(s8)
          slt   $t3, $t1, $t2           
  805b90:	012a582a 	slt	t3,t1,t2
          sw    $t0, 4($fp)             
  805b94:	afc80004 	sw	t0,4(s8)
          sw    $t1, -8($fp)            
  805b98:	afc9fff8 	sw	t1,-8(s8)
          beqz  $t3, _L360              
  805b9c:	1160006f 	beqz	t3,805d5c <_L360>
  805ba0:	00000000 	nop

00805ba4 <_L352>:
_L352:                                  
          lw    $t0, 4($fp)             
  805ba4:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  805ba8:	8d090004 	lw	t1,4(t0)
          lw    $t2, -4($t1)            
  805bac:	8d2afffc 	lw	t2,-4(t1)
          lw    $t3, -8($fp)            
  805bb0:	8fcbfff8 	lw	t3,-8(s8)
          slt   $t4, $t3, $t2           
  805bb4:	016a602a 	slt	t4,t3,t2
          sw    $t1, -12($fp)           
  805bb8:	afc9fff4 	sw	t1,-12(s8)
          sw    $t0, 4($fp)             
  805bbc:	afc80004 	sw	t0,4(s8)
          sw    $t3, -8($fp)            
  805bc0:	afcbfff8 	sw	t3,-8(s8)
          beqz  $t4, _L354              
  805bc4:	11800007 	beqz	t4,805be4 <_L354>
  805bc8:	00000000 	nop

00805bcc <_L353>:
_L353:                                  
          li    $t0, 0                  
  805bcc:	24080000 	li	t0,0
          lw    $t1, -8($fp)            
  805bd0:	8fc9fff8 	lw	t1,-8(s8)
          slt   $t2, $t1, $t0           
  805bd4:	0128502a 	slt	t2,t1,t0
          sw    $t1, -8($fp)            
  805bd8:	afc9fff8 	sw	t1,-8(s8)
          beqz  $t2, _L355              
  805bdc:	11400009 	beqz	t2,805c04 <_L355>
  805be0:	00000000 	nop

00805be4 <_L354>:
_L354:                                  
          la    $t0, _STRING8           
  805be4:	3c080080 	lui	t0,0x80
  805be8:	250873be 	addiu	t0,t0,29630
          move  $a0, $t0                
  805bec:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  805bf0:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  805bf4:	0c2001d8 	jal	800760 <_PrintString>
  805bf8:	00000000 	nop
          jal   _Halt                   
  805bfc:	0c200200 	jal	800800 <_Halt>
  805c00:	00000000 	nop

00805c04 <_L355>:
_L355:                                  
          li    $t0, 4                  
  805c04:	24080004 	li	t0,4
          lw    $t1, -8($fp)            
  805c08:	8fc9fff8 	lw	t1,-8(s8)
          mult  $t1, $t0                
  805c0c:	01280018 	mult	t1,t0
          mflo  $t2                     
  805c10:	00005012 	mflo	t2
          lw    $t0, -12($fp)           
  805c14:	8fc8fff4 	lw	t0,-12(s8)
          addu  $t3, $t0, $t2           
  805c18:	010a5821 	addu	t3,t0,t2
          lw    $t0, 0($t3)             
  805c1c:	8d680000 	lw	t0,0(t3)
          move  $a0, $t0                
  805c20:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  805c24:	afa80004 	sw	t0,4(sp)
          lw    $t2, 0($t0)             
  805c28:	8d0a0000 	lw	t2,0(t0)
          lw    $t0, 24($t2)            
  805c2c:	8d480018 	lw	t0,24(t2)
          sw    $t1, -8($fp)            
  805c30:	afc9fff8 	sw	t1,-8(s8)
          jalr  $t0                     
  805c34:	0100f809 	jalr	t0
  805c38:	00000000 	nop
          move  $t2, $v0                
  805c3c:	00405021 	move	t2,v0
          lw    $t1, -8($fp)            
  805c40:	8fc9fff8 	lw	t1,-8(s8)
          sw    $t1, -8($fp)            
  805c44:	afc9fff8 	sw	t1,-8(s8)
          beqz  $t2, _L350              
  805c48:	1140003d 	beqz	t2,805d40 <_L350>
  805c4c:	00000000 	nop

00805c50 <_L356>:
_L356:                                  
          lw    $t0, 4($fp)             
  805c50:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  805c54:	8d090004 	lw	t1,4(t0)
          lw    $t2, -4($t1)            
  805c58:	8d2afffc 	lw	t2,-4(t1)
          lw    $t3, -8($fp)            
  805c5c:	8fcbfff8 	lw	t3,-8(s8)
          slt   $t4, $t3, $t2           
  805c60:	016a602a 	slt	t4,t3,t2
          sw    $t1, -16($fp)           
  805c64:	afc9fff0 	sw	t1,-16(s8)
          sw    $t0, 4($fp)             
  805c68:	afc80004 	sw	t0,4(s8)
          sw    $t3, -8($fp)            
  805c6c:	afcbfff8 	sw	t3,-8(s8)
          beqz  $t4, _L358              
  805c70:	11800007 	beqz	t4,805c90 <_L358>
  805c74:	00000000 	nop

00805c78 <_L357>:
_L357:                                  
          li    $t0, 0                  
  805c78:	24080000 	li	t0,0
          lw    $t1, -8($fp)            
  805c7c:	8fc9fff8 	lw	t1,-8(s8)
          slt   $t2, $t1, $t0           
  805c80:	0128502a 	slt	t2,t1,t0
          sw    $t1, -8($fp)            
  805c84:	afc9fff8 	sw	t1,-8(s8)
          beqz  $t2, _L359              
  805c88:	11400009 	beqz	t2,805cb0 <_L359>
  805c8c:	00000000 	nop

00805c90 <_L358>:
_L358:                                  
          la    $t0, _STRING8           
  805c90:	3c080080 	lui	t0,0x80
  805c94:	250873be 	addiu	t0,t0,29630
          move  $a0, $t0                
  805c98:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  805c9c:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  805ca0:	0c2001d8 	jal	800760 <_PrintString>
  805ca4:	00000000 	nop
          jal   _Halt                   
  805ca8:	0c200200 	jal	800800 <_Halt>
  805cac:	00000000 	nop

00805cb0 <_L359>:
_L359:                                  
          li    $t0, 4                  
  805cb0:	24080004 	li	t0,4
          lw    $t1, -8($fp)            
  805cb4:	8fc9fff8 	lw	t1,-8(s8)
          mult  $t1, $t0                
  805cb8:	01280018 	mult	t1,t0
          mflo  $t2                     
  805cbc:	00005012 	mflo	t2
          lw    $t0, -16($fp)           
  805cc0:	8fc8fff0 	lw	t0,-16(s8)
          addu  $t3, $t0, $t2           
  805cc4:	010a5821 	addu	t3,t0,t2
          lw    $t0, 0($t3)             
  805cc8:	8d680000 	lw	t0,0(t3)
          lw    $t2, 4($fp)             
  805ccc:	8fca0004 	lw	t2,4(s8)
          lw    $t3, 8($t2)             
  805cd0:	8d4b0008 	lw	t3,8(t2)
          move  $a0, $t3                
  805cd4:	01602021 	move	a0,t3
          sw    $t3, 4($sp)             
  805cd8:	afab0004 	sw	t3,4(sp)
          lw    $t4, 0($t3)             
  805cdc:	8d6c0000 	lw	t4,0(t3)
          lw    $t3, 36($t4)            
  805ce0:	8d8b0024 	lw	t3,36(t4)
          sw    $t2, 4($fp)             
  805ce4:	afca0004 	sw	t2,4(s8)
          sw    $t0, -20($fp)           
  805ce8:	afc8ffec 	sw	t0,-20(s8)
          sw    $t1, -8($fp)            
  805cec:	afc9fff8 	sw	t1,-8(s8)
          jalr  $t3                     
  805cf0:	0160f809 	jalr	t3
  805cf4:	00000000 	nop
          move  $t4, $v0                
  805cf8:	00406021 	move	t4,v0
          lw    $t2, 4($fp)             
  805cfc:	8fca0004 	lw	t2,4(s8)
          lw    $t0, -20($fp)           
  805d00:	8fc8ffec 	lw	t0,-20(s8)
          lw    $t1, -8($fp)            
  805d04:	8fc9fff8 	lw	t1,-8(s8)
          move  $a0, $t0                
  805d08:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  805d0c:	afa80004 	sw	t0,4(sp)
          move  $a1, $t4                
  805d10:	01802821 	move	a1,t4
          sw    $t4, 8($sp)             
  805d14:	afac0008 	sw	t4,8(sp)
          lw    $t3, 0($t0)             
  805d18:	8d0b0000 	lw	t3,0(t0)
          lw    $t0, 40($t3)            
  805d1c:	8d680028 	lw	t0,40(t3)
          sw    $t2, 4($fp)             
  805d20:	afca0004 	sw	t2,4(s8)
          sw    $t1, -8($fp)            
  805d24:	afc9fff8 	sw	t1,-8(s8)
          jalr  $t0                     
  805d28:	0100f809 	jalr	t0
  805d2c:	00000000 	nop
          lw    $t2, 4($fp)             
  805d30:	8fca0004 	lw	t2,4(s8)
          lw    $t1, -8($fp)            
  805d34:	8fc9fff8 	lw	t1,-8(s8)
          sw    $t2, 4($fp)             
  805d38:	afca0004 	sw	t2,4(s8)
          sw    $t1, -8($fp)            
  805d3c:	afc9fff8 	sw	t1,-8(s8)

00805d40 <_L350>:
_L350:                                  
          li    $t0, 1                  
  805d40:	24080001 	li	t0,1
          lw    $t1, -8($fp)            
  805d44:	8fc9fff8 	lw	t1,-8(s8)
          addu  $t2, $t1, $t0           
  805d48:	01285021 	addu	t2,t1,t0
          move  $t1, $t2                
  805d4c:	01404821 	move	t1,t2
          sw    $t1, -8($fp)            
  805d50:	afc9fff8 	sw	t1,-8(s8)
          b     _L351                   
  805d54:	1000ff8a 	b	805b80 <_L351>
  805d58:	00000000 	nop

00805d5c <_L360>:
_L360:                                  
          move  $v0, $zero              
  805d5c:	00001021 	move	v0,zero
          move  $sp, $fp                
  805d60:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  805d64:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  805d68:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  805d6c:	03e00008 	jr	ra
  805d70:	00000000 	nop

00805d74 <_House.PrintAllMoney>:

_House.PrintAllMoney:                   # function entry
          sw $fp, 0($sp)                
  805d74:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  805d78:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  805d7c:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -24           
  805d80:	27bdffe8 	addiu	sp,sp,-24

00805d84 <_L361>:
_L361:                                  
          li    $t0, 0                  
  805d84:	24080000 	li	t0,0
          move  $t1, $t0                
  805d88:	01004821 	move	t1,t0
          sw    $t1, -8($fp)            
  805d8c:	afc9fff8 	sw	t1,-8(s8)

00805d90 <_L363>:
_L363:                                  
          lw    $t0, 4($fp)             
  805d90:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  805d94:	8d090004 	lw	t1,4(t0)
          lw    $t2, -4($t1)            
  805d98:	8d2afffc 	lw	t2,-4(t1)
          lw    $t1, -8($fp)            
  805d9c:	8fc9fff8 	lw	t1,-8(s8)
          slt   $t3, $t1, $t2           
  805da0:	012a582a 	slt	t3,t1,t2
          sw    $t1, -8($fp)            
  805da4:	afc9fff8 	sw	t1,-8(s8)
          sw    $t0, 4($fp)             
  805da8:	afc80004 	sw	t0,4(s8)
          beqz  $t3, _L368              
  805dac:	11600030 	beqz	t3,805e70 <_L368>
  805db0:	00000000 	nop

00805db4 <_L364>:
_L364:                                  
          lw    $t0, 4($fp)             
  805db4:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 4($t0)             
  805db8:	8d090004 	lw	t1,4(t0)
          lw    $t2, -4($t1)            
  805dbc:	8d2afffc 	lw	t2,-4(t1)
          lw    $t3, -8($fp)            
  805dc0:	8fcbfff8 	lw	t3,-8(s8)
          slt   $t4, $t3, $t2           
  805dc4:	016a602a 	slt	t4,t3,t2
          sw    $t3, -8($fp)            
  805dc8:	afcbfff8 	sw	t3,-8(s8)
          sw    $t0, 4($fp)             
  805dcc:	afc80004 	sw	t0,4(s8)
          sw    $t1, -12($fp)           
  805dd0:	afc9fff4 	sw	t1,-12(s8)
          beqz  $t4, _L366              
  805dd4:	11800007 	beqz	t4,805df4 <_L366>
  805dd8:	00000000 	nop

00805ddc <_L365>:
_L365:                                  
          li    $t0, 0                  
  805ddc:	24080000 	li	t0,0
          lw    $t1, -8($fp)            
  805de0:	8fc9fff8 	lw	t1,-8(s8)
          slt   $t2, $t1, $t0           
  805de4:	0128502a 	slt	t2,t1,t0
          sw    $t1, -8($fp)            
  805de8:	afc9fff8 	sw	t1,-8(s8)
          beqz  $t2, _L367              
  805dec:	11400009 	beqz	t2,805e14 <_L367>
  805df0:	00000000 	nop

00805df4 <_L366>:
_L366:                                  
          la    $t0, _STRING8           
  805df4:	3c080080 	lui	t0,0x80
  805df8:	250873be 	addiu	t0,t0,29630
          move  $a0, $t0                
  805dfc:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  805e00:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  805e04:	0c2001d8 	jal	800760 <_PrintString>
  805e08:	00000000 	nop
          jal   _Halt                   
  805e0c:	0c200200 	jal	800800 <_Halt>
  805e10:	00000000 	nop

00805e14 <_L367>:
_L367:                                  
          li    $t0, 4                  
  805e14:	24080004 	li	t0,4
          lw    $t1, -8($fp)            
  805e18:	8fc9fff8 	lw	t1,-8(s8)
          mult  $t1, $t0                
  805e1c:	01280018 	mult	t1,t0
          mflo  $t2                     
  805e20:	00005012 	mflo	t2
          lw    $t0, -12($fp)           
  805e24:	8fc8fff4 	lw	t0,-12(s8)
          addu  $t3, $t0, $t2           
  805e28:	010a5821 	addu	t3,t0,t2
          lw    $t0, 0($t3)             
  805e2c:	8d680000 	lw	t0,0(t3)
          move  $a0, $t0                
  805e30:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  805e34:	afa80004 	sw	t0,4(sp)
          lw    $t2, 0($t0)             
  805e38:	8d0a0000 	lw	t2,0(t0)
          lw    $t0, 28($t2)            
  805e3c:	8d48001c 	lw	t0,28(t2)
          sw    $t1, -8($fp)            
  805e40:	afc9fff8 	sw	t1,-8(s8)
          jalr  $t0                     
  805e44:	0100f809 	jalr	t0
  805e48:	00000000 	nop
          lw    $t1, -8($fp)            
  805e4c:	8fc9fff8 	lw	t1,-8(s8)
          sw    $t1, -8($fp)            
  805e50:	afc9fff8 	sw	t1,-8(s8)

00805e54 <_L362>:
_L362:                                  
          li    $t0, 1                  
  805e54:	24080001 	li	t0,1
          lw    $t1, -8($fp)            
  805e58:	8fc9fff8 	lw	t1,-8(s8)
          addu  $t2, $t1, $t0           
  805e5c:	01285021 	addu	t2,t1,t0
          move  $t1, $t2                
  805e60:	01404821 	move	t1,t2
          sw    $t1, -8($fp)            
  805e64:	afc9fff8 	sw	t1,-8(s8)
          b     _L363                   
  805e68:	1000ffc9 	b	805d90 <_L363>
  805e6c:	00000000 	nop

00805e70 <_L368>:
_L368:                                  
          move  $v0, $zero              
  805e70:	00001021 	move	v0,zero
          move  $sp, $fp                
  805e74:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  805e78:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  805e7c:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  805e80:	03e00008 	jr	ra
  805e84:	00000000 	nop

00805e88 <_House.PlayOneGame>:

_House.PlayOneGame:                     # function entry
          sw $fp, 0($sp)                
  805e88:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  805e8c:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  805e90:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -20           
  805e94:	27bdffec 	addiu	sp,sp,-20

00805e98 <_L369>:
_L369:                                  
          lw    $t0, 4($fp)             
  805e98:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 12($t0)            
  805e9c:	8d09000c 	lw	t1,12(t0)
          move  $a0, $t1                
  805ea0:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  805ea4:	afa90004 	sw	t1,4(sp)
          lw    $t2, 0($t1)             
  805ea8:	8d2a0000 	lw	t2,0(t1)
          lw    $t1, 20($t2)            
  805eac:	8d490014 	lw	t1,20(t2)
          sw    $t0, 4($fp)             
  805eb0:	afc80004 	sw	t0,4(s8)
          jalr  $t1                     
  805eb4:	0120f809 	jalr	t1
  805eb8:	00000000 	nop
          move  $t2, $v0                
  805ebc:	00405021 	move	t2,v0
          lw    $t0, 4($fp)             
  805ec0:	8fc80004 	lw	t0,4(s8)
          li    $t1, 26                 
  805ec4:	2409001a 	li	t1,26
          slt   $t3, $t2, $t1           
  805ec8:	0149582a 	slt	t3,t2,t1
          sw    $t0, 4($fp)             
  805ecc:	afc80004 	sw	t0,4(s8)
          beqz  $t3, _L371              
  805ed0:	1160000c 	beqz	t3,805f04 <_L371>
  805ed4:	00000000 	nop

00805ed8 <_L370>:
_L370:                                  
          lw    $t0, 4($fp)             
  805ed8:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 12($t0)            
  805edc:	8d09000c 	lw	t1,12(t0)
          move  $a0, $t1                
  805ee0:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  805ee4:	afa90004 	sw	t1,4(sp)
          lw    $t2, 0($t1)             
  805ee8:	8d2a0000 	lw	t2,0(t1)
          lw    $t1, 16($t2)            
  805eec:	8d490010 	lw	t1,16(t2)
          sw    $t0, 4($fp)             
  805ef0:	afc80004 	sw	t0,4(s8)
          jalr  $t1                     
  805ef4:	0120f809 	jalr	t1
  805ef8:	00000000 	nop
          lw    $t0, 4($fp)             
  805efc:	8fc80004 	lw	t0,4(s8)
          sw    $t0, 4($fp)             
  805f00:	afc80004 	sw	t0,4(s8)

00805f04 <_L371>:
_L371:                                  
          lw    $t0, 4($fp)             
  805f04:	8fc80004 	lw	t0,4(s8)
          move  $a0, $t0                
  805f08:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  805f0c:	afa80004 	sw	t0,4(sp)
          lw    $t1, 0($t0)             
  805f10:	8d090000 	lw	t1,0(t0)
          lw    $t2, 16($t1)            
  805f14:	8d2a0010 	lw	t2,16(t1)
          sw    $t0, 4($fp)             
  805f18:	afc80004 	sw	t0,4(s8)
          jalr  $t2                     
  805f1c:	0140f809 	jalr	t2
  805f20:	00000000 	nop
          lw    $t0, 4($fp)             
  805f24:	8fc80004 	lw	t0,4(s8)
          la    $t1, _STRING35          
  805f28:	3c090080 	lui	t1,0x80
  805f2c:	25297163 	addiu	t1,t1,29027
          move  $a0, $t1                
  805f30:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  805f34:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  805f38:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  805f3c:	0c2001d8 	jal	800760 <_PrintString>
  805f40:	00000000 	nop
          lw    $t0, 4($fp)             
  805f44:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($t0)             
  805f48:	8d090008 	lw	t1,8(t0)
          li    $t2, 0                  
  805f4c:	240a0000 	li	t2,0
          move  $a0, $t1                
  805f50:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  805f54:	afa90004 	sw	t1,4(sp)
          move  $a1, $t2                
  805f58:	01402821 	move	a1,t2
          sw    $t2, 8($sp)             
  805f5c:	afaa0008 	sw	t2,8(sp)
          lw    $t2, 0($t1)             
  805f60:	8d2a0000 	lw	t2,0(t1)
          lw    $t1, 8($t2)             
  805f64:	8d490008 	lw	t1,8(t2)
          sw    $t0, 4($fp)             
  805f68:	afc80004 	sw	t0,4(s8)
          jalr  $t1                     
  805f6c:	0120f809 	jalr	t1
  805f70:	00000000 	nop
          lw    $t0, 4($fp)             
  805f74:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($t0)             
  805f78:	8d090008 	lw	t1,8(t0)
          lw    $t2, 12($t0)            
  805f7c:	8d0a000c 	lw	t2,12(t0)
          move  $a0, $t1                
  805f80:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  805f84:	afa90004 	sw	t1,4(sp)
          move  $a1, $t2                
  805f88:	01402821 	move	a1,t2
          sw    $t2, 8($sp)             
  805f8c:	afaa0008 	sw	t2,8(sp)
          lw    $t2, 0($t1)             
  805f90:	8d2a0000 	lw	t2,0(t1)
          lw    $t1, 12($t2)            
  805f94:	8d49000c 	lw	t1,12(t2)
          sw    $t0, 4($fp)             
  805f98:	afc80004 	sw	t0,4(s8)
          jalr  $t1                     
  805f9c:	0120f809 	jalr	t1
  805fa0:	00000000 	nop
          lw    $t0, 4($fp)             
  805fa4:	8fc80004 	lw	t0,4(s8)
          move  $a0, $t0                
  805fa8:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  805fac:	afa80004 	sw	t0,4(sp)
          lw    $t1, 0($t0)             
  805fb0:	8d090000 	lw	t1,0(t0)
          lw    $t2, 20($t1)            
  805fb4:	8d2a0014 	lw	t2,20(t1)
          sw    $t0, 4($fp)             
  805fb8:	afc80004 	sw	t0,4(s8)
          jalr  $t2                     
  805fbc:	0140f809 	jalr	t2
  805fc0:	00000000 	nop
          lw    $t0, 4($fp)             
  805fc4:	8fc80004 	lw	t0,4(s8)
          lw    $t1, 8($t0)             
  805fc8:	8d090008 	lw	t1,8(t0)
          lw    $t2, 12($t0)            
  805fcc:	8d0a000c 	lw	t2,12(t0)
          move  $a0, $t1                
  805fd0:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  805fd4:	afa90004 	sw	t1,4(sp)
          move  $a1, $t2                
  805fd8:	01402821 	move	a1,t2
          sw    $t2, 8($sp)             
  805fdc:	afaa0008 	sw	t2,8(sp)
          lw    $t2, 0($t1)             
  805fe0:	8d2a0000 	lw	t2,0(t1)
          lw    $t1, 20($t2)            
  805fe4:	8d490014 	lw	t1,20(t2)
          sw    $t0, 4($fp)             
  805fe8:	afc80004 	sw	t0,4(s8)
          jalr  $t1                     
  805fec:	0120f809 	jalr	t1
  805ff0:	00000000 	nop
          lw    $t0, 4($fp)             
  805ff4:	8fc80004 	lw	t0,4(s8)
          move  $a0, $t0                
  805ff8:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  805ffc:	afa80004 	sw	t0,4(sp)
          lw    $t1, 0($t0)             
  806000:	8d090000 	lw	t1,0(t0)
          lw    $t2, 24($t1)            
  806004:	8d2a0018 	lw	t2,24(t1)
          sw    $t0, 4($fp)             
  806008:	afc80004 	sw	t0,4(s8)
          jalr  $t2                     
  80600c:	0140f809 	jalr	t2
  806010:	00000000 	nop
          lw    $t0, 4($fp)             
  806014:	8fc80004 	lw	t0,4(s8)
          sw    $t0, 4($fp)             
  806018:	afc80004 	sw	t0,4(s8)
          move  $v0, $zero              
  80601c:	00001021 	move	v0,zero
          move  $sp, $fp                
  806020:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  806024:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  806028:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  80602c:	03e00008 	jr	ra
  806030:	00000000 	nop

00806034 <main>:

main:                                   # function entry
          sw $fp, 0($sp)                
  806034:	afbe0000 afbffffc 03a0f021 27bdffe8     ........!......'

00806044 <_L372>:
          sw $ra, -4($sp)               
          move $fp, $sp                 
          addiu $sp, $sp, -24           
_L372:                                  
          li    $t0, 1                  
  806044:	24080001 	li	t0,1
          move  $t1, $t0                
  806048:	01004821 	move	t1,t0
          sw    $t1, -8($fp)            
  80604c:	afc9fff8 	sw	t1,-8(s8)
          jal   _House_New              
  806050:	0c200d43 	jal	80350c <_House_New>
  806054:	00000000 	nop
          move  $t0, $v0                
  806058:	00404021 	move	t0,v0
          lw    $t1, -8($fp)            
  80605c:	8fc9fff8 	lw	t1,-8(s8)
          move  $t2, $t0                
  806060:	01005021 	move	t2,t0
          move  $a0, $t2                
  806064:	01402021 	move	a0,t2
          sw    $t2, 4($sp)             
  806068:	afaa0004 	sw	t2,4(sp)
          lw    $t0, 0($t2)             
  80606c:	8d480000 	lw	t0,0(t2)
          lw    $t3, 8($t0)             
  806070:	8d0b0008 	lw	t3,8(t0)
          sw    $t1, -8($fp)            
  806074:	afc9fff8 	sw	t1,-8(s8)
          sw    $t2, -12($fp)           
  806078:	afcafff4 	sw	t2,-12(s8)
          jalr  $t3                     
  80607c:	0160f809 	jalr	t3
  806080:	00000000 	nop
          lw    $t1, -8($fp)            
  806084:	8fc9fff8 	lw	t1,-8(s8)
          lw    $t2, -12($fp)           
  806088:	8fcafff4 	lw	t2,-12(s8)
          move  $a0, $t2                
  80608c:	01402021 	move	a0,t2
          sw    $t2, 4($sp)             
  806090:	afaa0004 	sw	t2,4(sp)
          lw    $t0, 0($t2)             
  806094:	8d480000 	lw	t0,0(t2)
          lw    $t3, 12($t0)            
  806098:	8d0b000c 	lw	t3,12(t0)
          sw    $t1, -8($fp)            
  80609c:	afc9fff8 	sw	t1,-8(s8)
          sw    $t2, -12($fp)           
  8060a0:	afcafff4 	sw	t2,-12(s8)
          jalr  $t3                     
  8060a4:	0160f809 	jalr	t3
  8060a8:	00000000 	nop
          lw    $t1, -8($fp)            
  8060ac:	8fc9fff8 	lw	t1,-8(s8)
          lw    $t2, -12($fp)           
  8060b0:	8fcafff4 	lw	t2,-12(s8)
          sw    $t1, -8($fp)            
  8060b4:	afc9fff8 	sw	t1,-8(s8)
          sw    $t2, -12($fp)           
  8060b8:	afcafff4 	sw	t2,-12(s8)

008060bc <_L373>:
_L373:                                  
          lw    $t0, -8($fp)            
  8060bc:	8fc8fff8 	lw	t0,-8(s8)
          beqz  $t0, _L375              
  8060c0:	11000018 	beqz	t0,806124 <_L375>
  8060c4:	00000000 	nop

008060c8 <_L374>:
_L374:                                  
          lw    $t0, -12($fp)           
  8060c8:	8fc8fff4 	lw	t0,-12(s8)
          move  $a0, $t0                
  8060cc:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  8060d0:	afa80004 	sw	t0,4(sp)
          lw    $t1, 0($t0)             
  8060d4:	8d090000 	lw	t1,0(t0)
          lw    $t2, 32($t1)            
  8060d8:	8d2a0020 	lw	t2,32(t1)
          sw    $t0, -12($fp)           
  8060dc:	afc8fff4 	sw	t0,-12(s8)
          jalr  $t2                     
  8060e0:	0140f809 	jalr	t2
  8060e4:	00000000 	nop
          lw    $t0, -12($fp)           
  8060e8:	8fc8fff4 	lw	t0,-12(s8)
          la    $t1, _STRING36          
  8060ec:	3c090080 	lui	t1,0x80
  8060f0:	25297329 	addiu	t1,t1,29481
          move  $a0, $t1                
  8060f4:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  8060f8:	afa90004 	sw	t1,4(sp)
          sw    $t0, -12($fp)           
  8060fc:	afc8fff4 	sw	t0,-12(s8)
          jal   _Main.GetYesOrNo        
  806100:	0c201868 	jal	8061a0 <_Main.GetYesOrNo>
  806104:	00000000 	nop
          move  $t1, $v0                
  806108:	00404821 	move	t1,v0
          lw    $t0, -12($fp)           
  80610c:	8fc8fff4 	lw	t0,-12(s8)
          move  $t2, $t1                
  806110:	01205021 	move	t2,t1
          sw    $t2, -8($fp)            
  806114:	afcafff8 	sw	t2,-8(s8)
          sw    $t0, -12($fp)           
  806118:	afc8fff4 	sw	t0,-12(s8)
          b     _L373                   
  80611c:	1000ffe7 	b	8060bc <_L373>
  806120:	00000000 	nop

00806124 <_L375>:
_L375:                                  
          lw    $t0, -12($fp)           
  806124:	8fc8fff4 	lw	t0,-12(s8)
          move  $a0, $t0                
  806128:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  80612c:	afa80004 	sw	t0,4(sp)
          lw    $t1, 0($t0)             
  806130:	8d090000 	lw	t1,0(t0)
          lw    $t0, 28($t1)            
  806134:	8d28001c 	lw	t0,28(t1)
          jalr  $t0                     
  806138:	0100f809 	jalr	t0
  80613c:	00000000 	nop
          la    $t0, _STRING37          
  806140:	3c080080 	lui	t0,0x80
  806144:	25087137 	addiu	t0,t0,28983
          move  $a0, $t0                
  806148:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  80614c:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  806150:	0c2001d8 	jal	800760 <_PrintString>
  806154:	00000000 	nop
          la    $t0, _STRING38          
  806158:	3c080080 	lui	t0,0x80
  80615c:	250871cb 	addiu	t0,t0,29131
          move  $a0, $t0                
  806160:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  806164:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  806168:	0c2001d8 	jal	800760 <_PrintString>
  80616c:	00000000 	nop
          la    $t0, _STRING39          
  806170:	3c080080 	lui	t0,0x80
  806174:	250872e9 	addiu	t0,t0,29417
          move  $a0, $t0                
  806178:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  80617c:	afa80004 	sw	t0,4(sp)
          jal   _PrintString            
  806180:	0c2001d8 	jal	800760 <_PrintString>
  806184:	00000000 	nop
          move  $v0, $zero              
  806188:	00001021 	move	v0,zero
          move  $sp, $fp                
  80618c:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  806190:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  806194:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  806198:	03e00008 	jr	ra
  80619c:	00000000 	nop

008061a0 <_Main.GetYesOrNo>:

_Main.GetYesOrNo:                       # function entry
          sw $fp, 0($sp)                
  8061a0:	afbe0000 	sw	s8,0(sp)
          sw $ra, -4($sp)               
  8061a4:	afbffffc 	sw	ra,-4(sp)
          move $fp, $sp                 
  8061a8:	03a0f021 	move	s8,sp
          addiu $sp, $sp, -16           
  8061ac:	27bdfff0 	addiu	sp,sp,-16

008061b0 <_L376>:
_L376:                                  
          lw    $t0, 4($fp)             
  8061b0:	8fc80004 	lw	t0,4(s8)
          move  $a0, $t0                
  8061b4:	01002021 	move	a0,t0
          sw    $t0, 4($sp)             
  8061b8:	afa80004 	sw	t0,4(sp)
          sw    $t0, 4($fp)             
  8061bc:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  8061c0:	0c2001d8 	jal	800760 <_PrintString>
  8061c4:	00000000 	nop
          lw    $t0, 4($fp)             
  8061c8:	8fc80004 	lw	t0,4(s8)
          la    $t1, _STRING28          
  8061cc:	3c090080 	lui	t1,0x80
  8061d0:	25297384 	addiu	t1,t1,29572
          move  $a0, $t1                
  8061d4:	01202021 	move	a0,t1
          sw    $t1, 4($sp)             
  8061d8:	afa90004 	sw	t1,4(sp)
          sw    $t0, 4($fp)             
  8061dc:	afc80004 	sw	t0,4(s8)
          jal   _PrintString            
  8061e0:	0c2001d8 	jal	800760 <_PrintString>
  8061e4:	00000000 	nop
          lw    $t0, 4($fp)             
  8061e8:	8fc80004 	lw	t0,4(s8)
          sw    $t0, 4($fp)             
  8061ec:	afc80004 	sw	t0,4(s8)
          jal   _ReadInteger            
  8061f0:	0c20023f 	jal	8008fc <_ReadInteger>
  8061f4:	00000000 	nop
          move  $t1, $v0                
  8061f8:	00404821 	move	t1,v0
          lw    $t0, 4($fp)             
  8061fc:	8fc80004 	lw	t0,4(s8)
          li    $t2, 0                  
  806200:	240a0000 	li	t2,0
          sne   $t3, $t1, $t2           
  806204:	012a5826 	xor	t3,t1,t2
  806208:	000b582b 	sltu	t3,zero,t3
          sw    $t0, 4($fp)             
  80620c:	afc80004 	sw	t0,4(s8)
          move  $v0, $t3                
  806210:	01601021 	move	v0,t3
          move  $sp, $fp                
  806214:	03c0e821 	move	sp,s8
          lw    $ra, -4($fp)            
  806218:	8fdffffc 	lw	ra,-4(s8)
          lw    $fp, 0($fp)             
  80621c:	8fde0000 	lw	s8,0(s8)
          jr    $ra                     
  806220:	03e00008 	jr	ra
  806224:	00000000 	nop
	...
