# syntax=docker/dockerfile:1
FROM ubuntu:21.04
RUN apt-get update -y
RUN apt-get install -y yosys gtkwave iverilog verilator make grep gcc

# Install deps for riscv toolchain
RUN apt-get install -y autoconf automake autotools-dev curl python3 libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev
RUN apt-get install -y git

WORKDIR /opt
RUN git clone https://github.com/riscv/riscv-gnu-toolchain
RUN mkdir /opt/riscv
ENV PATH=$PATH:/opt/riscv/bin
WORKDIR riscv-gnu-toolchain
RUN ./configure --prefix=/opt/riscv --with-arch=rv32ima --with-abi=ilp32
RUN make
RUN make linux