#ifndef  _HOST_VECTOR
#define  _HOST_VECTOR
#include <device_vector.cuh>

template<typename T,size_t size>
class host_vector
{
    private:
        std::size_t capacity_;
        std::size_t size_;
    public:
        //can take GPU data directly from the passed vector
        // host_vector(V itbeg, V itend); // 
        // host_vector(V itbeg, V itend); // 
        host_vector();
        void push_back(T val);
        T at(std::size_t index);
        T operator[](std::size_t index);
};
#endif