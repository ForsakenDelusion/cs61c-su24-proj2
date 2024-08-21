# 61C Project 2: CS61Classify

## Task1

绝对值函数

错误很好改，以至于我再改第一个错误的时候直接把内存错误改了，输-mc半天没反应我还以为我的版本有问题。

## Task2

该函数是将所有的负数都变成0

>The ReLU function takes in an integer array and sets every negative value in the array to 0. Positive values in the array are unchanged. In other words, for each element x in the array, ReLU computes max(x, 0).

感觉主要考察了branch，细心一点就行，和lab03有点像

## Task3

该函数是返回一个数组中最大的数字下标

写完前两个task感觉这个没什么特别需要注意的地方

## Task4

是关于向量点乘(Dot Prodcut)的

```txt
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
```



### Array Strides

这个其实就是决定数组中隔几个元素被选中，比如stride为2，那么数组中的0，2，4，6...就会被选中；stride为3，0,3,6,9...就会被选中

~~ 这一题t寄存器挺紧张的... ~~

一开始我把很多东西都放进t寄存器里了，所以数量紧张，但是后来我发现有些东西可以直接放进原来的a寄存器里，这样大大缓解了寄存器数量不够的问题。

## Task5

### Loss Functions

损失函数接受两个整数数组，并输出一个整数数组，其中包含了对应元素对之间的差异程度的某种度量。

本次proj会用到三种不同的损失函数

#### absolute loss function

计算两个数组对应位置的差的绝对值，放入输出数组中，输出结果是输出数组的和

#### squared loss function

计算两个数组对应位置差的平方，放入输出数组中，输出结果是输出数组的和

####  zero-one loss function

计算每一个对应位置是否相等，不输出任何和

## Task6

要求:

```txt
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
```

这个task我花了两三个小时。。。做的汗流浃背，经过一次函数调用之后很多寄存器里面的值都被打乱了，用的时候一定要想清楚。



## Task7



第一遍题目没看懂。。导致花了很多时间，后来看了别人的思路之后就完全不想自己写了，没get到点就很烦啊



注意a1和a2指针是用来存放row和col的



## Task8



这里有个坑点，你将row和col反过来写进文件，检查还是会过的，加大了task9排查bug的难度



## Task9



灵活利用栈
