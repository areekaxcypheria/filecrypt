cmake_minimum_required(VERSION 3.14)
project(FileCrypt VERSION 2.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library(filecrypt_lib src/ciphers.cpp src/file_handler.cpp)
target_include_directories(filecrypt_lib PUBLIC include)
if(NOT MSVC)
  target_compile_options(filecrypt_lib PUBLIC -Wall -Wextra -Wpedantic)
endif()

add_executable(filecrypt src/main.cpp)
target_link_libraries(filecrypt PRIVATE filecrypt_lib)

enable_testing()
add_executable(test_ciphers tests/test_ciphers.cpp)
target_link_libraries(test_ciphers PRIVATE filecrypt_lib)
add_test(NAME ciphers COMMAND test_ciphers)
