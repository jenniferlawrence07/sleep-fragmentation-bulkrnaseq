outlier_sample <- "X9_S18_L008_Aligned.out.bam"

ddsHypo_filtered <- ddshypo[, colnames(ddshypo) != outlier_sample]

# confirm it's actually gone — should show 15, not 16
ncol(ddsHypo_filtered)

ddsHypo_filtered <- DESeq(ddsHypo_filtered)
resHypo_filtered <- results(ddsHypo_filtered)
summary(resHypo_filtered)