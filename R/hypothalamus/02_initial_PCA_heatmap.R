library(DESeq2)
library(vsn)
library(pheatmap)
library(ggplot2)
library(ggrepel)

# confirm rename already applied
colnames(ddsHypo)

# data transformations
ntd <- normTransform(ddsHypo)

vsd <- vst(ddsHypo, blind = FALSE)
rld <- rlog(ddsHypo, blind = FALSE)
head(assay(vsd), 3)

# heatmap
select <- order(rowMeans(counts(ddsHypo, normalized = TRUE)), decreasing = TRUE)[1:20]

df <- as.data.frame(colData(ddsHypo)[, "treatment", drop = FALSE])
df$treatment <- ifelse(df$treatment == "SD", "SF", as.character(df$treatment))

# force column order to match hippocampus layout: C1-8 then SF1-8
desired_order <- c(paste0("C", 1:8), paste0("SF", 1:8))

ntd_ordered <- ntd[, desired_order]
df_ordered  <- df[desired_order, , drop = FALSE]

hypo_heatmap_unfiltered <- pheatmap(assay(ntd_ordered)[select, ],
  cluster_rows = FALSE, show_rownames = FALSE,
  cluster_cols = FALSE, annotation_col = df_ordered
)

ggsave("heatmap_hypo_unfiltered.png", plot = hypo_heatmap_unfiltered, device = NULL,
path = "figures/hypothalamus",
scale = 1, width = 10, height = 10, dpi = 600)

# PCA
hypo_PCA_unfiltered <- plotPCA(vsd, intgroup = c("treatment"))

pca_data <- plotPCA(vsd, intgroup = c("treatment"), returnData = TRUE)

hypo_PCA_unfiltered <- hypo_PCA_unfiltered +
  geom_text_repel(
    data = subset(pca_data, name == "SF5"),
    aes(x = PC1, y = PC2, label = name),
    color = "black",
    size = 3,
    box.padding = 0.6
  )

hypo_PCA_unfiltered

ggsave("hypo_PCA_unfiltered.png", plot = hypo_PCA_unfiltered, device = NULL,
path = "figures/hypothalamus",
scale = 1, width = 10, height = 10, dpi = 600)
