
library(nlme)
library(mgcv)
library(gamRR)
library(ggplot2)
library(visreg)
library(viridis)
library(readxl)
library(R.matlab)
Glo <- read_excel("G:/CBD_multiscale_results_v2/CBD_grad_global_measure/globa_v2.xlsx")
Data <- read_excel("G:/CBD_multiscale_results_v2/CBD_AGE_SEX.xlsx")
Age=Data$Age
subject=Data$unique
Sex=Data$Sex
mFD=Glo$mean_FD
outdir = "G:/CBD_multiscale_results_v2/R_results"
BIC_values <- c()
# 获取Glo数据框架的所有列名
variables <- names(Glo)
stats.results_list <- list()
# 循环遍历每个变量
for (variable in variables) {
  y1 <- Glo[[variable]]

gam.model <- gam(y1 ~ s(Age, bs="cs", k=3) + Sex + s(subject, bs="re") + mFD, data=Data, method="REML", na.action="na.omit")
BIC_values <- BIC(gam.model)
myplot <- visreg(gam.model, "Age", gg = TRUE, line = list(col = "darkgreen"),type = "conditional", scale = "response", overlay = TRUE, partial = TRUE, rug = FALSE, ylab=variable)
myplot <- myplot + 
  theme_classic() +
  scale_x_continuous(breaks = c(6, 7, 8, 9, 10, 11, 12, 13, 14), labels = c("6", "7", "8", "9", "10", "11", "12", "13", "14")) +
  theme(panel.grid=element_blank()) + # 移除背景和网格线
  geom_point(color = "orange")  # 修改点的颜色为红色

# 显示图形
print(myplot)
gam.results <- summary(gam.model)
gam.smooth.F <- gam.results$s.table[1,3]
print(gam.smooth.F)
gam.smooth.pvalue <- gam.results$s.table[1,4]
print(gam.smooth.pvalue)
ggsave(paste0(outdir,"/",variable,".pdf",sep=""))
ggsave(paste0(outdir,"/",variable,".tiff",sep=""))
# write.csv(summary_df, file= "G:/CBD_multiscale_results_v2/R_results/fit_G_summary.csv",, row.names = TRUE)
#Calculate the magnitude and significance of the smooth term effect based on delta adjusted R^2
##Compare a full model GAM (with the smooth term) to a nested, reduced model (with covariates only)
gam.null_model <- gam(y1 ~ Sex + mFD, data=Data, method="REML", na.action="na.omit")
gam.null_model.results <- summary(gam.null_model)
anova.smooth.pvalue <- anova.gam(gam.null_model,gam.model,test='Chisq')$`Pr(>Chi)`[2] #anova between reduced and full models  
gam.adjRsq <- abs(gam.results$r.sq - gam.null_model.results$r.sq) #delta R.sq (adj) 
#to get the sign of the effect, fit a linear model and extract the sign
linearmodel <- lm(y1 ~ Age + Sex + subject + mFD, data=Data)
lm.model.t <- summary(linearmodel)$coefficients[2,3] #t-value for smooth_var
if(lm.model.t < 0){ #if the linear model t-value for smooth_var is less than 0, make the delta adj R.sq negative
  gam.adjRsq <- gam.adjRsq*-1}
stats.results <- cbind(gam.smooth.F, gam.smooth.pvalue, gam.adjRsq, anova.smooth.pvalue)
stats.results_list[[variable]] <- stats.results
}
results_df <- do.call(rbind, stats.results_list)
results_df <- as.data.frame(results_df)

# 创建包含统计量名称的向量
col_names <- c("gam.smooth.F", "gam.smooth.pvalue", "gam.adjRsq", "anova.smooth.pvalue")

# 设置行名为变量名
rownames(results_df) <- names(stats.results_list)

# 添加列名
colnames(results_df) <- col_names

# 将数据保存为 CSV 文件
write.csv(results_df, file = "G:/CBD_multiscale_results_v2/R_results/Global_stats_results.csv")
