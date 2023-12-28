cmake_minimum_required(VERSION 3.25)
project(test)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mavx")

set(CMAKE_CXX_STANDARD 11)

add_executable(test main.cpp opt.cpp)

add_executable(opt opt.cpp)
