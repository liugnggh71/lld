sh << 'EOF'
wget https://github.com/liugnggh71/lld/raw/main/Install/dba_code_bin.zip
scp dba_code_bin.zip 10.21.5.50:/tmp
ssh 10.21.5.50 unzip -o /tmp/dba_code_bin.zip  < /dev/null
scp dba_code_bin.zip 10.21.5.38:/tmp
ssh 10.21.5.38 unzip -o /tmp/dba_code_bin.zip  < /dev/null
scp dba_code_bin.zip 10.21.133.2:/tmp
ssh 10.21.133.2 unzip -o /tmp/dba_code_bin.zip  < /dev/null
scp dba_code_bin.zip 10.21.133.3:/tmp
ssh 10.21.133.3 unzip -o /tmp/dba_code_bin.zip  < /dev/null
scp dba_code_bin.zip 10.21.133.44:/tmp
ssh 10.21.133.44 unzip -o /tmp/dba_code_bin.zip  < /dev/null
scp dba_code_bin.zip 10.21.133.35:/tmp
ssh 10.21.133.35 unzip -o /tmp/dba_code_bin.zip  < /dev/null
scp dba_code_bin.zip 10.21.5.2:/tmp
ssh 10.21.5.2 unzip -o /tmp/dba_code_bin.zip  < /dev/null
scp dba_code_bin.zip 10.21.5.3:/tmp
ssh 10.21.5.3 unzip -o /tmp/dba_code_bin.zip  < /dev/null
scp dba_code_bin.zip 10.21.137.2:/tmp
ssh 10.21.137.2 unzip -o /tmp/dba_code_bin.zip  < /dev/null
scp dba_code_bin.zip 10.21.137.3:/tmp
ssh 10.21.137.3 unzip -o /tmp/dba_code_bin.zip  < /dev/null
scp dba_code_bin.zip 10.21.32.98:/tmp
ssh 10.21.32.98 unzip -o /tmp/dba_code_bin.zip  < /dev/null
scp dba_code_bin.zip 10.21.32.102:/tmp
ssh 10.21.32.102 unzip -o /tmp/dba_code_bin.zip  < /dev/null
scp dba_code_bin.zip 10.21.32.2:/tmp
ssh 10.21.32.2 unzip -o /tmp/dba_code_bin.zip  < /dev/null
scp dba_code_bin.zip 10.21.32.3:/tmp
ssh 10.21.32.3 unzip -o /tmp/dba_code_bin.zip  < /dev/null
scp dba_code_bin.zip 10.21.32.105:/tmp
ssh 10.21.32.105 unzip -o /tmp/dba_code_bin.zip  < /dev/null
scp dba_code_bin.zip 10.21.32.106:/tmp
ssh 10.21.32.106 unzip -o /tmp/dba_code_bin.zip  < /dev/null
EOF
