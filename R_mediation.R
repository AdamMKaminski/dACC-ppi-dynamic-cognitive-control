library(readr)
library(dplyr)
library(ggplot2)
library(scales)
library(quantmod)
library(reshape2)
library(mediation)
library(lavaan)
#library(boot)
#library(sem)

setwd("~/Desktop/PhD/Research_and_grants/Paper_1/Analyses/Mediation/FINAL")
mydata <- read.csv(file = './dataset.csv', header=TRUE)

#
# MEDIATOR is DLPFC
#

# A arm: IV to mediator, controlling for mean motion, age, gender, FSIQ

Model.M1 <- lm(DLPFC ~ CBCL_PC1 + mean_motion + Age + Gender + FSIQ, data=mydata)
summary(Model.M1)

# Direct effect: IV to DV, controlling for age, gender, FSIQ, and mediator

Model.Y1 <- lm(ABC ~ CBCL_PC1 + Age + Gender + FSIQ + DLPFC, data=mydata)
summary(Model.Y1)

# Mediation

results_dlpfc <- mediate(Model.M1, Model.Y1, treat='CBCL_PC1', mediator='DLPFC',
                   boot=TRUE, sims=1000)

#
# MEDIATOR is IPL
#

# A arm: IV to mediator, controlling for mean motion, age, gender, FSIQ

Model.M2 <- lm(IPL ~ CBCL_PC1 + mean_motion + Age + Gender + FSIQ, data=mydata)
summary(Model.M2)

# Direct effect: IV to DV, controlling for age, gender, FSIQ, and mediator

Model.Y2 <- lm(ABC ~ CBCL_PC1 + Age + Gender + FSIQ + IPL, data=mydata)
summary(Model.Y2)

# Mediation

results_ipl <- mediate(Model.M2, Model.Y2, treat='CBCL_PC1', mediator='IPL',
                   boot=TRUE, sims=1000)

#
# Multiple mediation with both DLPFC and IPL
#

model <- '
# outcome model 
ABC ~ c*CBCL_PC1 + b1*DLPFC + b2*IPL + b3*Age + b4*Gender + b5*FSIQ + b6*med_count

# mediator models
DLPFC ~ a11*CBCL_PC1 + a12*mean_motion + a13*Age + a14*Gender + a15*FSIQ + a16*med_count
IPL ~ a21*CBCL_PC1 + a22*mean_motion + a23*Age + a24*Gender + a25*FSIQ + a26*med_count

# indirect effects (IDE)
medVar1IDE  := a11*b1
medVar2IDE  := a21*b2
sumIDE := (a11*b1) + (a21*b2)

# total effect
total := c + (a11*b1) + (a21*b2)
DLPFC ~~ IPL # model correlation between mediators'

fit <- sem(model, data=mydata, se = "bootstrap", test = "bootstrap")
summary(fit, fit.measures=TRUE, standardize=TRUE, rsquare=TRUE)

fit_test <- sem(model, data=mydata, se = "bootstrap", test = "bootstrap", bootstrap=1000)
summary(fit_test, fit.measures=TRUE, standardize=TRUE, rsquare=TRUE)

# c
Model.Y2 <- lm(ABC ~ CBCL_PC1 + Age + Gender + FSIQ, data=mydata)
summary(Model.Y2)

#boot.fit <- parameterEstimates(fit, boot.ci.type="bca.simple")
#orig.fit <- fitMeasures(fit, "chisq")
#boot.fit <- bootstrapLavaan(fit, R=1000, type="bollen.stine",
#                             FUN=fitMeasures, fit.measures="chisq")
#pvalue.boot <- length(which(boot.fit > orig.fit))/length(boot.fit)
