## ---------------------------
##
## Script name: survival_analysis.Rß
##
## Purpose of script: Demonstrate calculating per-group survival statisticsß
##
## Author:Jonathan E. Bard
##
## Date Created: 2022-02-05
##
## Email: jbard@buffalo.edu
##
## ---------------------------
##
## Notes: Example code for the manuscript titled "Multimodal dimension reduction
## and tumor classification of head and neck squamous cell tumors."
##
## ---------------------------

library(dplyr);library(survival);library(survminer);library(plyr);library(survMisc)

### convert the overall survival status into a boolean variable
hnsc_metadata$is_alive <- revalue(hnsc_metadata$Overall.Survival.Status,c("0:LIVING"=F, "1:DECEASED"=T))
hnsc_metadata$is_alive <- as.logical(hnsc_metadata$is_alive)

?survfit()

## Generate the overall survival curve using the available TCGA data, split by our manuscript clusters
sfit <- survfit(Surv(Overall.Survival..Months.,
                     is_alive)~manuscript_clusters,
                data=hnsc_metadata,)

## actually generate the Kaplan-Meier curve
g1 <- ggsurvplot(sfit, conf.int=F, pval=TRUE,pval.method=T,xlim=c(0,110),
                   xlab = "Months", 
                   ylab = "Overall survival probability",
                   legend.title="",
                   legend.labs=levels(hnsc_metadata$manuscript_clusters),
                   palette = "Set1",
                   ggtheme = theme_bw())

print(g1)


# Optional strategy Cox proportional hazards regression model
coxph(Surv(Overall.Survival..Months.,
           is_alive)~manuscript_clusters, data=hnsc_metadata)
