# wget https://github.com/liugnggh71/lld/raw/main/wget_lld.sh

pwd=$(pwd)
cd ${pwd}
mkdir -p dba_code/bin
echo -n export PATH=\${HOME}/dba_code/bin > profile.txt
echo ':${PATH}' >> profile.txt 
echo cd dba_code/bin > cd_dba_code_bin.sh
echo ln -s cd_dba_code_bin.sh BN > ln_bn.sh
cd ${pwd}/dba_code/bin
wget https://github.com/liugnggh71/lld/raw/main/dba_code/bin/lld
chmod u+x lld
wget https://github.com/liugnggh71/lld/raw/main/dba_code/bin/llf
chmod u+x llf
wget https://github.com/liugnggh71/lld/raw/main/dba_code/bin/lll
chmod u+x lll
wget https://github.com/liugnggh71/lld/raw/main/dba_code/bin/b1f
chmod u+x b1f
wget https://github.com/liugnggh71/lld/raw/main/dba_code/bin/lnc
chmod u+x lnc
wget https://github.com/liugnggh71/lld/raw/main/dba_code/bin/SAX
chmod u+x SAX
wget https://github.com/liugnggh71/lld/raw/main/dba_code/bin/SAXON
chmod u+x SAXON
cd ${pwd}
mkdir -p dba_code1/bin
echo -n export PATH=\${HOME}/dba_code1/bin > profile.txt
echo ':${PATH}' >> profile.txt 
echo cd dba_code1/bin > cd_dba_code_bin.sh
echo ln -s cd_dba_code_bin.sh BN > ln_bn.sh
cd ${pwd}/dba_code1/bin
wget https://github.com/liugnggh71/lld/raw/main/dba_code1/bin/XXX
chmod u+x XXX
cd ${pwd}/dba_code/bin
ln -s lld D
ln -s llf F
ln -s lll L
cd ${pwd}
