#llvm clang 3.4 + IWYU image
#forked from jimenez/iwyu:clang_3.4

FROM ubuntu:14.04.2
MAINTAINER tobilg <tobilg@gmail.com>

RUN apt-get update -q

#Install Dependencies
RUN apt-get -qy install         \
    build-essential             \
    clang                       \
    cmake                       \
    libclang-dev                \
    libncurses-dev              \
    linux-libc-dev              \
    llvm-dev                    \
    make                        \
    git                         \
    --no-install-recommends

#Checkout IWYU and switch the banch clang_3.4
RUN mkdir include-what-you-use && git clone https://github.com/include-what-you-use/include-what-you-use.git source && cd source && git checkout -b clang_3.4

ENV CC clang
ENV CXX clang++
ENV CMAKE_C_COMPILER clang
ENV CMAKE_CXX_COMPILER clang++

#Configure IWYU
RUN mkdir build && cd build && cmake -G "Unix Makefiles" -DLLVM_PATH=/usr/lib/llvm-3.4 ../source

#Compile and install IWYU
RUN cd build && make && make install
