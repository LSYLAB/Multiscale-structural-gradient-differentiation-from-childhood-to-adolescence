clc;clear all;
load('Grad.mat');

%% read atlas and surface
[verticesl, labell, colortablel]=freesurfer_read_annot('lh.schaefer-1000_mics.annot');
tablel=colortablel.table(:,5);
[verticesr, labelr, colortabler]=freesurfer_read_annot('rh.schaefer-1000_mics.annot');
tabler=colortabler.table(:,5);
for i=1:501
    labell(find(labell==tablel(i)))=i-1;
end
for i=1:501
    labelr(find(labelr==tabler(i)))=i-1;
end
surf=SurfStatReadSurf( {...
    'fsaverage5\surf\lh.pial',...
    'fsaverage5\surf\rh.pial'} );

Gl_1=zeros(10242,1);
Gr_1=zeros(10242,1);
for h=1:500
Gl_1(find(labell==h))=Galign(h,1);
Gr_1(find(labelr==h))=Galign((h+500),1);
end
G_1=[Gl_1;Gr_1];

figure('visible','on');
% figure;
s1=SurfStatView(G_1,surf);% 画图(data,surf,'corlormap','background color')
material(s1,'dull')
% SurfStatColLim([-0.1 0.1]) 
colormap(flipud(othercolor('PuOr3'))); 
str_grad1_fig=strcat('grad1.tif');
saveas(gcf,str_grad1_fig);
