#ifndef _ARRAY_INDEXER
#define _ARRAY_INDEXER
#include <utils.hpp>
#include "gpu_memory/shared_ptr.cuh"

extern void  _array1d(float  *inputArray, size_t sizeofArray,dim3  _threads_block,dim3  _blocks_grid);
extern __global__ void array1d(float  *inputArray, size_t sizeofArray);
template<uint16_t threads,uint16_t blocks,uint16_t grid>
class ArrayIndexer
{
    private:
        cuda_memory::shared_ptr<float> _memory;
        dim3 _kernelDims;
        std::size_t _sizeofArray;
    public:
        void init(std::size_t bytesToAllocate);
        void access_array();
        void copy(float * array, size_t sizeofVar);
};

template<uint16_t threads,uint16_t blocks,uint16_t grid>
void ArrayIndexer<threads,blocks,grid>::init(std::size_t sizeofArrayToAllocate)
{
    _memory.create(sizeofArrayToAllocate);
    _sizeofArray= sizeofArrayToAllocate;
}

template<uint16_t threads,uint16_t blocks,uint16_t grid>
void ArrayIndexer<threads,blocks,grid>::access_array()
{
    _array1d(_memory.get(),_sizeofArray,dim3(threads/10,threads/10,1),dim3(blocks,1,1));
}

template<uint16_t threads,uint16_t blocks,uint16_t grid>
void ArrayIndexer<threads,blocks,grid>::copy(float * array, size_t sizeofVar)
{
    _memory.upload(array,sizeofVar);
}

#endif