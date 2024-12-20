clc;clear all;
geneTable=readtable("GOea_results_all .csv");
surr=readtable('updated_significant_go_terms.csv');

significantGO = geneTable(geneTable.pvalue < 0.05, :);
Generatio=significantGO.GeneRatio;
P_s=surr.P_s;
numeric_data = zeros(size(Generatio));
p=significantGO.p_adjust;
count=significantGO.Count;
BgRatio=significantGO.BgRatio;

for i = 1:numel(Generatio)

    cleaned_data = Generatio{i,1};
    splitStr = strsplit(cleaned_data, '/');


num1 = str2double(splitStr{1});
num2 = str2double(splitStr{2});
   

    numeric_data(i) = num1/num2;
end
bg=zeros(size(Generatio));
for i = 1:numel(BgRatio)

    cleaned_data = BgRatio{i,1};
    splitStr = strsplit(cleaned_data, '/');


num1 = str2double(splitStr{1});
num2 = str2double(splitStr{2});
    bg(i) = num1/num2;
end
Fold=numeric_data./bg;
logp=-log10(p);
alpha=logp/max(logp);
daxiao=mapminmax(count,0,1);
loge=log2(Fold);

h=figure;
xx=0;
for i=1:length(Fold)
    temdaxiao=5*daxiao(i);
h=scatter(loge(i), logp(i), temdaxiao, 'MarkerFaceColor', [0.8 0.6 1], 'MarkerFaceAlpha', alpha(i), 'MarkerEdgeAlpha', 0);
hold on;
if P_s(i)<0.05&p(i)<0.05
    h=scatter(loge(i), logp(i), temdaxiao, 'MarkerFaceColor', [0.8 0.6 1], 'MarkerFaceAlpha', alpha(i), 'MarkerEdgeColor',[0 0 0] );
xx=xx+1;
        text(loge(i), logp(i), num2str(i), 'Color', [0 0 0], 'FontSize', 5, 'HorizontalAlignment', 'center');
end
hold on
end

xlabel('Enrichment ratio (log2)', 'FontSize', 30, 'FontWeight', 'bold');
ylabel('-log10(p) FDR-corrected', 'FontSize', 30, 'FontWeight', 'bold');

set(gca, 'LineWidth', 1.5, 'FontSize', 20);

set(gcf, 'Position', [10, 10, 1200, 800]);
