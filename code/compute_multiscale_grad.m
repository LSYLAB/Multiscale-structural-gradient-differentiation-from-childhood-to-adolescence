clc;clear all;
%% read atlas and surface
[verticesl, labell, colortablel]=freesurfer_read_annot('G:\\matlabdata\\parcellations\\lh.schaefer-400_mics.annot');
tablel=colortablel.table(:,5);
[verticesr, labelr, colortabler]=freesurfer_read_annot('G:\\matlabdata\\parcellations\\rh.schaefer-400_mics.annot');
tabler=colortabler.table(:,5);
for i=1:201
    labell(find(labell==tablel(i)))=i-1;
end
for i=1:201
    labelr(find(labelr==tabler(i)))=i-1;
end
surf=SurfStatReadSurf( {...
    'G:\matlabdata\fsaverage5\surf\lh.pial',...
    'G:\matlabdata\fsaverage5\surf\rh.pial'} );
mkdir G:\CBD_multiscale_results_v2\CBD_grad_data_400;
mkdir G:\CBD_multiscale_results_v2\CBD_Nor_matrix_data_400;
%% read mtlti-scale data 
list=dir(['G:\CBD_diffusion_results\CBDP_SC_matrix_400\']);
list(1:2,:)=[];
k=length(list);
for i=1:k
name=list(i).name;
name=name(1:9);
i
name
str_SC=strcat('G:\CBD_diffusion_results\CBDP_SC_matrix_400\',name,'_connectome_2m_schaefer400_cut006.csv');
SC=importdata(str_SC);
%1001:1200 2001:2200
SC=SC(1001:2200,1001:2200);
SC(201:1000,:)=[];
SC(:,201:1000)=[];
SC=log(SC);
SC(isinf(SC))=0;

str_GD=strcat('G:\CBD_multiscale_results_v2\GD_matrix_400\',name,'_ges_dist_chamfer400.mat');
Ddist=load(str_GD);
Ddist=Ddist.Ddist;
Ddist(1,:)=[];
Ddist(:,1)=[];
Ddist(201,:)=[];
Ddist(:,201)=[];
GD=Ddist;

str_MPC=strcat('G:\MPC_results_14\MPC_matrix_400\_',name,'_MPC_matrix.mat');
MPC=load(str_MPC);
MPC=MPC.R;
% x=[0.3 0.2 0.1; 0.4 0.5 1; 0.7 0.6 0.9]
[val, idx]  = sort(SC(:), 'ascend');
SC_norm   = sort_back((1:length(SC(:)))', idx);
SC_norm   = reshape(SC_norm, [size(SC)]);
SC_norm   = (SC_norm - (numel(SC) - nnz(SC))) .* (SC>0);
    
    % geodesic distance
    this_gd     = 1./GD;  % invert distance matrix
    [~, idx]    = sort(this_gd(:), 'ascend');
    this_gd     = sort_back((1:length(this_gd(:)))', idx);
    this_gd(this_gd==0) = nan;
    gd_scale   = rescale(this_gd(:), 1, max(SC_norm(:)));
    gd_norm    = reshape(gd_scale, [size(GD)]);
    gd_norm(isnan(gd_norm)) = 0;
    
    % microstructure profile covariance

    [~, idx] = sort(MPC(:), 'ascend');  % larger numbers are higher rank
    this_mpc = sort_back((1:length(MPC(:)))', idx);
    this_mpc = rescale(this_mpc(:), 1, max(SC_norm(:)));
    this_mpc(this_mpc==0) = nan;
    mpc_scale  = rescale(this_mpc(:), 1, max(SC_norm(:)));
    mpc_norm   = reshape(mpc_scale, [size(MPC)]);
    mpc_norm(isnan(mpc_norm)) = 0;
    
%     mat_horz            = [gd_norm mpc_norm SC_norm];
mat_horz = [gd_norm mpc_norm SC_norm];
  affinity_matrix     = 1-squareform(pdist(mat_horz'.','cosine'));
  affinity_matrix(isnan(affinity_matrix)) = 0;
  norm_angle_matrix    = 1-acos(affinity_matrix)/pi;
% figure('visible','on');
% imagesc(norm_angle_matrix );
% colormap(othercolor('PuOr3')); 
% colorbar;
% str_Nor_matrix_fig=strcat('G:\CBD_multiscale_results\CBD_Nor_matrix_figure\',name,'.tif');
% saveas(gcf,str_Nor_matrix_fig);
str_Nor_matrix_data=strcat('G:\CBD_multiscale_results_v2\CBD_Nor_matrix_data_400\',name);
save(str_Nor_matrix_data,'norm_angle_matrix');

Galign = GradientMaps('kernel','none','approach','dm','alignment','pa');
Galign = Galign.fit({norm_angle_matrix},'sparsity',0);
% lamda=Galign.lambda{1};
% % figure('visible','off')
% % handles = scree_plot(lamda);
% % str_lamda_fig=strcat('F:\CBD_multiscale_results\CBD_lamda_figure\',name,'.tif');
% % saveas(gcf,str_lamda_fig);
% str_lamda_data=strcat('G:\CBD_multiscale_results\CBD_lamda_data_400\',name);
% save(str_lamda_data,'lamda');

Galign=Galign.aligned{1,1};
str_grad_data=strcat('G:\CBD_multiscale_results_v2\CBD_grad_data_400\',name);
save(str_grad_data,'Galign');
% %% grad 1 
% Gl_1=zeros(10242,1);
% Gr_1=zeros(10242,1);
% for h=1:200
% Gl_1(find(labell==h))=Galign(h,1);
% Gr_1(find(labelr==h))=Galign((h+200),1);
% end
% G_1=[Gl_1;Gr_1];
% figure('visible','off');
% s1=SurfStatView(G_1,surf, 'grad1');% 画图(data,surf,'corlormap','background color')
% material(s1,'dull')
% colormap(othercolor('PuOr3')); 
% str_grad1_fig=strcat('G:\CBD_multiscale_results\CBD_grad_figure_400\',name,'_grad1.tif');
% saveas(gcf,str_grad1_fig);
% %% grad 2
% Gl_2=zeros(10242,1);
% Gr_2=zeros(10242,1);
% for h=1:200
% Gl_2(find(labell==h))=Galign(h,2);
% Gr_2(find(labelr==h))=Galign((h+200),2);
% end
% G_2=[Gl_2;Gr_2];
% figure('visible','off');
% s2=SurfStatView(G_2,surf, 'grad2');% 画图(data,surf,'corlormap','background color')
% material(s2,'dull')
% colormap(othercolor('PuOr3')); 
% str_grad2_fig=strcat('G:\CBD_multiscale_results\CBD_grad_figure_400\',name,'_grad2.tif');
% saveas(gcf,str_grad2_fig);
end