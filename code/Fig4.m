clear all;
S_p=load('SC_PC_all.mat');
S_p=S_p.P;
S_p=mean(S_p)';
F_p=load('FC_PC_all.mat');
F_p=F_p.P;
F_p=mean(F_p)';
CP=load('FC_SC_coupling_average');
CP=CP.CP;
cp_rotated_L=importdata('FC_SC_coupling_average_rh_surrogate_brain_maps.csv');
cp_rotated_R=importdata('FC_SC_coupling_average_rh_surrogate_brain_maps.csv');
cp_rotated=[cp_rotated_L';cp_rotated_R'];
P=S_p;

[r_original, pval_spin] = corr(P',CP, ...
                'rows','pairwise','type','spearman');
r_rand = corr(P',cp_rotated, ...
            'rows','pairwise','type','spearman');

prctile_rank= mean(r_original > r_rand);       
significant= prctile_rank < 0.025 || prctile_rank >= 0.975;
%% surrogate 
figure;
% hist(r_rand_mor,50,'color','#DAA520');
hold on;
histfit(r_rand,50);
hold on;
x=r_original;
plot([x,x],[0,50],'color','y','linewidth',2);
r=r_original;
p=prctile_rank;
s=significant;
%% scatter
x1=P';
y1=CP;
alpha = 0.05;
x11 = [ ones(length(y1),1), x1];
[b1,bint1,r1,rint1,stats1] = regress(y1, x11);
p=stats1(3)
[p1,s1]=polyfit(x1,y1,1);
xx1=linspace((min(x1)-0.1),(max(x1)+0.1));
yy1=polyval(p1,xx1);
[Y1,DELTA1] = polyconf(p1,xx1,s1,'alpha',alpha,'predopt','curve');
r1=corrcoef(x1,y1)
figure;


plot(P,CP,'.','Color',[0.909,0.36,0.36],'MarkerSize',20);
% scatter(Lx,Ly,30,'filled','r');
hold on
h=plot(xx1,Y1,xx1,Y1+DELTA1,'--',xx1,Y1-DELTA1,'--');

hold on; 
set(h(1),'LineWidth',4,'Color',[0,0,0]);
hold on; 
set(h(2),'lineWidth',1,'Color',[0,0,0]);
set(h(3),'lineWidth',1,'Color',[0,0,0]);



hold on;
 XX1=[xx1';flipud(xx1')];
   YY1=[(Y1+DELTA1)';flipud((Y1-DELTA1)')];
  fill(XX1,YY1,[0,0,0],'facealpha',0.03,'edgealpha',0);

axis([(min(x1)-0.001) (max(x1)+0.001) (min(y1)-0.05) (max(y1)+0.05)]);

box off

xlabel('Multiscale structural gradient1')
ylabel('Coupling')
set(gcf,'Units','centimeters','Position',[0.1 0.1 20 20]);
set(gca,'FontSize',24,'LineWidth',3,'fontname','Arial');

