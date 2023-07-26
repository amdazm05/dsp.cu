#include "array_indexer.cuh"

__global__ void array1d(float  *inputArray, size_t sizeofArray)
{
    threadIdx.x;
}

void array1d_wrapper(float  *inputArray, size_t sizeofArray)
{
	int blockSize = 256;
	int numBlocks = (N + blockSize - 1) / blockSize;
    array1d<<<numBlocks, blockSize>>> (inputArray,sizeofArray);
}