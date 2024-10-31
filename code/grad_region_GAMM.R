library(nlme)
library(mgcv)
library(gamRR)
library(ggplot2)
library(visreg)
library(viridis)
library(readxl)
library(R.matlab)
data <- read.csv('G:/CBD_multiscale_results_v2/CBD_grad_data_align_1000/G1_all.csv')
Data <- read_excel("G:/CBD_multiscale_results_v2/CBD_AGE_SEX.xlsx")
Age=Data$Age
subject=Data$unique
Sex=Data$Sex
Glo <- read_excel("G:/CBD_multiscale_results_v2/CBD_grad_global_measure/globa_v2.xlsx")
mFD=Glo$mean_FD
outdir = "G:/CBD_multiscale_results_v2/R_results"
BIC_values <- c()
# 获取Glo数据框架的所有列名
variables <- names(data)
stats.results_list <- list()
# 循环遍历每个变量
for (variable in variables) {
  y1 <- data[[variable]]
  
  gam.model <- gam(y1 ~ s(Age, bs="cs", k=3) + Sex + s(subject, bs="re") + mFD, data=Data, method="REML", na.action="na.omit")
  BIC_values <- BIC(gam.model)
  
  gam.results <- summary(gam.model)
  gam.smooth.F <- gam.results$s.table[1,3]
  print(gam.smooth.F)
  gam.smooth.pvalue <- gam.results$s.table[1,4]
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
