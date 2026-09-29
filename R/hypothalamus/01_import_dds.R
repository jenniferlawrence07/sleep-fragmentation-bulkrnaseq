library(DESeq2)
library(tidyverse)

#replace first row with GENEID (DESeq has trouble if this is not the case)

hypo <- read.delim("data/hypothalamus/hypo_count_matrix_processed.txt",
 header = TRUE)

names(hypo)[1] <- "GeneID"
row.names(hypo) <- hypo$GeneID
hypo <- hypo[ , -1]

#create coldata 

samples <- c("X10_S19_L008_Aligned.out.bam","X11_S20_L008_Aligned.out.bam","X12_S21_L008_Aligned.out.bam",  # nolint
"X13_S22_L008_Aligned.out.bam","X14_S23_L008_Aligned.out.bam","X15_S24_L008_Aligned.out.bam", # nolint
"X16_S25_L008_Aligned.out.bam","X1_S10_L008_Aligned.out.bam","X2_S11_L008_Aligned.out.bam", # nolint
"X3_S12_L008_Aligned.out.bam","X4_S13_L008_Aligned.out.bam","X5_S14_L008_Aligned.out.bam", # nolint
"X6_S15_L008_Aligned.out.bam","X7_S16_L008_Aligned.out.bam","X8_S17_L008_Aligned.out.bam", # nolint
"X9_S18_L008_Aligned.out.bam")

treatment <- c("SD","SD","SD","Control","Control","Control","Control",
               "SD","SD","SD","SD","Control","Control","Control","Control","SD") 

coldata_hypo <- data.frame(sample = samples, treatment = treatment)

ddsHypo <- DESeqDataSetFromMatrix(countData = hypo, # nolint
                                   colData = coldata_hypo,
                                   design = ~ treatment)
ddsHypo <- DESeq(ddsHypo) # nolint
resHypo <- results(ddsHypo, contrast = c("treatment", "SD", "Control"), alpha = 0.05) # nolint

#make names match for figures 
clean_hypo <- sub("_.*", "", colnames(ddsHypo))   # "X9_S18_L008_Aligned.out.bam" -> "X9"
mouse_num  <- as.numeric(sub("^X", "", clean_hypo))  # "X9" -> 9

treatment_hypo <- as.character(colData(ddsHypo)$treatment)

new_names_hypo <- character(length(mouse_num))
sd_idx      <- which(treatment_hypo == "SD")
control_idx <- which(treatment_hypo == "Control")

new_names_hypo[sd_idx[order(mouse_num[sd_idx])]]           <- paste0("SD", seq_along(sd_idx))
new_names_hypo[control_idx[order(mouse_num[control_idx])]] <- paste0("C",  seq_along(control_idx))
new_names_hypo <- sub("^SD", "SF", new_names_hypo)

colnames(ddsHypo) <- new_names_hypo
rownames(coldata_hypo) <- new_names_hypo

identical(colnames(ddsHypo), rownames(coldata_hypo))  # should be TRUE
