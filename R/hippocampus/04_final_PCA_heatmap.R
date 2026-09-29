#final PCA and heatmap without outlier see "03_outlier_removal.R" 

library(DESeq2)
library(vsn)
library(pheatmap)

ntd_filtered <- normTransform(ddsHippo_filtered)

vsd_filtered <- vst(ddsHippo_filtered, blind = FALSE)
rld_filtered <- rlog(ddsHippo_filtered, blind = FALSE)
head(assay(vsd_filtered), 3)

#heatmap 
select <- order(rowMeans(counts(ddsHippo_filtered, normalized = TRUE)), decreasing = TRUE)[1:20] # nolint
df <- as.data.frame(colData(ddsHippo_filtered)[, c("sample", "treatment")])
hippo_heatmap_filtered <- pheatmap(assay(ntd_filtered)[select, ],
  cluster_rows = FALSE, show_rownames = FALSE,
  cluster_cols = FALSE, annotation_col = df
)

ggsave("heatmap_hippo_final.png", plot <- hippo_heatmap_filtered, device = NULL, path = "figures/hippocampus", scale = 1, 
width = 10, height = 10, dpi = 600)

#PCA 
hippo_PCA_filtered <- plotPCA(vsd_filtered, intgroup = c("treatment"))
hippo_PCA_filtered