import numpy as np
import nibabel as nib
from brainspace.datasets import load_fsa5
from matplotlib import pyplot as plt
import scipy.io as scio
yeo_fs5_lh=nib.freesurfer.read_annot('lh.Yeo2011_7Networks_N1000.annot')[0]
yeo_fs5_rh=nib.freesurfer.read_annot('rh.Yeo2011_7Networks_N1000.annot')[0]
surf_lh, surf_rh = load_fsa5()
yeo7 = np.concatenate((yeo_fs5_lh, yeo_fs5_rh))

grad_67=scio.loadmat('align67_grad13.mat')['G13']
grad_67=-grad_67[:,2]
grad_8=scio.loadmat('align8_grad13.mat')['G13']
grad_8=-grad_8[:,2]
grad_9=scio.loadmat('align9_grad13.mat')['G13']
grad_9=-grad_9[:,2]
grad_10=scio.loadmat('align10_grad13.mat')['G13']
grad_10=-grad_10[:,2]
grad_11=scio.loadmat('align11_grad13.mat')['G13']
grad_11=-grad_11[:,2]
grad_12=scio.loadmat('align12_grad13.mat')['G13']
grad_12=-grad_12[:,2]
a67_net1=grad_67[yeo7 == 1]
a67_net2=grad_67[yeo7==2]
a67_net3=grad_67[yeo7==3]
a67_net4=grad_67[yeo7==4]
a67_net5=grad_67[yeo7==5]
a67_net6=grad_67[yeo7==6]
a67_net7=grad_67[yeo7==7]
a67_net1_ave=np.mean(a67_net1)-np.mean(a67_net1)
a67_net2_ave=np.mean(a67_net2)-np.mean(a67_net2)
a67_net3_ave=np.mean(a67_net3)-np.mean(a67_net3)
a67_net4_ave=np.mean(a67_net4)-np.mean(a67_net4)
a67_net5_ave=np.mean(a67_net5)-np.mean(a67_net5)
a67_net6_ave=np.mean(a67_net6)-np.mean(a67_net6)
a67_net7_ave=np.mean(a67_net7)-np.mean(a67_net7)


a8_net1=grad_8[yeo7 == 1]
a8_net2=grad_8[yeo7==2]
a8_net3=grad_8[yeo7==3]
a8_net4=grad_8[yeo7==4]
a8_net5=grad_8[yeo7==5]
a8_net6=grad_8[yeo7==6]
a8_net7=grad_8[yeo7==7]
a8_net1_ave=np.mean(a8_net1)-np.mean(a67_net1)
a8_net2_ave=np.mean(a8_net2)-np.mean(a67_net2)
a8_net3_ave=np.mean(a8_net3)-np.mean(a67_net3)
a8_net4_ave=np.mean(a8_net4)-np.mean(a67_net4)
a8_net5_ave=np.mean(a8_net5)-np.mean(a67_net5)
a8_net6_ave=np.mean(a8_net6)-np.mean(a67_net6)
a8_net7_ave=np.mean(a8_net7)-np.mean(a67_net7)

a9_net1=grad_9[yeo7 == 1]
a9_net2=grad_9[yeo7==2]
a9_net3=grad_9[yeo7==3]
a9_net4=grad_9[yeo7==4]
a9_net5=grad_9[yeo7==5]
a9_net6=grad_9[yeo7==6]
a9_net7=grad_9[yeo7==7]
a9_net1_ave=np.mean(a9_net1)-np.mean(a67_net1)
a9_net2_ave=np.mean(a9_net2)-np.mean(a67_net2)
a9_net3_ave=np.mean(a9_net3)-np.mean(a67_net3)
a9_net4_ave=np.mean(a9_net4)-np.mean(a67_net4)
a9_net5_ave=np.mean(a9_net5)-np.mean(a67_net5)
a9_net6_ave=np.mean(a9_net6)-np.mean(a67_net6)
a9_net7_ave=np.mean(a9_net7)-np.mean(a67_net7)

a10_net1=grad_10[yeo7 == 1]
a10_net2=grad_10[yeo7==2]
a10_net3=grad_10[yeo7==3]
a10_net4=grad_10[yeo7==4]
a10_net5=grad_10[yeo7==5]
a10_net6=grad_10[yeo7==6]
a10_net7=grad_10[yeo7==7]
a10_net1_ave=np.mean(a10_net1)-np.mean(a67_net1)
a10_net2_ave=np.mean(a10_net2)-np.mean(a67_net2)
a10_net3_ave=np.mean(a10_net3)-np.mean(a67_net3)
a10_net4_ave=np.mean(a10_net4)-np.mean(a67_net4)
a10_net5_ave=np.mean(a10_net5)-np.mean(a67_net5)
a10_net6_ave=np.mean(a10_net6)-np.mean(a67_net6)
a10_net7_ave=np.mean(a10_net7)-np.mean(a67_net7)

a11_net1=grad_11[yeo7 == 1]
a11_net2=grad_11[yeo7==2]
a11_net3=grad_11[yeo7==3]
a11_net4=grad_11[yeo7==4]
a11_net5=grad_11[yeo7==5]
a11_net6=grad_11[yeo7==6]
a11_net7=grad_11[yeo7==7]
a11_net1_ave=np.mean(a11_net1)-np.mean(a67_net1)
a11_net2_ave=np.mean(a11_net2)-np.mean(a67_net2)
a11_net3_ave=np.mean(a11_net3)-np.mean(a67_net3)
a11_net4_ave=np.mean(a11_net4)-np.mean(a67_net4)
a11_net5_ave=np.mean(a11_net5)-np.mean(a67_net5)
a11_net6_ave=np.mean(a11_net6)-np.mean(a67_net6)
a11_net7_ave=np.mean(a11_net7)-np.mean(a67_net7)

a12_net1=grad_12[yeo7 == 1]
a12_net2=grad_12[yeo7==2]
a12_net3=grad_12[yeo7==3]
a12_net4=grad_12[yeo7==4]
a12_net5=grad_12[yeo7==5]
a12_net6=grad_12[yeo7==6]
a12_net7=grad_12[yeo7==7]
a12_net1_ave=np.mean(a12_net1)-np.mean(a67_net1)
a12_net2_ave=np.mean(a12_net2)-np.mean(a67_net2)
a12_net3_ave=np.mean(a12_net3)-np.mean(a67_net3)
a12_net4_ave=np.mean(a12_net4)-np.mean(a67_net4)
a12_net5_ave=np.mean(a12_net5)-np.mean(a67_net5)
a12_net6_ave=np.mean(a12_net6)-np.mean(a67_net6)
a12_net7_ave=np.mean(a12_net7)-np.mean(a67_net7)

a67=np.array([a67_net1_ave,a67_net2_ave,a67_net3_ave,a67_net4_ave,a67_net5_ave,a67_net6_ave,a67_net7_ave])
a8=np.array([a8_net1_ave,a8_net2_ave,a8_net3_ave,a8_net4_ave,a8_net5_ave,a8_net6_ave,a8_net7_ave])
a9=np.array([a9_net1_ave,a9_net2_ave,a9_net3_ave,a9_net4_ave,a9_net5_ave,a9_net6_ave,a9_net7_ave])
a10=np.array([a10_net1_ave,a10_net2_ave,a10_net3_ave,a10_net4_ave,a10_net5_ave,a10_net6_ave,a10_net7_ave])
a11=np.array([a11_net1_ave,a11_net2_ave,a11_net3_ave,a11_net4_ave,a11_net5_ave,a11_net6_ave,a11_net7_ave])
a12=np.array([a12_net1_ave,a12_net2_ave,a12_net3_ave,a12_net4_ave,a12_net5_ave,a12_net6_ave,a12_net7_ave])
dataLenth = 7

labels = np.array([u" VN ", u" SN ", u" DAN ", u" VAN ", u" LN ",u" FPN ",u" DMN ",u" VN "])
angles = np.linspace(0, 2*np.pi, 8, endpoint=True)
stats1 = np.concatenate((a67, [a67[0]]))
stats2 = np.concatenate((a8, [a8[0]]))
stats3 = np.concatenate((a9, [a9[0]]))
stats4 = np.concatenate((a10, [a10[0]]))
stats5 = np.concatenate((a11, [a11[0]]))
stats6 = np.concatenate((a12, [a12[0]]))

fig = plt.figure(dpi=200)
ax = fig.add_subplot(111, polar=True)

ax.plot(angles, stats1,color='lightcoral',marker= 'o',  linestyle='solid', linewidth=1, markersize=0)
ax.fill(angles, stats1, alpha=0.00)
ax.plot(angles, stats2, color='darkorange',marker='o', linestyle='solid', linewidth=1, markersize=0)
ax.fill(angles, stats2, alpha=0)
ax.plot(angles, stats3,color='gold',marker= 'o',  linestyle='solid', linewidth=1, markersize=0)
ax.fill(angles, stats3, alpha=0.00)
ax.plot(angles, stats4,color='lightgreen',marker= 'o',  linestyle='solid', linewidth=1, markersize=0)
ax.fill(angles, stats4, alpha=0.00)
ax.plot(angles, stats5, color='lightskyblue',marker='o', linestyle='solid', linewidth=1, markersize=0)
ax.fill(angles, stats5, alpha=0)
ax.plot(angles, stats6,color='darkviolet',marker= 'o',  linestyle='solid', linewidth=1, markersize=0)
ax.fill(angles, stats6, alpha=0.00)
ax.set_thetagrids(angles * 180/np.pi, labels,fontsize=15, fontstyle='normal')
plt.title(' ')

ax.grid(linestyle="--", linewidth=0.5,color="k")


ax.set_rlabel_position(80)
ax.spines['polar'].set_visible(False)
figure=plt.gcf()

plt.show()
#
