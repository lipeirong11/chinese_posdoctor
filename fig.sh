#!/bin/bash
#set +x
#find  .  -type f -name "*.eps" -exec cp --parents {}  $2 \;
#echo !!!DONE!!!
ANA_DIR=`pwd`
echo Current dir: $ANA_DIR
ls *.pdf > temp
for i in `cat temp | cut -d"." -f1`
do
 mv $i.pdf  Figure/chap3_$i.pdf
done
echo Done!!!
