## ---------------------------
##
## Script name: analysis_plots.r
##
## Purpose of script: Demonstrate individual analysis plots using the integrated projection
##
## Author:Jonathan E. Bard
##
## Date Created: 2022-02-05
##
## Email: jbard@buffalo.edu
##
## ---------------------------
## Notes: Example code for the manuscript titled "Multimodal dimension reduction
## and tumor classification of head and neck squamous cell tumors."
##
## ---------------------------

### we used the viridis color palette for the majority of our plots
list_of_packages <- c("ggplot2", "Spectrum","phateR","gghalves","ggdist","viridis","ggpmisc","ggpubr")
lapply(list_of_packages, library, character.only = TRUE)


### First, let's demonstrate single gene analysis views using the manuscript projections and clustering

## stored in our metadata, we have the integrated PHATE1 and PHATE2 coordinates
## For RNA features, we can call the individual gene rows by using the gene name
## by default, this plots the RSEM normalized values in the original matrix.
ggplot(hnsc_metadata,aes(manuscript_phate_1,manuscript_phate_2,colour=hnsc_rna["KRT14",])) +
  geom_point() + theme_minimal() + labs(colour="norm(KRT14)") + scale_colour_viridis(direction=-1)

## For visualization purposes, we opted to use the z-score values using the rbase function scale()
ggplot(hnsc_metadata,aes(manuscript_phate_1,manuscript_phate_2,colour=scale(hnsc_rna["KRT14",]))) +
  geom_point() + theme_minimal() + labs(colour="z-score(KRT14)") + scale_colour_viridis(direction=-1)


## We can also view this information as a boxplot for both the rsem normalized and z-score data
ggplot(hnsc_metadata,aes(manuscript_clusters,hnsc_rna["KRT14",],fill=manuscript_clusters)) +
  geom_boxplot(outlier.size = .05) + scale_fill_brewer(type="qual",palette="Set1")+
  ylab("z-score KRT14") +
  xlab("") + theme_minimal() + theme(legend.position="none")

ggplot(hnsc_metadata,aes(manuscript_clusters,scale(hnsc_rna["KRT14",]),fill=manuscript_clusters)) +
         geom_boxplot(outlier.size = .05) + scale_fill_brewer(type="qual",palette="Set1")+
         ylab("z-score KRT14") +
         xlab("") + theme_minimal() + theme(legend.position="none")

## Though it requires more packages, we also like the raincloud plots to see the individual distributions
library(ggdist);library(gghalves)
ggplot(hnsc_metadata,
       aes(x=manuscript_clusters,
           scale(hnsc_rna["KRT14",],),
           fill=manuscript_clusters)) +
  scale_fill_brewer(type="qual",palette = "Set1")+
  ## add half-violin from {ggdist} package
  ggdist::stat_halfeye(
    adjust = .5, 
    width = .6, 
    .width = 0, 
    justification = -.2, 
    point_colour = NA
  ) + 
  geom_boxplot(
    width = .15, 
    outlier.shape = NA
  ) +
  ## add justified jitter from the {gghalves} package
  gghalves::geom_half_point(
    ## draw jitter on the left
    side = "l",shape=16,
    ## control range of jitter
    range_scale = .4, 
    ## add some transparency
    alpha = .3
  ) +
  coord_cartesian(xlim = c(1.2, NA), clip = "off") +
  ylab("KRT14")+ xlab("Clusters") + theme_minimal() + theme(legend.position="none")

### And finally, the Loess-Curve smoothing function, which pulls in two additional libraries
ggplot(hnsc_metadata,
       aes(manuscript_phate_1,scale(hnsc_rna["KRT14",]))) +
  geom_smooth(size=1) +
  ggtitle("KRT14 over PHATE1 Axis") +
  ylab("loess(KRT14)") +
  theme(legend.position="none")  +
  stat_fit_glance(method = "lm", size=5,
                  label.y = "bottom",label.x ="right",
                  method.args = list(formula = y ~ x),
                  mapping = aes(label = sprintf('r^2~"="~%.3f~~italic(P)~"="~%.2g',
                                                stat(r.squared), stat(p.value))),
                  parse = TRUE)

#### Changing data types is straight forward, making calls to the other input matrix

## Methylation plot example
ggplot(hnsc_metadata,aes(manuscript_phate_1,manuscript_phate_2,
                          colour=hnsc_meth["cg16764781",])) +
  geom_point(size=1) + ggtitle("") + xlab("PHATE1") + ylab("PHATE2") +
  scale_colour_viridis(direction=-1,option = "magma")+ labs(color="TP63-cg16764781") + theme_minimal() +
  theme(legend.position = c(.5,.85),legend.direction = "horizontal")

## Microbiome plot example
ggplot(hnsc_metadata,aes(manuscript_phate_1,manuscript_phate_2,
                         colour=scale(hnsc_micro["Alphapapillomavirus",]))) +
  geom_point(size=1) + ggtitle("") + xlab("PHATE1") + ylab("PHATE2") +
  scale_colour_viridis(direction=-1,option = "magma")+ labs(color="Alphapapillomavirus") + theme_minimal() +
  theme(legend.position = c(.5,.85),legend.direction = "horizontal")


## ESTIMATE Score projections
ggplot(hnsc_metadata,aes(manuscript_phate_1,manuscript_phate_2,
                         colour=scale(hnsc_metadata$estimate_stromal_score))) +
  geom_point(size=1) + ggtitle("") + xlab("PHATE1") + ylab("PHATE2") +
  scale_colour_viridis(direction=-1,option = "inferno")+ labs(color="ESTIMATE Stromal") + theme_minimal() +
  theme(legend.position = c(.5,.85),legend.direction = "horizontal")


