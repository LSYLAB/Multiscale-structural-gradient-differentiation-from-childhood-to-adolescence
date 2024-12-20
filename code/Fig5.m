clc; clear all; close all;

%% Define all the inputs
[data,list]=xlsread('E:\Desktop\CBD_AGE_SEX.xlsx');
Age=data(:,1);
k=length(Age);
list=list(2:438,:);
brain_data=zeros(k,1000);
for i=1:k
name=list(i)
str_grad=strcat('CBD_grad_data_align_1000\',name,'.mat');
str_grad=str_grad{1,1};
grad=load(str_grad);
grad=grad.Galign;
G1=grad(:,1);
brain_data(i,:)=G1;
end
% brain_data=load('G:\CBD_multiscale_results\CBD_within_network\Grad1_within_yeo7.mat');
% brain_data=brain_data.G1_yeo;
% brain_data=[G1_pc1 brain_data];
% brain_data=global_measure(:,[1 3 5 7 10])
wm_2=data(:,8);
wm_0=data(:,9);
ind=find(isnan(wm_2));
wm_2(ind)=[];
wm_0(ind)=[];
p=polyfit(wm_0,wm_2,1);
% wm_2 = polyval(p,wm_0)
wm=wm_2-p(1)*wm_0-p(2);

% Age(ind)=[];
% p2=polyfit(Age,wm,1);
% wm_2 = polyval(p,wm_0)
% wm=wm-p2(1)*Age-p2(2);

brain_data(ind,:)=[];
X0 = brain_data;
Y0behav=wm;
input.brain_data=X0;
input.behav_data = Y0behav;
input.grouping = ones(365,1);
input.behav_names = {'WM'}; 
for ii = 1:1000; input.img_names{ii,1} = ['reg ' num2str(ii)]; end
clear wm brain_data
% --- Permutations & Bootstrapping ---
pls_opts.nPerms = 1000;
pls_opts.nBootstraps = 1000;
% --- Data normalization options ---
% 0: no normalization
% 1: zscore across all subjects
% 2: zscore within groups (default for grouped PLSC, see Krishnan et al.,2011)
% 3: std normalization across subjects (no centering)
% 4: std normalization within groups (no centering)
pls_opts.normalization_img = 1;
pls_opts.normalization_behav = 1;
% --- PLS grouping option ---
% 0: PLS will computed over all subjects
% 1: R will be constructed by concatenating group-wise covariance matrices
%     (as in conventional behavior PLS, see Krishnan et al., 2011)
pls_opts.grouped_PLS = 0; 

% --- Permutations grouping option ---
% 0: permutations ignoring grouping
% 1: permutations within group
pls_opts.grouped_perm = 0;

% --- Bootstrapping grouping option ---
% 0: bootstrapping ignoring grouping
% 1: bootstrapping within group
pls_opts.grouped_boot = 0;
% --- Mode for bootstrapping procrustes transform ---
% in some cases, rotation only depending on U results in extremely low
% standard errors and bootstrap ratios close to infinity
% in mode 2, we therefore compute the transformation matrix both on U and V
% 1: standard
% 2: average rotation of U and V
pls_opts.boot_procrustes_mod = 2;
pls_opts.save_boot_resampling=1;
pls_opts.behav_type = 'behavior';
%% ---------- Options for result saving and plotting ----------
% --- path where to save the results ---
save_opts.output_path = 'cognition_pls\grad1_wm';

% --- prefix of all results files ---
% this is also the default prefix of the toolbox if you don't define
% anything
save_opts.prefix = sprintf('myPLS_%s_norm%d-%d',pls_opts.behav_type,...
    pls_opts.normalization_img, pls_opts.normalization_behav);

% --- Plotting grouping option ---
% 0: Plots ignoring grouping
% 1: Plots considering grouping
save_opts.grouped_plots = 0;

% --- Significance level for latent components ---
save_opts.alpha = 0.1; % for the sake of the example data
input.brain_data = input.brain_data(:,1:1000); 
save_opts.img_type = 'barPlot';
save_opts.fig_pos_img = [440   606   560   192];
save_opts.plot_boot_samples = 1; % binary variable indicating if bootstrap samples should be plotted in bar plots
save_opts.errorbar_mode = 'CI'; % 'std' = plotting standard deviations; 'CI' = plotting 95% confidence intervals
save_opts.hl_stable = 1; % binary variable indicating if stable bootstrap scores should be highlighted

% --- Customized figure size for behavior bar plots ---
save_opts.fig_pos_behav = [440   606   320   192];
%% Check all inputs for validity
% !!! always run this function to check your setup before running PLS !!!

[input,pls_opts,save_opts] = myPLS_initialize(input,pls_opts,save_opts);

%% Save & plot input data

% myPLS_plot_inputs(input,pls_opts,save_opts)

%% Run PLS analysis (including permutation testing and bootstrapping)

res = myPLS_analysis(input,pls_opts);

%% Save & plot results
% If you run multiple PLS analyses, correct the resulting p-values for
% multiple comparisons before executing the following function

myPLS_plot_results(res,save_opts);
Lx=res.Lx;
Ly=res.Ly;
sig_loading=zeros(1000,1);
for i=1:1000
    if res.boot_results.LC_img_loadings_mean(i,1)<0
        if res.boot_results.LC_img_loadings_uB(i,1) < 0 
           sig_loading(i,1)=1;
        end
    else
        if res.boot_results.LC_img_loadings_lB(i,1) > 0
            sig_loading(i,1)=1;
        end
    end
end
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
    'fsaverage5\surf\lh.inflated',...
    'fsaverage5\surf\rh.inflated'} );
Galign=res.LC_img_loadings;
Galign(find(sig_loading==0))=0;
Galign(find(sig_loading==1))=1;
% Galign=res.V;
% Galign=brain_data(1,:)';

Gl_1=zeros(10242,1);
Gr_1=zeros(10242,1);
for h=1:500
Gl_1(find(labell==h))=Galign(h,1);
Gr_1(find(labelr==h))=Galign((h+500),1);
end
G_1=[Gl_1;Gr_1];
% figure('visible','off');
figure;
s1=SurfStatView(G_1,surf, 'Loadings');% 画图(data,surf,'corlormap','background color')
material(s1,'dull')
% colormap([flipud(othercolor('RdBu6'))]); 
colormap([othercolor('Greys8')])
