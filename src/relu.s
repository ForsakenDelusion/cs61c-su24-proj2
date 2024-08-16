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
    mv t1 a1 #t1 is the length of array
    addi t2 x0 0 #t2 is the counter
    addi t3 x0 0 #t3 is the offset
loop_start:
    addi t4 x0 0 #t4 is the value of array[i]
    add t5 x0 a0 #t5 is the bAddr
    slli t3 t2 2
    add t5 t5 t3 #get the bAddr + offset
    lw t4  0(t5)
    blt t4 zero loop_continue
    addi t2 t2 1
    blt t2 a1 loop_start
    j loop_end
    
loop_continue:
    sw x0 0(t5)
    blt t2 a1 loop_start

loop_end:


    # Epilogue


    jr ra
    
error_exit:
    li a0 36
    j exit
