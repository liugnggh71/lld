cat << EOC
sh << EOS
wget https://github.com/liugnggh71/lld/raw/main/master_stage.sh
wget https://github.com/liugnggh71/lld/raw/main/wget_lld.sh
wget https://github.com/liugnggh71/lld/raw/main/install_binary_lld.sh
chmod u+x master_stage.sh
chmod u+x wget_lld.sh
chmod u+x install_binary_lld.sh
./wget_lld.sh
./install_binary_lld.sh
EOS
EOC
./wget_lld.sh
./install_binary_lld.sh
