.globl classify

.text
# =====================================
# COMMAND LINE ARGUMENTS
# =====================================
# Args:
#   a0 (int)        argc
#   a1 (char**)     argv
#   a1[1] (char*)   pointer to the filepath string of m0
#   a1[2] (char*)   pointer to the filepath string of m1
#   a1[3] (char*)   pointer to the filepath string of input matrix
#   a1[4] (char*)   pointer to the filepath string of output file
#   a2 (int)        silent mode, if this is 1, you should not print
#                   anything. Otherwise, you should print the
#                   classification and a newline.
# Returns:
#   a0 (int)        Classification
# Exceptions:
#   - If there are an incorrect number of command line args,
#     this function terminates the program with exit code 31
#   - If malloc fails, this function terminates the program with exit code 26
#
# Usage:
#   main.s <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>
classify:
    addi sp sp -36
    sw ra 0(sp)
    sw s0 4(sp) # save the a1 arr
    sw s1 8(sp) # m0
    sw s2 12(sp) # m1
    sw s3 16(sp) # input
    sw s4 20(sp) # h
    sw s5 24(sp) # o
    sw s6 28(sp) # whether printable
    sw s7 32(sp)
    
    li t0 5
    bne a0 t0 num_err
    
    mv s0 a1
    mv s6 a2
    # Read pretrained m0
    lw t0 4(s0) # the file path of m0
    mv a0 t0
    
    addi sp sp -40 # to store row and col
    
    addi a1 sp 0 # m0.row
    addi a2 sp 4 # m0.col
    
    call read_matrix
    
    mv s1 a0
    ebreak
    # Read pretrained m1
    lw t0 8(s0) # the file path of m1
    mv a0 t0
    
    addi a1 sp 8 # m1.row
    addi a2 sp 12 # m1.col
    
    call read_matrix
    
    mv s2 a0
    ebreak


    # Read input matrix
    lw t0 12(s0) # the file path of input
    mv a0 t0
    
    addi a1 sp 16 # input.row
    addi a2 sp 20 # input.col
    
    call read_matrix
    
    mv s3 a0
    ebreak


    # Compute h = matmul(m0, input)
    lw t0 0(sp) # t0 = m0.row
    lw t1 20(sp) # t1 = input.col
    sw t0 24(sp) # h.row
    sw t1 28(sp) # h.col
    
    mul t0 t0 t1
    slli t0 t0 2
    mv a0 t0
    
    call malloc
    
    beq a0 x0 malloc_err
    mv s4 a0 # pointer to h !!! need free !!!
    
    mv a0 s1
    mv a3 s3
    lw a1 0(sp)
    lw a2 4(sp)
    lw a4 16(sp)
    lw a5 20(sp)
    mv a6 s4
    
    call matmul
    
    # Compute h = relu(h)
    mv a0 s4
    lw t0 24(sp)
    lw t1 28(sp)
    mul t0 t0 t1
    mv a1 t0
    
    call relu
    
    # Compute o = matmul(m1, h)
    lw t0 8(sp)
    lw t1 28(sp)
    sw t0 32(sp) # o.row
    sw t1 36(sp) # o.col
    ebreak
    mul t0 t0 t1
    slli t0 t0 2
    mv a0 t0
    
    call malloc
    
    beq a0 x0 malloc_err
    mv s5 a0 # pointer to o !!! need free !!!
    
    mv a0 s2
    mv a3 s4
    lw a1 8(sp)
    lw a2 12(sp)
    lw a4 24(sp)
    lw a5 28(sp)
    mv a6 s5
    
    call matmul

    # Write output matrix o
    
    lw a0 16(s0)
    mv a1 s5
    lw a2 32(sp)
    lw a3 36(sp)
    
    call write_matrix

    # Compute and return argmax(o)
    
    mv a0 s5
    lw t0 32(sp)
    lw t1 36(sp)
    addi sp sp 40
    mul t0 t0 t1
    mv a1 t0
    
    call argmax
    
    mv s7 a0
    ebreak
    
    # If enabled, print argmax(o) and newline
    bne s6 x0 not_print
    call print_int
    li a0 '\n'
    call print_char
    
not_print:
  
    # free
    mv a0 s4
    call free
    mv a0 s5
    call free
    
    mv a0 s7
    #e
    lw s7 32(sp)
    lw s6 28(sp)
    lw s5 24(sp)
    lw s4 20(sp)
    lw s3 16(sp)
    lw s2 12(sp)
    lw s1 8(sp)
    lw s0 4(sp)
    lw ra 0(sp)
    addi sp sp 36
    
    jr ra
    
malloc_err:
    li a0 26
    j exit

num_err:
    li a0 31
    j exit
