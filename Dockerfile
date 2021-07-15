# syntax=docker/dockerfile:1
FROM ubuntu:21.04

# To force automatic decisions for apt-get
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y

# Toolset
RUN apt-get install -y iverilog verilator make grep gcc gtkwave

# Install deps for riscv toolchain
RUN apt-get install -y make git autoconf automake autotools-dev curl python3 libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev

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

RUN apt-get install git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc flex libelf-dev bison
