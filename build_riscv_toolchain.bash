
git clone https://github.com/riscv/riscv-gnu-toolchain && mkdir /opt/riscv
cd riscv-gnu-toolchain
./configure --prefix=/opt/riscv --with-arch=rv32ima --with-abi=ilp32
make
make linux
cd /opt
rm -rf /opt/riscv-gnu-toolchain
echo "RISCV Toolchain build done"
