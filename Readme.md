# Pack installation zip
## On host bsworaredhat01

```
[oracle@bsworaredhat01 8]$ pwd
/tmp/8

wget https://github.com/liugnggh71/lld/raw/main/master_stage.sh
. ./master_stage.sh
```

## On VDI host

Put install file in git repository location
```
cd "/drives/c/Users/gangl/OneDrive - Atos/Documents/GitHub/lld/Install/"
scp bsworaredhat01:/tmp/8/dba_code_bin.zip .
```

## Update and push git
Use OxygenXML to push

# Mass install from bsworaredhat01

Run shell block on red01 host block from master_install.sh

```
sh << 'EOF'
wget https://github.com/liugnggh71/lld/raw/main/Install/dba_code_bin.zip
echo ============================================================
echo bswexadbt02-1kjpk1.pvtppdbnp.pvtpp.oraclevcn.com
echo ============================================================
scp dba_code_bin.zip 10.21.5.50:/tmp
ssh 10.21.5.50 unzip -o /tmp/dba_code_bin.zip  < /dev/null
echo ============================================================
echo bswexadbt02-1kjpk2.pvtppdbnp.pvtpp.oraclevcn.com
echo ============================================================
scp dba_code_bin.zip 10.21.5.38:/tmp
ssh 10.21.5.38 unzip -o /tmp/dba_code_bin.zip  < /dev/null
echo ============================================================
echo bswexadbp01-rlmu81.pvtppproddb1021.phxpvtppprod.oraclevcn.com
echo ============================================================
scp dba_code_bin.zip 10.21.133.2:/tmp
ssh 10.21.133.2 unzip -o /tmp/dba_code_bin.zip  < /dev/null
echo ============================================================
echo bswexadbp01-rlmu82.pvtppproddb1021.phxpvtppprod.oraclevcn.com
echo ============================================================
scp dba_code_bin.zip 10.21.133.3:/tmp
ssh 10.21.133.3 unzip -o /tmp/dba_code_bin.zip  < /dev/null
echo ============================================================
echo bswexadbp02-5cfwx1.pvtppproddb02.phxpvtppprod.oraclevcn.com
echo ============================================================
scp dba_code_bin.zip 10.21.133.44:/tmp
ssh 10.21.133.44 unzip -o /tmp/dba_code_bin.zip  < /dev/null
echo ============================================================
echo bswexadbp02-5cfwx2.pvtppproddb02.phxpvtppprod.oraclevcn.com
echo ============================================================
scp dba_code_bin.zip 10.21.133.35:/tmp
ssh 10.21.133.35 unzip -o /tmp/dba_code_bin.zip  < /dev/null
echo ============================================================
echo bswexadbt01-q8ebk1.pvtppnonprod102.pvtpp.oraclevcn.com
echo ============================================================
scp dba_code_bin.zip 10.21.5.2:/tmp
ssh 10.21.5.2 unzip -o /tmp/dba_code_bin.zip  < /dev/null
echo ============================================================
echo bswexadbt01-q8ebk2.pvtppnonprod102.pvtpp.oraclevcn.com
echo ============================================================
scp dba_code_bin.zip 10.21.5.3:/tmp
ssh 10.21.5.3 unzip -o /tmp/dba_code_bin.zip  < /dev/null
echo ============================================================
echo aupp-hroradb-bfcfz1.hlthedgexap.pvthlthedgedr.oraclevcn.com
echo ============================================================
scp dba_code_bin.zip 10.21.137.2:/tmp
ssh 10.21.137.2 unzip -o /tmp/dba_code_bin.zip  < /dev/null
echo ============================================================
echo aupp-hroradb-bfcfz2.hlthedgexap.pvthlthedgedr.oraclevcn.com
echo ============================================================
scp dba_code_bin.zip 10.21.137.3:/tmp
ssh 10.21.137.3 unzip -o /tmp/dba_code_bin.zip  < /dev/null
echo ============================================================
echo bswochrdbt01-fz4re1.hlthedgeexa.pvthlthedgeprod.oraclevcn.com
echo ============================================================
scp dba_code_bin.zip 10.21.32.98:/tmp
ssh 10.21.32.98 unzip -o /tmp/dba_code_bin.zip  < /dev/null
echo ============================================================
echo bswochrdbt01-fz4re2.hlthedgeexa.pvthlthedgeprod.oraclevcn.com
echo ============================================================
scp dba_code_bin.zip 10.21.32.102:/tmp
ssh 10.21.32.102 unzip -o /tmp/dba_code_bin.zip  < /dev/null
echo ============================================================
echo aupp-hroradb-f9exx1.hlthedgexap.pvthlthedgeprod.oraclevcn.com
echo ============================================================
scp dba_code_bin.zip 10.21.32.2:/tmp
ssh 10.21.32.2 unzip -o /tmp/dba_code_bin.zip  < /dev/null
echo ============================================================
echo aupp-hroradb-f9exx2.hlthedgexap.pvthlthedgeprod.oraclevcn.com
echo ============================================================
scp dba_code_bin.zip 10.21.32.3:/tmp
ssh 10.21.32.3 unzip -o /tmp/dba_code_bin.zip  < /dev/null
echo ============================================================
echo autp-hroradb-utzrk1.hlthedgeexa.pvthlthedgeprod.oraclevcn.com
echo ============================================================
scp dba_code_bin.zip 10.21.32.105:/tmp
ssh 10.21.32.105 unzip -o /tmp/dba_code_bin.zip  < /dev/null
echo ============================================================
echo autp-hroradb-utzrk2.hlthedgeexa.pvthlthedgeprod.oraclevcn.com
echo ============================================================
scp dba_code_bin.zip 10.21.32.106:/tmp
ssh 10.21.32.106 unzip -o /tmp/dba_code_bin.zip  < /dev/null
EOF
```
