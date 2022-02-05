## ---------------------------
##
## Script name: load_unified_hnsc.R
##
## Purpose of script: Handles the loading and data checks for preprocessed TCGA
## head and neck tumor sample data and metadata for three data types.
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
##
## ---------------------------

### Load up the data frames by modality

hnsc_rna <- readRDS(file="data/TCGA-HNSC-Unified-RNA.RDS")
hnsc_meth <- readRDS(file="data/TCGA-HNSC-Unified-METH.RDS")
hnsc_micro <- readRDS(file="data/TCGA-HNSC-Unified-MICRO.RDS")

### make sure that the rownames are = to genes, probes, or microbes
### and that the column names are equivalent to the sample names
head(colnames(hnsc_rna))
head(colnames(hnsc_meth))
head(colnames(hnsc_micro))

tail(colnames(hnsc_rna))
tail(colnames(hnsc_meth))
tail(colnames(hnsc_micro))

hnsc_metadata <- read.table(file="data/TCGA-HNSC-METADATA.tsv",header = T,sep="\t")

### key columns for manuscript information --
### Multimodal PHATE projection results are stored in the manuscript_phate_1 and _2 columns
plot(hnsc_metadata$manuscript_phate_1,hnsc_metadata$manuscript_phate_2)


