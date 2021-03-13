import numpy as np
import matplotlib.pyplot as plt
import matplotlib.collections as collections

from scipy.interpolate import make_interp_spline
from scipy.interpolate import interp1d

### input info ###
filename = "expHP2_2fuAFM_enthalpy_pressure_ecut540_PBE_TS_U3p75" #"expHP2_2fuAFM_enthalpy_pressure_ecut550_PBE_G06vdW"   #"expHP2_2fuAFM_enthalpy_pressure_ecut550_PBE_TS_U2p5"
titlename = "expHP2_2fuAFM_PBE_TS_U3p75"
fu = 2  # f.u.
xmin = 0
xmax = 19
ymin = 2.0
ymax = 4.5
##################

Pressure, enthalpy, a, b, c, V, spin, P_intra, P_inter =[], [], [], [], [], [], [], [], []  #initialize the lists as empty lists
P_smooth, c_smooth, c_smooth02 = [], [], []

def nonblank_lines(f):
        for l in f:
            line = l.rstrip()
            if line:
                yield line

with open('%s' % filename, 'r') as f:
           #next(f) # to skip the first title line
            for line in nonblank_lines(f):
                        data = [float(s) for s in line.split()] #splits the current line around empty characters to form a string of tokens. Those tokens are then interpreted as floating point values. Those values are stored in the list 'data'.

                        Pressure.append(data[0]) # the values stored in 'data' are appended to the lists
                        enthalpy.append(data[1])
                        V.append(data[3])
                        a.append(data[4])
                        b.append(data[5])
                        c.append(data[6])
                        spin.append(data[11])
                        P_intra.append(data[12])
                        P_inter.append(data[13])

### convert the enthalpy into each f.u.  ###
enthalpy = [i/fu  for i in enthalpy] #enthalpy per f.u.
diff_d = np.subtract(P_intra, P_inter)
### PLOT ###
font = {'family' : 'Times New Roman',
        'weight' : 'bold',
        'size'   : 32}

plt.rc('font', **font)

fig = plt.figure(figsize=(10,10))
fig.suptitle("%s" %titlename,y=0.92)    
###################################
ax1 = fig.add_subplot(111)

ax1.set_xlabel('Pressure (GPa)')
ax1.set_ylabel(r'length ($\AA$)')

axes = plt.gca()
ax1.set_xlim([xmin,xmax])
ax1.set_ylim([ymin,ymax])

BSpline = make_interp_spline(Pressure,c)
cubic_interploation_model=interp1d(Pressure,c,kind="cubic")

#P_smooth = np.linspace(1,19,500)
#c_smooth = BSpline(P_smooth)
#c_smooth02 = cubic_interploation_model(P_smooth)

#ax1.plot(Pressure,enthalpy, c='blue', label='enthalpy')
#ax1.plot(Pressure,a,ls='--',marker='o',c='grey',lw=1, label='a=b')
#ax1.plot(Pressure,c,ls='--',marker='o',c='black',lw=1, label='c')
#ax1.plot(P_smooth,c_smooth,c='black')
#ax1.plot(P_smooth,c_smooth02,c='grey')
#ax1.plot(Pressure,spin,ls='--',marker='^', c='red', label='Final spin on Fe')

ax1.plot(Pressure,P_intra,ls='--',marker='o', markersize=9, c='blue', label='P-P within the layer')
ax1.plot(Pressure,P_inter,ls='--',marker='o', markersize=9, c='green', label='P-P in-between the layer')

collection = collections.BrokenBarHCollection.span_where(
            Pressure, ymin, ymax, where=diff_d>0, facecolor='cornflowerblue', alpha=0.5)
ax1.add_collection(collection)

leg = ax1.legend(loc='upper right',borderaxespad=0)
ax1.set_xticks(np.arange(xmin+1,xmax+0.5,step=2))
ax1.set_yticks(np.arange(ymin,ymax,step=0.5))

###################################
fig.tight_layout() # to improve the margin between multiple plots

plt.savefig('%s.png' % filename, dpi=450)
#plt.savefig('%s.eps' % filename, dpi=300)

plt.show() # should come after plt.savefig(), otherwise a blank fig will be saved
