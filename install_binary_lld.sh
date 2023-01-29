pwd=$(pwd)
mkdir -p /tmp/saxon_he
cd /tmp/saxon_he
rm -f SaxonHE11-4J.zip
wget https://github.com/Saxonica/Saxon-HE/raw/main/11/Java/SaxonHE11-4J.zip
unzip SaxonHE11-4J.zip
cp -p saxon-he-11.4.jar ${pwd}/https://github.com/Saxonica/Saxon-HE/raw/main/11/Java/SaxonHE11-4J.zip/saxon_he_stable.jar
cd $(pwd)
