addi x12,x0,12
addi x13,x0,13
addi x1,x0,1
add  x2,x1,x1
add  x3,x2,x1
lw   x4,0(x12)
addi x4,x4,1;Data Hazard
addi x4,x4,-1
jal  x10,main
addi x15,x0,-1 ;
main:
addi x14,x10,10
addi x14,x14,10
addi x14,x14,10
addi x5,x0,15;
and  x6,x5,x4;
or   x7,x5,x4;
xor  x8,x5,x4;
addi x5,x0,1
loop:
sll  x2,x2,x1
srl  x3,x3,x1
blt  x2,x12,loop
sw   x2,0(x12)
sub  x13,x13,x1
beq  x12,x13,eq
addi x15,x0,-1
eq:
;Register
addi x2,x0,1
sll  x2,x2,x1
add x2,x0,x2
sll  x2,x2,x1
add x2,x0,x2
add x2,x0,x2
sll  x2,x2,x1
add x2,x0,x2
add x2,x0,x2
add x2,x0,x2
sll  x2,x2,x1
add x2,x0,x2
add x2,x0,x2
add x2,x0,x2
add x2,x0,x2
sll  x2,x2,x1
sll  x2,x2,x1

andi x15,x0,1

addi x15,x0,1
