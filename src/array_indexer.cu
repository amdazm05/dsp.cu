#include "array_indexer.cuh"

inline void _array1d(float  *inputArray, size_t sizeofArray,dim3  _threads_block,dim3 _blocks_grid)
{
    array1d<<<_blocks_grid,_threads_block>>>(inputArray,sizeofArray);
}

__global__ void array1d(float  *inputArray, size_t sizeofArray)
{
    int index = threadIdx.x; 
    printf("Data Indexed here : x%d y%d , array [%f]\n",threadIdx.x,threadIdx.y,inputArray[index]);
}
