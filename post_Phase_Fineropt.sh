#!/bin/bash

for i in $(seq 1 2 15) 
do

cd ./$i/finer
pwd

V=$(grep -i "volume" FePS3.castep | tail -n 1 | awk '{print $5}')
E=`grep "NB est. 0K energy (E-0.5TS)"  FePS3.castep | tail -n 1  | awk '{print $7}'`
enthalpy=`grep "enthalpy"  FePS3.castep | tail -n 1  | awk '{print $7}'`

Fe1_spin=`grep "Fe              1   up:" FePS3.castep | tail -n 1 | awk '{print $10}'`
Fe2_spin=`grep "Fe              2   up:" FePS3.castep | tail -n 1 | awk '{print $10}'`
S_spin=`grep "S               1   up:" FePS3.castep | tail -n 1 | awk '{print $10}'`

a=$(grep -i " a = " FePS3.castep | tail -n 1 | awk '{print $3}')
b=$(grep -i " b = " FePS3.castep | tail -n 1 | awk '{print $3}')
c=$(grep -i " c = " FePS3.castep | tail -n 1 | awk '{print $3}')

alpha=$(grep -i " alpha " FePS3.castep | tail -n 1 | awk '{print $6}')
beta=$(grep -i " beta " FePS3.castep | tail -n 1 | awk '{print $6}')
gamma=$(grep -i " gamma " FePS3.castep | tail -n 1 | awk '{print $6}')
#TIME=`grep -i "total time" FePS3.castep | tail -n 1  | awk '{print $4}'`
#GRID=`grep -i "MP GRID" FePS3.castep`                                              
#KNUM=`grep -i "numbe of kpoints" FePS3.castep | awk '{print $6}'`
P_P=$(grep -i "P 1 -- P 2" FePS3.castep | tail -n 1 | awk '{print $8}') 

echo "$i $enthalpy $E $V $a $b $c $alpha $beta $gamma $Fe1_spin $Fe2_spin $P_P " >> ../../P-31m_pred@10GPa_2fuAFM_enthalpy_pressure_ecut550_PBE_TS
echo  >> ../../P-31m_pred@10GPa_2fuAFM_enthalpy_pressure_ecut550_PBE_TS

cd ../../
pwd

done
