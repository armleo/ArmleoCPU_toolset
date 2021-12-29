# syntax=docker/dockerfile:1
FROM ubuntu:21.04

# To force automatic decisions for apt-get
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y

# Toolset
RUN apt-get install -y iverilog make grep gcc clang cloc verilator gdb gtkwave
# GCC: For Verilator
# CLANG: For CXXRTL
# CLOC: Line of code

# Verilator build tools
# RUN apt-get install -y git perl python3 make autoconf g++ flex bison ccache libgoogle-perftools-dev numactl perl-doc libfl2 libfl-dev zlib1g zlib1g-dev

# Verilator
# WORKDIR /opt
# RUN git clone --branch stable --depth 1 https://github.com/verilator/verilator
# WORKDIR /opt/verilator
# RUN autoconf && ./configure
# RUN make -j && make install




# Install deps for riscv toolchain
RUN apt-get install -y make git autoconf automake autotools-dev curl python3 libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev


# Linux deps
RUN apt-get install -y git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison

# Qemu deps
RUN apt-get install -y libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev python3 ninja-build

RUN apt-get install -y qemu-system-misc qemu

# SymbiYosys (Z3 from packages)
RUN apt-get install -y z3 build-essential clang bison flex libreadline-dev gawk tcl-dev libffi-dev git mercurial graphviz xdot pkg-config python python3 libftdi-dev gperf libboost-program-options-dev autoconf libgmp-dev cmake

WORKDIR /opt/
# Install SymbiYosys
ADD build_symbiyosys.bash /opt/build_symbiyosys.bash
RUN bash build_symbiyosys.bash


# Yosys deps
RUN apt-get install -y build-essential clang bison flex gawk libreadline-dev gawk tcl-dev libffi-dev git graphviz xdot pkg-config python3 libboost-system-dev libboost-python-dev libboost-filesystem-dev zlib1g-dev

WORKDIR /opt
ADD build_yosys.bash /opt/build_yosys.bash
RUN bash /opt/build_yosys.bash



# Build RISC-V GNU Toolchain
WORKDIR /opt/
ENV PATH=$PATH:/opt/riscv/bin
ADD build_riscv_toolchain.bash /opt/build_riscv_toolchain.bash
RUN bash /opt/build_riscv_toolchain.bash

