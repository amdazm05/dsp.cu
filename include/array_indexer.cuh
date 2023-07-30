#ifndef _ARRAY_INDEXER
#define _ARRAY_INDEXER
#include <utils.hpp>

//really interesting stuff 
//https://gist.github.com/lebedov/bca3c70e664f54cdf8c3cd0c28c11a0f
__global__ void array1d(float  *inputArray, size_t sizeofArray);
template<uint16_t threads,uint16_t blocks,uint16_t grid>
class ArrayIndexer
{
    private:
        dim3 _kernelDims;
        std::size_t _sizeofArray;
    public:
        void init();
        void access_array(float* array,size_t sizeofArray);
};

template<uint16_t threads,uint16_t blocks,uint16_t grid>
void ArrayIndexer<threads,blocks,grid>::init()
{

}

template<uint16_t threads,uint16_t blocks,uint16_t grid>
void ArrayIndexer<threads,blocks,grid>::access_array(float * array,size_t sizeofArray)
{
    array1d<<<threads,blocks,grid>>>(array,sizeofArray);
}

#endif