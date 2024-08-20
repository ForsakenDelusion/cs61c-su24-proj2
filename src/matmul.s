.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
#   d = matmul(m0, m1)
# Arguments:
#   a0 (int*)  is the pointer to the start of m0
#   a1 (int)   is the # of rows (height) of m0
#   a2 (int)   is the # of columns (width) of m0
#   a3 (int*)  is the pointer to the start of m1
#   a4 (int)   is the # of rows (height) of m1
#   a5 (int)   is the # of columns (width) of m1
#   a6 (int*)  is the pointer to the the start of d
# Returns:
#   None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 38
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 38
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 38
# =======================================================
matmul:

    # Error checks
    li t0 1
    blt a1 t0 err
    blt a2 t0 err
    blt a4 t0 err
    blt a5 t0 err
    bne a2 a4 err

    # Prologue
    
    #save the s0 and s1
    addi sp sp -12
    sw s0 0(sp)
    sw s1 4(sp)
    sw ra 8(sp)
    
    mv t0 a0
    mv t1 a1
    mv t2 a2
    mv t3 a3
    mv t4 a4
    mv t5 a5
    
    #set the arguement of dot
    
    addi s0 x0 0 # set the counter i
    addi s1 x0 0 # set the counter j
    slli t6 t2 2
    

outer_loop_start:


inner_loop_start:
    
    
    
    
    #set arguement for dot
    mv a0 t0
    mv a1 a3
    mv a2 t2
    li a3 1
    mv a4 a5
    
    #prepar for call dot
    addi sp sp -28
    sw t0 0(sp)
    sw t1 4(sp)
    sw t2 8(sp)
    sw t3 12(sp)
    sw t4 16(sp)
    sw t5 20(sp)
    sw t6 24(sp)
    
    call dot
    
    lw t6 24(sp)
    lw t5 20(sp)
    lw t4 16(sp)
    lw t3 12(sp)
    lw t2 8(sp)
    lw t1 4(sp)
    lw t0 0(sp)
    addi sp sp 28

    sw a0 0(a6)
    addi a6 a6 4 # d next
    
    addi s1 s1 1
    slli a2 s1 2
    add a3 t3 a2 # find the next
    
    
    blt s1 t5 inner_loop_start


inner_loop_end:
    mv a3 t3
    add t0 t0 t6
    addi s0 s0 1
    li s1 0
    blt s0 t1 outer_loop_start


outer_loop_end:


    # Epilogue
    lw ra 8(sp)
    lw s1 4(sp)
    lw s0 0(sp)
    addi sp sp 12

    jr ra
    
err:
    addi a0 x0 38
    j exit
