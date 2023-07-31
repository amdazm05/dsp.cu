#include <iostream>
#include <array>
#include "array_indexer.cuh"

int main()
{
	std::array<float,100> _arrayHost;
	size_t s=0;
	for( auto & a:_arrayHost)
	{
		a = (float)s;
		s++;
	}
	ArrayIndexer<100,1,1> _array;
	_array.init(100);
	_array.copy(_arrayHost.data(),_arrayHost.size());
	_array.access_array();
	return 0;
}