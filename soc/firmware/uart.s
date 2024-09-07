.section .text
.global _start

.equ SPI_FLASH, 0x00000000
.equ ALICE,     0x00100000
.equ UART, 0x80000000
.equ LEDS, 0x40000000

_start:
    li sp, SPI_FLASH
    li gp, UART
    li t2, LEDS
    li t1, 0
    li t4, ALICE
    li t5, 1

.loop:
.read_char:
    lb t1, 0(t4)
    addi t4, t4, 1

#    sw t1, 0(t2)
    sw t1, 0(gp)
#    call wait
    j .loop

wait:
    li t3, 10000
.loop2:
    addi t3, t3, -1
    bnez t3, .loop2
    ret
