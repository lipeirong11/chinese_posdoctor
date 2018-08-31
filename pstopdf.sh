#!/bin/bash
#set +x
#find  .  -type f -name "*.eps" -exec cp --parents {}  $2 \;
#echo !!!DONE!!!
ANA_DIR=`pwd`
echo Current dir: $ANA_DIR
ls *.eps > temp
for i in `cat temp | cut -d"." -f1`
do
 pstopdf $i.eps -o chap3_$i.pdf
 mv chap3_$i.pdf Figure/
 rm -f $i.eps
done
echo Done!!!
