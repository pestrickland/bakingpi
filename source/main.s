.section .init
.globl _start
_start:

ldr r0, =0x20200000  @ Load value into r0 (hex).
mov r1, #1  @ Move value into r1 (dec). Use mov because it's faster, but it can only be used for certain values.
lsl r1, #18  @ Shift r1 left by 18 (i.e. 1 -> 100 0000 0000 0000 0000).
str r1, [r0, #4]  @ Store value of r1 into the address computed by the sum of r0 and #4.

mov r1, #1  
lsl r1, #16  @ Left shift r1 by 16.
loop$:
str r1, [r0, #40]  @ Compute sum of r0 and 40 to offset r0 address. Store result in r1. Turns LED on.

mov r2, #0x3F0000  @ Move value into r2.

wait1$:
sub r2, #1  @ Subtract 1 from r2?
cmp r2, #0  @ Compare r2 with zero.
bne wait1$  @ Branch if not equal -- loop back until zero is reached.

str r1, [r0, #28]  @ Store r0 offset of 28 in r1. Turns LED off.
mov r2, #0x3F0000  @ Move value into r2.

wait2$:
sub r2, #1  @ Subtract 1 from r2?
cmp r2, #0  @ Compare r2 with zero.
bne wait2$  @ Branch if not equal -- loop back until zero is reached.

b loop$





