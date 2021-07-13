# syntax=docker/dockerfile:1
FROM ubuntu:21.04


RUN apt-get update -y


RUN apt-get install -y gtkwave iverilog verilator make grep gcc

# Yosys deps
RUN apt-get install -y build-essential clang bison flex libreadline-dev gawk tcl-dev libffi-dev git graphviz xdot pkg-config python3 libboost-system-dev libboost-python-dev libboost-filesystem-dev zlib1g-dev

WORKDIR /opt
RUN git clone https://github.com/YosysHQ/yosys.git
WORKDIR /opt/yosys
RUN make
RUN make test
RUN make install

# Install deps for riscv toolchain
RUN apt-get install -y git autoconf automake autotools-dev curl python3 libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev

# Build RISC-V GNU Toolchain
WORKDIR /opt/
ENV PATH=$PATH:/opt/riscv/bin
RUN git clone https://github.com/riscv/riscv-gnu-toolchain && mkdir /opt/riscv
WORKDIR riscv-gnu-toolchain
RUN ./configure --prefix=/opt/riscv --with-arch=rv32ima --with-abi=ilp32
RUN make
RUN make linux
