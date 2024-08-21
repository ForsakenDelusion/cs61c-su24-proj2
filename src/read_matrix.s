.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
# Exceptions:
#   - If malloc returns an error,
#     this function terminates the program with error code 26
#   - If you receive an fopen error or eof,
#     this function terminates the program with error code 27
#   - If you receive an fclose error or eof,
#     this function terminates the program with error code 28
#   - If you receive an fread error or eof,
#     this function terminates the program with error code 29
# ==============================================================================
read_matrix:
    
    # Prologue
    ebreak

    # Prologue
    addi sp sp -24
    sw ra 0(sp)
    sw s0 4(sp)
    sw s1 8(sp)
    sw s2 12(sp)
    sw s3 16(sp)
    sw s4 20(sp)

    # save the addr of row and col
    mv s1 a1
    mv s2 a2

    # open file
    mv a1 x0  # a1 = 0;
    call fopen
    addi t0 x0 -1
    beq a0 t0 fopen_err
    # save *fd to s0
    mv s0 a0

    # read row and col
    mv a1 s1    # the addr of row
    mv a0 s0    # *fd
    addi t0 x0 4 
    mv a2 t0  # a2 = 1
    call fread
    addi t0 x0 4
    bne a0 t0 fread_err

    mv a1 s2    # the addr of col
    mv a0 s0    # *fd
    addi t0 x0 4
    mv a2 t0  # a2 = 1
    call fread
    addi t0 x0 4
    bne a0 t0 fread_err

    ebreak
    # malloc space
    lw t0 0(s1)   # row
    lw t1 0(s2)   # col
    mul a0 t0 t1
    slli a0 a0 2  # a0 = t2*4;
    mv s4 a0
    call malloc
    beq a0 x0 malloc_err
    # save the addr of space
    mv s3 a0

    # read the matrix
    mv a0 s0
    mv a1 s3
    mv a2 s4

    call fread

    bne a0 s4 fread_err

    # close the file
    mv a0 s0
    call fclose
    bne a0 x0 fclose_err

    # final
    mv a0 s3
    # Epilogue
    lw s4 20(sp)
    lw s3 16(sp)
    lw s2 12(sp)
    lw s1 8(sp)
    lw s0 4(sp)
    lw ra 0(sp)
    addi sp sp 24


    jr ra

malloc_err:
    addi a0 x0 26
    j exit
    
fopen_err:
    addi a0 x0 27
    j exit

fclose_err:
    addi a0 x0 28
    j exit
    
fread_err:
    addi a0 x0 29
    j exit