.globl transform

#define DUT_MAGIC_WORD      0xF00DFEED
#define DUT_CONFIG_ADDR     0x10000000
#define FINAL_STATE         0x0A

transform:
    # store the context
    addi sp, sp, -36
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)
    sw t3, 16(sp)
    sw a0, 20(sp)
    sw a1, 24(sp)
    sw a2, 28(sp)
    sw a3, 32(sp)

    li t0, DUT_CONFIG_ADDR
    li t1, DUT_MAGIC_WORD
    # write magic word
    sw t1, 0(t0)
    # write src
    sw a0, 0(t0)
    # write dst
    sw a1, 0(t0)
    # write len
    sw a2, 0(t0)
    # write func
    sw a3, 0(t0)

    # load expect state
    li t2, FINAL_STATE

    # loop to read state
begin:
    lw t3, 0(t0)
    beq t2, t3, end
    jal begin
end:

    # write magic word to restore state to idle
    sw t1, 0(t0)

    # restore the saved context
    lw ra, 0(sp)
    lw t0, 4(sp)
    lw t1, 8(sp)
    lw t2, 12(sp)
    lw t3, 16(sp)
    lw a0, 20(sp)
    lw a1, 24(sp)
    lw a2, 28(sp)
    lw a3, 32(sp)
    addi sp, sp, 36
    ret
