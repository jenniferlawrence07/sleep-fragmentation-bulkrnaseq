#final PCA and heatmap without outlier see "03_outlier_removal.R" 

library(DESeq2)
library(vsn)
library(pheatmap)

ntd_filtered <- normTransform(ddsHypo_filtered)

vsd_filtered <- vst(ddsHypo_filtered, blind = FALSE)
rld_filtered <- rlog(ddsHypo_filtered, blind = FALSE)
head(assay(vsd_filtered), 3)

#heatmap 
select <- order(rowMeans(counts(ddsHypo_filtered, normalized = TRUE)), decreasing = TRUE)[1:20] # nolint
df <- as.data.frame(colData(ddsHypo_filtered)[, c("sample", "treatment")])
hypo_heatmap_filtered <- pheatmap(assay(ntd_filtered)[select, ],
  cluster_rows = FALSE, show_rownames = FALSE,
  cluster_cols = FALSE, annotation_col = df
)

ggsave("heatmap_hypo_final.png", plot <- hypo_heatmap_filtered, device = NULL, path = "figures/hypothalamus", scale = 1, 
width = 10, height = 10, dpi = 600)

#PCA 
hypo_PCA_filtered <- plotPCA(vsd_filtered, intgroup = c("treatment"))
hypo_PCA_filtered
