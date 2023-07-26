cmake_minimum_required(VERSION 3.2)
project(dsp)
find_package(CUDA)
set(CMAKE_CUDA_STANDARD 14)

include_directories(${CUDA_INCLUDE_DIRS})
include_directories(${PROJECT_SOURCE_DIR}/include/)

CUDA_ADD_LIBRARY(arrayIndexer ${PROJECT_SOURCE_DIR}/src/array_indexer.cu)
	
set(CXX_STANDARD 17)
add_executable(
	tests ./tests/project_structure_test.cc
)
target_link_libraries(
	tests PUBLIC arrayIndexer
)