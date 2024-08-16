.globl argmax

.text
# =================================================================
# FUNCTION: Given a int array, return the index of the largest
#   element. If there are multiple, return the one
#   with the smallest index.
# Arguments:
#   a0 (int*) is the pointer to the start of the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   a0 (int)  is the first index of the largest element
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# =================================================================
argmax:
    # Prologue
    ebreak
    addi t0 x0 1
    blt a1 t0 error_exit
    addi t0 x0 0 #t0 is counter
    addi t1 x0 0 #t1 is offset
    lw t3 0(a0) 
    mv t4 t0
loop_start:
    add t2 a0 t1
    lw t2 0(t2)
    bge t3 t2 loop_continue
    mv t3 t2
    mv t4 t0

loop_continue:
    addi t1 t1 4
    addi t0 t0 1
    blt t0 a1 loop_start

loop_end:
    # Epilogue
    mv a0 t4
    
    jr ra
    
error_exit:

    li a0 36
    j exit
