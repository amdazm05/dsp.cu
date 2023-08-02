#include <cuda_runtime_api.h>
#include <device_launch_parameters.h>
#include <iostream>

__global__ void array1d(float  *inputArray, size_t sizeofArray)
{
    int index = threadIdx.x; 
    printf("Data Indexed here : x%d  , array [%f]\n",threadIdx.x,inputArray[index]);
}

__global__ void array2d(float  *inputArray, size_t sizeofArray)
{
    int index = threadIdx.x +threadIdx.x*threadIdx.y; 
    printf("Data Indexed here : x%d y%d , array [%f]\n",threadIdx.x,threadIdx.y,inputArray[index]);
}

__global__ void array3d(float  *inputArray, size_t sizeofArray)
{
    int index = threadIdx.x +threadIdx.x*threadIdx.y + blockDim.x*blockDim.y*threadIdx.z; 
    printf("Data Indexed here : x%d y%d z%d , array [%f]\n",threadIdx.x,threadIdx.y,threadIdx.z,inputArray[index]);
}

inline void _array1d(float  *inputArray, size_t sizeofArray,dim3  _threads_block,dim3 _blocks_grid)
{
    array1d<<<_blocks_grid,_threads_block>>>(inputArray,sizeofArray);
}
inline void  _array2d(float  *inputArray, size_t sizeofArray,dim3  _threads_block,dim3  _blocks_grid)
{
    array2d<<<_blocks_grid,_threads_block>>>(inputArray,sizeofArray);
}