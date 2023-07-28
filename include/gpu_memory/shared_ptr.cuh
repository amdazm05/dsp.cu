#ifndef _SHARED_PTR_CUDA
#define _SHARED_PTR_CUDA

#include <cuda_runtime_api.h>
#include <exception>

namespace cuda_memory
{
    template<class T>
    class shared_ptr
    {
        public:
        //default constructor
        shared_ptr():_ptr(nullptr),usecount(0),_sizeofMemoryAllocated(0) 
        {

        }
        //reference 
        shared_ptr(const shared_ptr<T> &_ptr):
            _ptr(_ptr._ptr),
            usecount(_ptr.usecount),
            _sizeofMemoryAllocated(_ptr._sizeofMemoryAllocated) 
        {

        }
        //move semantics
        shared_ptr(const shared_ptr<T> &&_ptr):_ptr(_ptr._ptr),usecount(_ptr.usecount)
        {
            _ptr.clean_up();
        }
        ~shared_ptr()
        {
            cudaFree(_ptr);
        }
        shared_ptr<T> & operator=(const shared_ptr<T> &_ptr)
        {
            clean_up();
            this->_ptr = _ptr._ptr;
            this->usecount = _ptr.usecount;
            this->_sizeofMemoryAllocated = _ptr._sizeofMemoryAllocated;
            if(_ptr._ptr!=nullptr)
            {
                this->usecount++;
            }
            return this; 
        }
        shared_ptr<T> & operator=(const shared_ptr<T> &&_ptr)
        {
            clean_up();
            this->_ptr = _ptr.ptr;
            this->usecount = _ptr.usecount;
            this->_sizeofMemoryAllocated = _ptr._sizeofMemoryAllocated;
            _ptr.clean_up();
        }

        inline T * get()
        {
            return this->_ptr; 
        }
        inline T * operator->()
        {
            return this-> ptr;
        }
        inline std::size_t get_count()
        {
            return usecount;
        }
        // ^^^^ C++ essentials

        void create(size_t sizeofMemoryToAllocate)
        {
            //Allocates memory
            if (_ptr==nullptr)
            {
                  cudaMalloc((void **)&_ptr, sizeofMemoryToAllocate);
                  _sizeofMemoryAllocated = sizeofMemoryToAllocate;
            }
            else
            {
                throw std::runtime("Memory is already allocated on GPU");
            }

        }

        void download(T * arrayToCopy,std::size_t sizeofArray)
        {
            if(arrayToCopy != nullptr)
            {
                cudaMemcpy((void *)arrayToCopy,(const void *)_ptr,sizeofArray,cudaMemcpyKind::cudaMemcpyDeviceToHost);
            }
            else
            {
                throw std::runtime("Download cannot be proceeded , as destination array is not initialised in host");
            }
        }
        void upload(T *arrayToUpload,std::size_t sizeofArray)
        {
            if(arrayToUpload != nullptr)
            {
                cudaMemcpy((void *)_ptr,sizeofArray,(void *)arrayToUpload,cudaMemcpyKind::cudaMemcpyHostToDevice);
            }
            else
            {
                throw std::runtime("Upload cannot be proceeded , as upload array is not initialised in host");
            }
        }
        private:
            void clean_up()
            {
                usecount = 0;
                cudaFree(_ptr);
            }
            std::size_t _sizeofMemoryAllocated;
            T * _ptr;
            std::size_t usecount;
    };
}


#endif