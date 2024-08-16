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

### Array Strides

这个其实就是决定数组中隔几个元素被选中，比如stride为2，那么数组中的0，2，4，6...就会被选中；stride为3，0,3,6,9...就会被选中

~~ 这一题t寄存器挺紧张的... ~~

一开始我把很多东西都放进t寄存器里了，所以数量紧张，但是后来我发现有些东西可以直接放进原来的a寄存器里，这样大大缓解了寄存器数量不够的问题。