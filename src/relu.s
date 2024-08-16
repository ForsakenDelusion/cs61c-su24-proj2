.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
#   a0 (int*) is the pointer to the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   None
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# ==============================================================================
relu:
    # Prologue
    ebreak
    addi t0 x0 1
    blt a1 t0 error_exit
    addi t1 x0 0 #t1 is the counter
    addi t2 x0 0 #t2 is the offset
loop_start:
    addi t3 x0 0 #t3 is the value of array[i]
    add t4 x0 a0 #t4 is the bAddr
    slli t2 t1 2
    add t4 t4 t2 #get the bAddr + offset
    lw t3  0(t4)
    blt t3 zero loop_continue
    addi t1 t1 1
    blt t1 a1 loop_start
    j loop_end
    
loop_continue:
    sw x0 0(t4)
    blt t1 a1 loop_start

loop_end:


    # Epilogue


    jr ra
    
error_exit:
    li a0 36
    j exit
