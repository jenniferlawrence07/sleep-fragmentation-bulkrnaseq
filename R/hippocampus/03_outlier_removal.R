outlier_sample <- "SF1"

ddsHippo_filtered <- ddsHippo[, colnames(ddsHippo) != outlier_sample] # nolint

# confirm it's actually gone — should show 15, not 16
ncol(ddsHippo_filtered)

ddsHippo_filtered <- DESeq(ddsHippo_filtered)
resHippo_filtered <- results(ddsHippo_filtered)
summary(resHippo_filtered)
