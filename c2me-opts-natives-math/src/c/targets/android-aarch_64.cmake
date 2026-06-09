set(CMAKE_SYSTEM_NAME Android)
set(CMAKE_SYSTEM_PROCESSOR arm64)

set(triple aarch64-unknown-linux-android)

set(CMAKE_C_COMPILER clang)
set(CMAKE_C_COMPILER_TARGET ${triple})
set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_CXX_COMPILER_TARGET ${triple})
