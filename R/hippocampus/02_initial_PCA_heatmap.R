library(DESeq2)
library(vsn)
library(pheatmap)
library(ggplot2)
library(ggrepel)

#check names are changed 
colnames(ddsHippo)

# data transformations
ntd <- normTransform(ddsHippo)

vsd <- vst(ddsHippo, blind = FALSE)
rld <- rlog(ddsHippo, blind = FALSE)
head(assay(vsd), 3)


# heatmap
select <- order(rowMeans(counts(ddsHippo, normalized = TRUE)), decreasing = TRUE)[1:20]
df <- as.data.frame(colData(ddsHippo)[, "treatment", drop = FALSE])
df$treatment <- ifelse(df$treatment == "SD", "SF", as.character(df$treatment))

hippo_heatmap_unfiltered <- pheatmap(assay(ntd)[select, ],
  cluster_rows = FALSE, show_rownames = FALSE,
  cluster_cols = FALSE, annotation_col = df
)

ggsave("heatmap_hippo_unfiltered.png", plot = hippo_heatmap_unfiltered, device = NULL,
path = "figures/hippocampus",
scale = 1, width = 10, height = 10, dpi = 600)

# PCA
hippo_PCA_unfiltered <- plotPCA(vsd, intgroup = c("treatment"))

# pull coordinates separately, just for the label position
pca_data <- plotPCA(vsd, intgroup = c("treatment"), returnData = TRUE)

hippo_PCA_unfiltered <- hippo_PCA_unfiltered +
  geom_text_repel(
    data = subset(pca_data, name == "SF1"),
    aes(x = PC1, y = PC2, label = name),
    color = "black",
    size = 3,
    box.padding = 0.6
  )

hippo_PCA_unfiltered

ggsave("hippo_PCA_unfiltered.png", plot = hippo_PCA_unfiltered, device = NULL,
path = "figures/hippocampus",
scale = 1, width = 10, height = 10, dpi = 600)
