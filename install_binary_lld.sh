pwd=$(pwd)
mkdir -p /tmp/saxon_he
cd /tmp/saxon_he
rm -f SaxonHE11-4J.zip
wget https://github.com/Saxonica/Saxon-HE/raw/main/11/Java/SaxonHE11-4J.zip
unzip SaxonHE11-4J.zip
cp -p saxon-he-11.4.jar ${pwd}/dba_code/bin/saxon_he_stable.jar
cd $(pwd)
cat << 'EOC'
export CLASSPATH=$HOME/dba_code/bin/saxon_he_stable.jar
EOC
pwd=$(pwd)
mkdir -p /tmp/saxon_he
cd /tmp/saxon_he
rm -f sqlcl-latest.zip
wget https://download.oracle.com/otn_software/java/sqldeveloper/sqlcl-latest.zip
cp -p sqlcl-latest.zip ${pwd}/dba_code/bin/sqlcl-latest.zip
cd $(pwd)
