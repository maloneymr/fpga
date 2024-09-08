.section .text
.global _start

.equ SPI_FLASH, 0x00000000
.equ ALICE,     0x00100000
.equ UART, 0x80000000
.equ LEDS, 0x40000000

.equ RED,   1
.equ GREEN, 2
.equ BLUE,  4

_start:
    li sp, SPI_FLASH
    li gp, UART
    li t2, LEDS

    li t1, RED
    ebreak
    sb t1, 0(t2)

    j halt


halt:
    j halt
