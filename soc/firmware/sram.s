.section .text
.global _start

.equ SPI_FLASH, 0x00000000
.equ ALICE,     0x00100000
.equ UART, 0x80000000
.equ LEDS, 0x40000000
.equ RAM,  0x20000000

.equ RED, 0x1
.equ GREEN, 0x2
.equ BLUE, 0x4

_start:
    li gp, UART
    li t1, 'a'

.loop:
    sw t1, 0(sp)
    lw t2, 0(sp)

    sb t2, 0(gp)
    addi sp, sp, 0x4

    j .loop

#    sb zero, 0(gp)
#    sb zero, 0(gp)
#    sb zero, 0(gp)
#    sb zero, 0(gp)

#    sb t2, 0(gp)

#    srl t2, t2, 8
#    sb t2, 0(gp)
#
#    srl t2, t2, 8
#    sb t2, 0(gp)
#
#    srl t2, t2, 8
#    sb t2, 0(gp)

    j halt


wait:
    li t3, 30000
.loop2:
    addi t3, t3, -1
    bnez t3, .loop2
    ret


halt:
    j halt
