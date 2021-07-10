# syntax=docker/dockerfile:1
FROM ubuntu:21.04
RUN apt-get update -y && apt-get install -y yosys gtkwave iverilog verilator make grep gcc

# Install deps for riscv toolchain
RUN apt-get install -y git autoconf automake autotools-dev curl python3 libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev

WORKDIR /opt
ENV PATH=$PATH:/opt/riscv/bin
RUN git clone https://github.com/riscv/riscv-gnu-toolchain && mkdir /opt/riscv
WORKDIR riscv-gnu-toolchain
RUN ./configure --prefix=/opt/riscv --with-arch=rv32ima --with-abi=ilp32
RUN make
RUN make linux