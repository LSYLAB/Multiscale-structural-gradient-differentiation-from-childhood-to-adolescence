from matplotlib import pyplot as plt
import seaborn as sns
import scipy.io as scio



grad_67=scio.loadmat('align_67_Grad.mat')['Galign']
grad_67=grad_67[:,2]
grad_8=scio.loadmat('align_8_Grad.mat')['Galign']
grad_8=grad_8[:,2]
grad_9=scio.loadmat('align_9_Grad.mat')['Galign']
grad_9=grad_9[:,2]
grad_10=scio.loadmat('align_10_Grad.mat')['Galign']
grad_10=grad_10[:,2]
grad_11=scio.loadmat('align_11_Grad.mat')['Galign']
grad_11=grad_11[:,2]
grad_12=scio.loadmat('align_12_Grad.mat')['Galign']
grad_12=grad_12[:,2]

###histogram figure
sns.set_style("white")

sns.utils.axlabel('Gradient score', 'Frequency')



ax=sns.kdeplot(grad_67,shade=False,color="lightcoral")
ax=sns.kdeplot(grad_8,shade=False,color="darkorange")
ax=sns.kdeplot(grad_9,shade=False,color="gold")
ax=sns.kdeplot(grad_10,shade=False,color="lightgreen")
ax=sns.kdeplot(grad_11,shade=False,color="lightskyblue")
ax=sns.kdeplot(grad_12,shade=False,color="darkviolet")
sns.despine()
figure=ax.get_figure()
plt.show()