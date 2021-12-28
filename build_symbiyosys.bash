
git clone https://github.com/YosysHQ/SymbiYosys.git
cd SymbiYosys
make install

cd /opt/
rm -rf /opt/SymbiYosys

git clone --branch Yices-2.6.2 https://github.com/SRI-CSL/yices2.git && cd yices2 && autoconf && ./configure && make -j$(nproc) && make install && cd ..

cd /opt/
rm -rf /opt/yices2
