
/*vectors.s*/

.globl _start
_start:

    mov sp,#0x83000000
    bl notmain
hang:   b .

.globl mid
mid:
    MRC p15, 0, r0, c0, c0, 0 ;@ Read Main ID Register
    bx lr

.globl mpid
mpid:
    MRC p15, 0, r0, c0, c0, 5 ;@ Read Multiprocessor ID Register
    bx lr

.globl pfeat0
pfeat0:
    MRC p15, 0, r0, c0, c1, 0 ;@ Read Processor Feature Register 0
    bx lr

.globl pfeat1
pfeat1:
    MRC p15, 0, r0, c0, c1, 1 ;@ Read Processor Feature Register 1
    bx lr

.globl fpsid
fpsid:
    ;@ enable fpu
    mrc p15, 0, r0, c1, c0, 2
    orr r0,r0,#0x300000 ;@ single precision
    orr r0,r0,#0xC00000 ;@ double precision
    mcr p15, 0, r0, c1, c0, 2
    mov r0,#0x40000000
    fmxr fpexc,r0
    fmrx r0,fpsid
    bx lr

.globl jazid
jazid:
    MRC p14, 7, r0, c0, c0, 0 ;@ Read Jazelle Identity Register
    bx lr

.globl jazmc
jazmc:
    MRC p14, 7, r0, c2, c0, 0 ;@ Read Main Configuration Register
    bx lr

.globl jazosc
jazosc:
    MRC p14, 7, r0, c1, c0, 0 ;@ Read OS Control Register
    bx lr

.globl bxjtest
bxjtest:
    ldr r0,=skip
    bxj r0
    mov r0,#1
    bx lr
skip:
    mov r0,#2
    bx lr

.globl idisar1
idisar1:
    MRC p15, 0, r0, c0, c2, 1 ;@ Read ID_ISAR1 into Rt
    bx lr

.globl jidr
jidr:
    MRC p14, 7, r0, c0, c0, 0 ;@ Read JIDR into Rt
    bx lr

.globl jmcr
jmcr:
    mov r1,#1
    MCR p14, 7, r1, c2, c0, 0;@ Write Rt to JMCR
    MRC p14, 7, r0, c2, c0, 0;@ Read JMCR into Rt
    bx lr


.globl dummy
dummy:
    bx lr

.globl PUT8
PUT8:
    strb r1,[r0]
    bx lr

.globl GET8
GET8:
    ldrb r0,[r0]
    bx lr

.globl PUT16
PUT16:
    strh r1,[r0]
    bx lr

.globl GET16
GET16:
    ldrh r0,[r0]
    bx lr


.globl PUT32
PUT32:
    str r1,[r0]
    bx lr

.globl GET32
GET32:
    ldr r0,[r0]
    bx lr
