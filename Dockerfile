# syntax=docker/dockerfile:1
FROM ubuntu:21.04

# To force automatic decisions for apt-get
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y

# Toolset
RUN apt-get install -y iverilog verilator make grep gcc clang cloc gtkwave
# GCC: For Verilator
# CLANG: For CXXRTL
# CLOC: Line of code

# Install deps for riscv toolchain
RUN apt-get install -y make git autoconf automake autotools-dev curl python3 libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev


# Linux deps
RUN apt-get install -y git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison

# Qemu deps
RUN apt-get install -y libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev python3 ninja-build

# SymbiYosys (Z3 from packages)
RUN apt-get install -y z3 build-essential clang bison flex libreadline-dev gawk tcl-dev libffi-dev git mercurial graphviz xdot pkg-config python python3 libftdi-dev gperf libboost-program-options-dev autoconf libgmp-dev cmake

WORKDIR /opt/
# Install SymbiYosys
RUN git clone https://github.com/YosysHQ/SymbiYosys.git && cd SymbiYosys && make install && cd ..

RUN git clone --branch Yices-2.6.2 https://github.com/SRI-CSL/yices2.git && cd yices2 && autoconf && ./configure && make -j$(nproc) && make install && cd ..

# Build RISC-V GNU Toolchain
WORKDIR /opt/
ENV PATH=$PATH:/opt/riscv/bin
RUN git clone https://github.com/riscv/riscv-gnu-toolchain && mkdir /opt/riscv
WORKDIR riscv-gnu-toolchain
RUN ./configure --prefix=/opt/riscv --with-arch=rv32ima --with-abi=ilp32
RUN make
RUN make linux


# Yosys deps
RUN apt-get install -y build-essential clang bison flex gawk libreadline-dev gawk tcl-dev libffi-dev git graphviz xdot pkg-config python3 libboost-system-dev libboost-python-dev libboost-filesystem-dev zlib1g-dev


WORKDIR /opt
RUN git clone https://github.com/YosysHQ/yosys.git
WORKDIR /opt/yosys
RUN make
RUN make test
RUN make install

