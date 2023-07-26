#ifndef _ARRAY_INDEXER
#define _ARRAY_INDEXER
#include <utils.hpp>
#define N 1024
__global__ void array1d(float  *inputArray, size_t sizeofArray);
void array1d_wrapper(float  *inputArray, size_t sizeofArray);
#endif