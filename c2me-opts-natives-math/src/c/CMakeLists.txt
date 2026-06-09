cmake_minimum_required(VERSION 3.25)
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")

project(c2me-opts-natives-math C)

set(CMAKE_C_STANDARD 11)

execute_process(COMMAND /usr/local/lib/android/sdk/ndk/29.0.14206865/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-config --prefix 
    OUTPUT_VARIABLE LLVM_PREFIX 
    OUTPUT_STRIP_TRAILING_WHITESPACE)
target_include_directories(c2me-opts-natives-math PRIVATE includes/)
set(CMAKE_ANDROID_LD "lld")
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DUseABSL -O3 -pipe -integrated-as -mllvm -polly -mllvm -polly-vectorizer=stripmine -mllvm -polly-invariant-load-hoisting -mllvm -polly-run-inliner -mllvm -polly-run-dce -mllvm -polly-invariant-load-hoisting -flto -mllvm -polly-run-inliner -mllvm -polly-run-dce -fdata-sections -ffunction-sections -mllvm -polly-detect-keep-going -mllvm -polly-ast-use-context -march=armv8-a+simd -fvisibility=hidden -Wall -Wextra -ferror-limit=0 -Wno-return-type -Wno-unused-parameter -Wno-c++98-compat -Wno-c++98-compat-pedantic -DGLM_FORCE_INTRINSICS -Wno-unicode-whitespace -Wno-format -Wno-unused-function -fmerge-all-constants -D_FILE_OFFSET_BITS=64 -D__USE_BSD -D_ALLBSD_SOURCE -mllvm -inlinehint-threshold=100000 -D_GNU_SOURCE -Wall -Wextra -Wpedantic -ffreestanding -ffile-prefix-map=${CMAKE_SOURCE_DIR}=. -fdebug-compilation-dir=. -fdebug-prefix-map=${CMAKE_SOURCE_DIR}=. -fdebug-prefix-map=${LLVM_PREFIX}=.../llvm-prefix -fno-math-errno -mprefer-vector-width=512 -ffp-contract=off -mno-stack-arg-probe -fsave-optimization-record -mllvm -extra-vectorizer-passes -mllvm -slp-vectorize-hor-store -mllvm -slp-min-tree-size=2 -mllvm -slp-min-reg-size=64 -mllvm -slp-threshold=-1 -mllvm -enable-epilogue-vectorization")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fdebug-prefix-map=${LLVM_PREFIX}=.../llvm-prefix -fdebug-prefix-map=${CMAKE_SOURCE_DIR}=. -fdebug-compilation-dir=. -ffile-prefix-map=${CMAKE_SOURCE_DIR}=. -fuse-ld=lld -flto -O3 -Wl,--strip-all -fvisibility=hidden -Wl,-O3 -Wl,--gc-sections -Wl,--as-needed -static-libstdc++ -Wl,--exclude-libs,ALL -Wl,--lto-O3")

# 不要清空标准库，或者显式加上 c
# set(CMAKE_C_STANDARD_LIBRARIES "")
# set(CMAKE_CXX_STANDARD_LIBRARIES "")

add_library(c2me-opts-natives-math SHARED
        exports.c
        system_isa_x86_64.c
        exports_x86_64_nogather.c
        system_isa_aarch64.c
        flibc.c
)

if(CMAKE_SYSTEM_PROCESSOR MATCHES "(x86)|(X86)|(amd64)|(AMD64)")
    set_source_files_properties(exports_x86_64_nogather.c PROPERTIES COMPILE_FLAGS "-mno-gather -mno-scatter")
endif()

