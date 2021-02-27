#!/bin/bash

################# U_band ################
for a in $(awk '{print $2}' ./analysis_0\.1) 
do
	cd ./$a
	rm -r opt_D_U

	mkdir opt_D_U
	
	cp ../MnPS3.param          ./opt_D_U
	cp ../submit_castep19\.1   ./opt_D_U
	cp *-out.cell              ./opt_D_U/MnPS3.cell

	cd ./opt_D_U

	echo "
	%block hubbard_u
	eV
	Mn d: 2.5
	%endblock hubbard_u
	
	kpoint_mp_spacing : 0.03" >> MnPS3.cell

	sed -i "s|kpoint_mp_grid|#kpoint_mp_grid|g" MnPS3.cell

	sed -i "s|#SBATCH -J jobname|#SBATCH -J 20GPa_opt_TS_U_$a|g" submit_castep19.1
#	sbatch submit\_castep19\.1 MnPS3
	pwd
	echo "$a opt_D_U ready for finer opt"

	cd ../../
	pwd
done
#sbatch submit_castep19\.1 FePS3
