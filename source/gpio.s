.globl GetGpioAddress
GetGpioAddress:
ldr r0,=0x20200000
mov pc,lr  // Copy value in lr (the address to return to)
           // to pc (program counter -- next instruction to run).

.globl SetGpioFunction
SetGpioFunction:
cmp r0,#53  // Check whether r0 <= 53 (to ensure a valid pin is specified).
cmpls r1,#7  // If the line above is true, check that r1 <= 7 (to ensure a valid pin function).
movhi pc,lr  // End function (go back to lr by setting pc) if r0>53 or r1>7.
push {lr}  // Copy value in lr to top of stack.
mov r2,r0
bl GetGpioAddress  // Branch to label GetGpioAddress

functionLoop$:
    cmp r2,#9
    subhi r2,#10
    addhi r0,#4
    bhi functionLoop$

add r2, r2,lsl #1  // Multiply r2 by 3 (r2 + r2 x 2 (left shift by 1)).
lsl r1,r2  // Left shift r1 by the value of r2.
str r1,[r0]  // Store r1 at the address of r0.
pop {pc}

.globl SetGpio
SetGpio:
pinNum .req r0  // Creates the alias pinNum for r0.
pinVal .req r1  // pinVal means r1.

cmp pinNum,#53  // Compare pinNum with 53, returning if greater than 53.
movhi pc,lr  // If greater than 53, move lr to pc.
push {lr}  // Push lr onto the stack.
mov r2,pinNum  // Copy pinNum to r2.
.unreq pinNum  // Unset alias from r0.
pinNum .req r2  // Replace alias from r0 with one for r2.
bl GetGpioAddress  // Call GetGpioAddress.
gpioAddr .req r0  // Name r0 `gpioAddr` to create alias for GPIO address.

pinBank .req r3
lsr pinBank,pinNum,#5
lsl pinBank,#2
add gpioAddr,pinBank
.unreq pinBank

