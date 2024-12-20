clc;clear all;
[data,list]=xlsread('E:\desktop\CBD_AGE_SEX.xlsx');
Age=data(:,1);
k=length(Age);
list=list(2:438,:);
G1_R=inf(k,1);
G2_R=inf(k,1);
G3_R=inf(k,1);
S1=inf(k,1);
S2=inf(k,1);
S3=inf(k,1);
G1_Ex=inf(k,1);
G2_Ex=inf(k,1);
G3_Ex=inf(k,1);
Dis12=inf(k,1);
Dis13=inf(k,1);
Dis123=inf(k,1);
for i=1:k
name=list(i)
str_grad=strcat('G:\CBD_multiscale_results_v2\CBD_grad_data_align_1000\',name,'.mat');
str_grad=str_grad{1,1};
grad=load(str_grad);
grad=grad.Galign;
G1=grad(:,1);
G2=grad(:,2);
G3=grad(:,3);
G1_range=max(G1)-min(G1);
G2_range=max(G2)-min(G2);
G3_range=max(G3)-min(G3);
s1=std(G1);
s2=std(G2);
s3=std(G3);
D12=sum(sqrt((abs(G1-mean(G1))).^2+(abs(G2-mean(G2))).^2));
D13=sum(sqrt((abs(G1-mean(G1))).^2+(abs(G3-mean(G3))).^2));
D123=sum(sqrt((abs(G1-mean(G1))).^2+(abs(G2-mean(G2))).^2)+(abs(G3-mean(G3))).^2);
str_lamda=strcat('G:\CBD_multiscale_results_v2\CBD_lamda_data_align_1000\',name,'.mat');
str_lamda=str_lamda{1,1};
lamda=load(str_lamda);
lamda=lamda.lamda;
lamda=lamda/sum(lamda);
lamda1=lamda(1);
lamda2=lamda(2);
lamda3=lamda(3);
G1_R(i,1)=G1_range;
G2_R(i,1)=G2_range;
G3_R(i,1)=G3_range;
S1(i,1)=s1;
S2(i,1)=s2;
S3(i,1)=s3;
G1_Ex(i,1)=lamda1;
G2_Ex(i,1)=lamda2;
G3_Ex(i,1)=lamda3;
Dis12(i,1)=D12;
Dis13(i,1)=D13;
Dis123(i,1)=D123;

end
mkdir G:\CBD_multiscale_results_v2\CBD_grad_global_measure
tbl=table(G1_R,G2_R,G3_R,S1,S2,S3,G1_Ex,G2_Ex,G3_Ex,Dis12,Dis13,Dis123,'VariableNames',{'G1_range','G2_range','G3_range','G1_std','G2_std','G3_std','G1_explanation','G2_explanation','G3_explanation','Dispersion12','Dispersion13','Dispersion123'});
writetable(tbl,'G:\CBD_multiscale_results_v2\CBD_grad_global_measure\global.xlsx');