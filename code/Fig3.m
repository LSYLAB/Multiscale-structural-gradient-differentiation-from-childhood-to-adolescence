clc;clear all;
%% prepare grad data
grad=importdata("Mor_pC1_stats_results.csv");
grad=grad.data;
grad=grad(:,3);
%% prepare morphology data
mor=importdata("G1_stats_results.csv");
mor=mor.data;
mor=mor(:,3);
x1=grad;
y1=mor;
alpha = 0.05;
x11 = [ ones(length(y1),1), x1];
[b1,bint1,r1,rint1,stats1] = regress(y1, x11);
p=stats1(3)%%回归的p值
[p1,s1]=polyfit(x1,y1,1);
xx1=linspace((min(x1)-0.1),(max(x1)+0.1));
yy1=polyval(p1,xx1);
[Y1,DELTA1] = polyconf(p1,xx1,s1,'alpha',alpha,'predopt','curve');
r1=corrcoef(x1,y1)%%相关系数r

w=figure(1);

% plot(mor,grad,'.','Color',[0.909,0.36,0.36],'MarkerSize',20);
scatter(mor,grad,30,mor,'filled');
colormap(flipud(othercolor('PiYG10'))); 
colorbar
% caxis([-7 7])
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

axis([(min(x1)-0.001) (max(x1)+0.001) (min(y1)-0.001) (max(y1)+0.001)]);

box off
xlabel('PCA 1')
ylabel('Gradient 1')
set(gcf,'Units','centimeters','Position',[0.1 0.1 20 20]);
set(gca,'FontSize',24,'LineWidth',3,'fontname','Arial');
str_fig2=strcat('Mor_PCA1_with_grad1_scatter_fit');

saveas(gcf,str_fig2,'epsc')
saveas(gcf,str_fig2,'tif')


