## ---------------------------
##
## Script name: integrate_and_reduce.R
##
## Purpose of script: Demonstrate the single-view and multi-view integration and reduction stragegies used
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

# Load the required packages
list_of_packages <- c("ggplot2", "Spectrum","phateR","gghalves","ggdist","viridis","ggpmisc","ggpubr")
lapply(list_of_packages, library, character.only = TRUE)

### Note:: Spectrum, PHATE and UMAP require different orientations of the matrix.

### Create single-view reductions using just PHATE for the RNA-Sequencing
rna_phate <- phateR::phate(t(hnsc_rna))
rna_phate <- data.frame(rna_phate$embedding)
ggplot(rna_phate,aes(PHATE1,PHATE2,colour=hnsc_metadata$Papillion.Cavanagh)) + geom_point() + theme_minimal()

### Create single-view reductions using just PHATE for the Methylation
meth_phate <- phateR::phate(t(hnsc_meth))
meth_phate <- data.frame(meth_phate$embedding)
ggplot(meth_phate,aes(PHATE1,PHATE2,colour=hnsc_metadata$Papillion.Cavanagh)) + geom_point() + theme_minimal()

### Create single-view reductions using just PHATE for the MICROBIOME
micro_phate <- phateR::phate(t(hnsc_micro))
micro_phate <- data.frame(micro_phate$embedding)

### Plotting commands to recreate Figure 3
ggplot(rna_phate,aes(PHATE1,PHATE2,colour=hnsc_metadata$Papillion.Cavanagh)) + geom_point() + theme_minimal()
ggplot(meth_phate,aes(PHATE1,PHATE2,colour=hnsc_metadata$Papillion.Cavanagh)) + geom_point() + theme_minimal()
ggplot(micro_phate,aes(PHATE1,PHATE2,colour=hnsc_metadata$Papillion.Cavanagh)) + geom_point() + theme_minimal()

### Create cross-view integration using spectrum and PHATE for all three modalities
integrated_kernel <- Spectrum::Spectrum(list(hnsc_rna,hnsc_meth,hnsc_micro),method = 2,tunekernel = T)

integrated_phate <- phateR::phate(integrated_kernel$similarity_matrix,t = 200,
                                  seed=NULL,knn.dist.method = 'euclidean')

integrated_phate <- data.frame(integrated_phate$embedding)
### Plotting commands to show the multimodal projections (Figure 3, 4A)

ggplot(integrated_phate,aes(PHATE1,PHATE2,colour=as.factor(integrated_kernel$assignments))) +
  geom_point() + theme_minimal() + labs(colour="Spectral Clusters")

### Plotting commands to show the multimodal projections using our manuscript labels (Figure 3, 4A)

ggplot(integrated_phate,aes(PHATE1,PHATE2,colour=hnsc_metadata$manuscript_clusters)) +
  geom_point() + theme_minimal() + labs(colour="Spectral Clusters")



