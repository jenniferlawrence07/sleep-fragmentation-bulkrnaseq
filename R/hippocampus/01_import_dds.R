library(DESeq2)
library(tidyverse)

#replace first row with GENEID (DESeq has trouble if this is not the case)

hippo <- read.delim("data/hippocampus/Hippo_count_matrix_processed.txt",
 header = TRUE)

names(hippo)[1] <- "GeneID"
row.names(hippo) <- hippo$GeneID
hippo <- hippo[ , -1]

#create coldata 
sample = c("C1_Aligned.out.bam", "C2_Aligned.out.bam","C3_Aligned.out.bam", 
"C4_Aligned.out.bam","C5_Aligned.out.bam","C6_Aligned.out.bam", # nolint
"C7_Aligned.out.bam","C8_Aligned.out.bam","SD1_Aligned.out.bam",
"SD2_Aligned.out.bam","SD3_Aligned.out.bam","SD4_Aligned.out.bam",
"SD5_Aligned.out.bam","SD6_Aligned.out.bam","SD7_Aligned.out.bam",
"SD8_Aligned.out.bam")

treatment = c("Control", "Control", "Control", "Control", "Control", "Control", "Control", "Control", # nolint
"SD", "SD", "SD", "SD","SD","SD","SD","SD") # nolint

coldata_hippo <- data.frame(sample = sample, treatment = treatment)

ddsHippo <- DESeqDataSetFromMatrix(countData = hippo, # nolint
                                   colData = coldata_hippo,
                                   design = ~ treatment)
ddsHippo <- DESeq(ddsHippo) # nolint
resHippo <- results(ddsHippo, contrast = c("treatment", "SD", "Control"), alpha = 0.05)

clean_names_hippo <- sub("_.*", "", colnames(ddsHippo))
colnames(ddsHippo) <- clean_names_hippo
clean_names_hippo <- sub("^SD", "SF", clean_names_hippo)
rownames(coldata_hippo) <- clean_names_hippo
