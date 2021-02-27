#!/bin/bash

#### to set up the static bandstructure and dos calculation with optimized structure (xxx-out.cell)

mkdir band dos

cp FePS3-out.cell ./band/FePS3.cell #use the optimized structure for statci cal.
cp FePS3.param ./band/
cp submit_castep19.1 ./band

cd ./band

sed -i "s|task            :|task     : bandstructure  !|g"  FePS3.param
sed -i "s|cut_off_energy|#cut_off_energy|g"  FePS3.param
echo "basis_precision : precise " >> FePS3.param

sed -i "s|WRITE_BANDS|#WRITE_BANDS|g"  FePS3.param
sed -i "s|WRITE_CST_ESP|#WRITE_CST_ESP|g"  FePS3.param

sed -i '41,43d' FePS3.cell #remove the previous QC5 pseudopotential demand

cp FePS3.cell FePS3.param submit_castep19.\1  ./../dos

#for bands, select certain k_path
echo "%BLOCK BS_KPOINT_PATH       !PATH generated on Materials_Cloud
        0.0000000000 	0.0000000000 	0.0000000000  G
        0.5000000000 	0.5000000000 	0.0000000000  Y
        0.5000000000 	0.5000000000 	0.5000000000  M
        0.0000000000 	0.0000000000 	0.5000000000  A
        0.0000000000 	0.0000000000 	0.0000000000  G
        0.0000000000 	0.5000000000 	0.5000000000  L2
        0.0000000000 	0.0000000000 	0.0000000000  G
        0.0000000000 	0.5000000000 	0.0000000000  V2
%ENDBLOCK BS_KPOINT_PATH

BS_KPOINT_PATH_SPACING : 0.05  #default 0.1" >> FePS3.cell

sed -i "s|kpoint_mp_grid|#kpoint_mp_grid|g"  FePS3.cell
sed -i "s|kpoint_mp_offset|#kpoint_mp_offset|g"  FePS3.cell

#for dos, use MP Grid instead
cd ../dos
sed -i "s|kpoint_mp_grid|kpoint_mp_grid:  8  8  8 #|g"  FePS3.cell


echo "ready for test"
