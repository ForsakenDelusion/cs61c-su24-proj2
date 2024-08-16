.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int arrays
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the number of elements to use
#   a3 (int)  is the stride of arr0
#   a4 (int)  is the stride of arr1
# Returns:
#   a0 (int)  is the dot product of arr0 and arr1
# Exceptions:
#   - If the number of elements to use is less than 1,
#     this function terminates the program with error code 36
#   - If the stride of either array is less than 1,
#     this function terminates the program with error code 37
# =======================================================
dot:

    # Prologue
    addi t0 x0 1
    blt a2 t0 err_num
    blt a3 t0 err_stride
    blt a4 t0 err_stride
    
    # beacause the first elem(index 0) always be selected, so we need use the length minus 1 to get the rest of length which can be actually used
    li t4 0
    # the smaller value between t1 and t2 is assigned to t1 as a counter
    addi t1 a2 -1
    slli a3 a3 2 # each step of arr0
    slli a4 a4 2 # each step unit of arr1
    lw t5 0(a0)
    lw t6 0(a1)
    mul t4 t5 t6
loop_start:
    addi t1 t1 -1
    blt t1 zero loop_end
    add a0 a0 a3 # offset of arr0
    add a1 a1 a4 # offset of arr1
    lw t5 0(a0)
    lw t6 0(a1)
    mul t2 t5 t6
    add t4 t4 t2
    j loop_start
    
loop_end:


    # Epilogue
    mv a0 t4

    jr ra
    
    
err_num:
    addi a0 x0 36
    j exit

err_stride:
    addi a0 x0 37
    j exit
    