# Multimodal Integration of TCGA-HNSC
Multimodal Dimension Reduction and Subtype Classification of Head and Neck Squamous Cell Tumors
Jonathan E. Bard, Norma J. Nowak, Michael J. Buck, Satrajit Sinha

<h3>Abstract</h3>
Traditional analysis of genomic data from bulk sequencing experiments seek to group and compare sample cohorts into biologically meaningful groups. To accomplish this task, samples are often subjected to principal component analysis (PCA) and various clustering methods. These approaches, although straightforward to implement, are limited to a single data modality, capturing a limited representation of a sample. To provide a more robust method for cancer sub-type classification we have developed a computational strategy employing multimodal integration paired with spectral clustering, and modern dimension reduction techniques such as PHATE. Using this integrated approach, we have examined 514 Head and Neck Squamous Carcinoma (HNSC) tumor samples from TCGA across gene-expression, DNA-methylation, and microbiome data modalities. We show that these approaches, primarily developed for single-cell sequencing can be efficiently applied to bulk tumor sequencing data. Our multimodal analysis is able to capture the dynamic heterogeneity, identify new and refined subtypes of HNSC, and order tumor samples along well-defined cellular trajectories. Collectively, these results showcase the inherent molecular complexity of tumors and offer insights into carcinogenesis and importance of targeted therapy. Computational techniques as highlighted in our study provide an organic and powerful approach to identify granular patterns in large and noisy datasets that may otherwise be overlooked using traditional clustering and visualization strategies.

Bard JE, Nowak NJ, Buck MJ and Sinha S (2022) Multimodal Dimension Reduction and Subtype Classification of Head and Neck Squamous Cell Tumors. Front. Oncol. 12:892207. doi: 10.3389/fonc.2022.892207

https://www.frontiersin.org/articles/10.3389/fonc.2022.892207    


To view our multimodal clustering results for HNSC :

https://www.cbioportal.org/comparison/overlap?comparisonId=60804602e4b0242bd5d4984c


<h3>Dependencies:</h3>

`list_of_packages <- c("ggplot2", "Spectrum","phateR","gghalves","ggdist","viridis","ggpmisc","ggpubr")`

`lapply(list_of_packages, library, character.only = TRUE)`

RDS Data files to place into /data/ :
<code>
https://buffalo.box.com/s/j0bnkqmv6lg3yqhndv4xd0js5khqwhm4
</code>




