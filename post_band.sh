#!/bin/bash -l

for i in "NPol" "8fu_zigzagAFM"
do
cd ./$i

cp FePS3.bands FePS3.bands.orig
cp FePS3.castep FePS3_bands.castep
ln -s /home/sd864/toolbox/orbitals2bands ./
./orbitals2bands FePS3
echo "orbitals converted"
pwd

cd ../
echo " $i done"

#tar -czvf $i.tar.gz ./$i  --exclude=*check*  --exclude=*orbital*
#echo "$i compressed"
done

#echo "all finished"


#perl dispersion.pl -xg -bs -symmetry monoclinic FePS3.bands
