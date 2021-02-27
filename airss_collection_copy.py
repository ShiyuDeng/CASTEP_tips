import os
import shutil
src_dir = "/mnt/c/Users/dengs/work/TMPX3/sd864_CSD3/TMPS3_cal/NiPS3/pred_airss/15GPa_NP_TS_U" # the directory where you want to copy from
#dst_dir = "" # the directory where you want to copy to
with open('./analysis_0.1', 'r') as f:
	lines = f.readlines()
	for line in lines:
		x, sg = line[:-1].split(' ')
		if '/' in sg:
			sg.replace('/', '_')
		src_file = os.path.join(src_dir, '%s.res' % x)
		os.makedirs('/mnt/c/Users/dengs/work/TMPX3/sd864_CSD3/TMPS3_cal/NiPS3/pred_airss/15GPa_NP_TS_U/collection/%s' % sg)
		dst_dir = "/mnt/c/Users/dengs/work/TMPX3/sd864_CSD3/TMPS3_cal/NiPS3/pred_airss/15GPa_NP_TS_U/collection/%s" % sg
		dst_file = os.path.join(dst_dir, '%s.res' % x)
		shutil.copyfile(src_file, dst_file)
		src_file = os.path.join(src_dir, '%s-out.cell' % x)
		dst_file = os.path.join(dst_dir, '%s-out.cell' % x)
		shutil.copyfile(src_file, dst_file)
