import numpy as np
import scipy.io as scio
import matplotlib.pyplot as plt


yeo7=scio.loadmat('G:\\parcellations\\schaefer400_yeo7_label.mat')['Label']
yeo7=np.squeeze(yeo7)


grad_67=scio.loadmat('align_67_Grad.mat')['Galign']

grad1=grad_67[:,0]
grad2=-grad_67[:,2]

g1net1=grad1[yeo7==1]
g1net2=grad1[yeo7==2]
g1net3=grad1[yeo7==3]
g1net4=grad1[yeo7==4]
g1net5=grad1[yeo7==5]
g1net6=grad1[yeo7==6]
g1net7=grad1[yeo7==7]
g2net1=grad2[yeo7==1]
g2net2=grad2[yeo7==2]
g2net3=grad2[yeo7==3]
g2net4=grad2[yeo7==4]
g2net5=grad2[yeo7==5]
g2net6=grad2[yeo7==6]
g2net7=grad2[yeo7==7]
cx1=np.mean(g1net1)
cy1=np.mean(g2net1)
cx2=np.mean(g1net2)
cy2=np.mean(g2net2)
cx3=np.mean(g1net3)
cy3=np.mean(g2net3)
cx4=np.mean(g1net4)
cy4=np.mean(g2net4)
cx5=np.mean(g1net5)
cy5=np.mean(g2net5)
cx6=np.mean(g1net6)
cy6=np.mean(g2net6)

colors1 = '#800080'
colors2 = '#4682B4'
colors3 = '#008000'
colors4 = '#EE82EE'
colors5 = '#FFFACD'
colors6 = '#FF8C00'
colors7 = '#DC143C'

fig, axes = plt.subplots(1, 1)
plt.xlabel('Grad3')
plt.ylabel('Grad1')

plt.axis([-0.06,0.05,-0.10,0.14])



plt.scatter(g2net1,g1net1, s=50, c=colors1, marker='o',alpha=0.7,label='VN')
plt.scatter(g2net2,g1net2, s=50, c=colors2, marker='o',alpha=0.7, label='SN')
plt.scatter(g2net3,g1net3, s=50, c=colors3, marker='o',alpha=0.7, label='DAN')
plt.scatter(g2net4,g1net4, s=50, c=colors4, marker='o',alpha=0.7, label='VAN')
plt.scatter(g2net5,g1net5, s=50, c=colors5, marker='o',alpha=0.7, label='LN')
plt.scatter(g2net6,g1net6, s=50, c=colors6,marker='o', alpha=0.7, label='FPN')
plt.scatter(g2net7,g1net7, s=50, c=colors7, marker='o',alpha=0.7, label='DMN')
axes.spines['top'].set_visible(False)
axes.spines['right'].set_visible(False)
axes.spines['bottom'].set_visible(True)
axes.spines['left'].set_visible(True)
figure=plt.gcf()


figure.savefig('yeo7_grad13.eps', format="eps", dpi=300)
figure.savefig('yeo7_grad13.tif', format="tif", dpi=300)