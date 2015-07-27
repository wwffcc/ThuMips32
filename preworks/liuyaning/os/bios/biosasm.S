.globl start
start:
    li      $sp, 0x80700000
    li      $t0, 0xbfd003f8
    sw      $zero, 0($t0)
    jal     biosmain
spin:
    j       spin
