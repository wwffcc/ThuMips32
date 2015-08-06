
bios.elf:     file format elf32-tradlittlemips


Disassembly of section .text:

bfc00000 <_ftext>:
bfc00000:	3c1d8070 	lui	sp,0x8070
bfc00004:	3c08bfd0 	lui	t0,0xbfd0
bfc00008:	350803f8 	ori	t0,t0,0x3f8
bfc0000c:	ad000000 	sw	zero,0(t0)
bfc00010:	0ff00008 	jal	bfc00020 <biosmain>
bfc00014:	00000000 	nop

bfc00018 <spin>:
bfc00018:	0bf00006 	j	bfc00018 <spin>
bfc0001c:	00000000 	nop

bfc00020 <biosmain>:
bfc00020:	27bdffe0 	addiu	sp,sp,-32
bfc00024:	3c02be00 	lui	v0,0xbe00
bfc00028:	3c06c270 	lui	a2,0xc270
bfc0002c:	afbf001c 	sw	ra,28(sp)
bfc00030:	24430034 	addiu	v1,v0,52
bfc00034:	8c450000 	lw	a1,0(v0)
bfc00038:	00462021 	addu	a0,v0,a2
bfc0003c:	24420004 	addiu	v0,v0,4
bfc00040:	ac850000 	sw	a1,0(a0)
bfc00044:	1443fffb 	bne	v0,v1,bfc00034 <biosmain+0x14>
bfc00048:	00000000 	nop
bfc0004c:	3c038070 	lui	v1,0x8070
bfc00050:	3c02464c 	lui	v0,0x464c
bfc00054:	8c640000 	lw	a0,0(v1)
bfc00058:	2442457f 	addiu	v0,v0,17791
bfc0005c:	10820003 	beq	a0,v0,bfc0006c <biosmain+0x4c>
bfc00060:	00000000 	nop
bfc00064:	0bf00047 	j	bfc0011c <biosmain+0xfc>
bfc00068:	00000000 	nop
bfc0006c:	8c62001c 	lw	v0,28(v1)
bfc00070:	9465002c 	lhu	a1,44(v1)
bfc00074:	00621021 	addu	v0,v1,v0
bfc00078:	00052940 	sll	a1,a1,0x5
bfc0007c:	00452821 	addu	a1,v0,a1
bfc00080:	3c063d90 	lui	a2,0x3d90
bfc00084:	3c07be00 	lui	a3,0xbe00
bfc00088:	0045182b 	sltu	v1,v0,a1
bfc0008c:	1060001d 	beqz	v1,bfc00104 <biosmain+0xe4>
bfc00090:	00000000 	nop
bfc00094:	24440020 	addiu	a0,v0,32
bfc00098:	00401821 	move	v1,v0
bfc0009c:	0064402b 	sltu	t0,v1,a0
bfc000a0:	11000007 	beqz	t0,bfc000c0 <biosmain+0xa0>
bfc000a4:	00000000 	nop
bfc000a8:	00664021 	addu	t0,v1,a2
bfc000ac:	8d080000 	lw	t0,0(t0)
bfc000b0:	24630004 	addiu	v1,v1,4
bfc000b4:	ac68fffc 	sw	t0,-4(v1)
bfc000b8:	0bf00027 	j	bfc0009c <biosmain+0x7c>
bfc000bc:	00000000 	nop
bfc000c0:	8c430008 	lw	v1,8(v0)
bfc000c4:	8c490014 	lw	t1,20(v0)
bfc000c8:	8c420004 	lw	v0,4(v0)
bfc000cc:	00694821 	addu	t1,v1,t1
bfc000d0:	00e21021 	addu	v0,a3,v0
bfc000d4:	0069402b 	sltu	t0,v1,t1
bfc000d8:	11000007 	beqz	t0,bfc000f8 <biosmain+0xd8>
bfc000dc:	00000000 	nop
bfc000e0:	8c480000 	lw	t0,0(v0)
bfc000e4:	24630004 	addiu	v1,v1,4
bfc000e8:	ac68fffc 	sw	t0,-4(v1)
bfc000ec:	24420004 	addiu	v0,v0,4
bfc000f0:	0bf00035 	j	bfc000d4 <biosmain+0xb4>
bfc000f4:	00000000 	nop
bfc000f8:	00801021 	move	v0,a0
bfc000fc:	0bf00022 	j	bfc00088 <biosmain+0x68>
bfc00100:	00000000 	nop
bfc00104:	3c028070 	lui	v0,0x8070
bfc00108:	8c590018 	lw	t9,24(v0)
bfc0010c:	0320f809 	jalr	t9
bfc00110:	00000000 	nop
bfc00114:	0bf00019 	j	bfc00064 <biosmain+0x44>
bfc00118:	00000000 	nop
bfc0011c:	0bf00047 	j	bfc0011c <biosmain+0xfc>
bfc00120:	00000000 	nop
	...
