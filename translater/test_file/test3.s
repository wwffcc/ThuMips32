addiu $11,$0,2
addiu $12,$0,1
L1:
subu  $11,$11,$12
beq   $11,$12,L1
bgez  $12,L1