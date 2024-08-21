.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is the pointer to the start of the matrix in memory
#   a2 (int)   is the number of rows in the matrix
#   a3 (int)   is the number of columns in the matrix
# Returns:
#   None
# Exceptions:
#   - If you receive an fopen error or eof,
#     this function terminates the program with error code 27
#   - If you receive an fclose error or eof,
#     this function terminates the program with error code 28
#   - If you receive an fwrite error or eof,
#     this function terminates the program with error code 30
# ==============================================================================
write_matrix:

    # Prologue
    addi sp sp -20
    sw s0 0(sp) # file descriptor
    sw s1 4(sp) # matrix mem
    sw s2 8(sp) # row
    sw s3 12(sp) # col
    sw ra 16(sp)
    
    # fill saved reg
    mv s1 a1
    mv s2 a2
    mv s3 a3

    
    # fopen
    li a1 1
    call fopen
    li t0 -1
    beq a0 t0 fopen_err
    mv s0 a0 # now s0 store the file descriptor
    
    # The fwrite function expects a pointer to data in memory, so you should first store the data to memory, and then pass a pointer to the data to fwrite
    
    # fwrite
    
    # we need write the row and col first
    
    addi sp sp -8
    sw s2 0(sp)
    sw s3 4(sp)
    
    mv a0 s0
    mv a1 sp
    li a2 2
    li a3 4
    
    call fwrite
    
    addi sp sp 8
    li t0 2
    bne a0 t0 fwrite_err
    
    # then we can write data
    

    mv a0 s0
    mv a1 s1
    mul t0 s2 s3
    mv a2 t0
    li a3 4
    addi sp sp -4
    sw t0 0(sp)
    
    call fwrite
    
    lw t0 0(sp)
    addi sp sp 4
    
    bne a0 t0 fwrite_err
    
    # fclose
    
    mv a0 s0
    
    call fclose
    
    li t0 -1
    
    beq a0 t0 fclose_err
    

    # Epilogue
    lw ra 16(sp)
    lw s3 12(sp)
    lw s2 8(sp)
    lw s1 4(sp)
    lw s0 0(sp)
    addi sp sp 20

    jr ra

fopen_err:
    li a0 27
    j exit
    
fwrite_err:
    li a0 30
    j exit
    
fclose_err:
    li a0 28
    j exit
    