
library(dplyr)
library(ggplot2)
library(ggrepel)

#nothing with 0.05 or 0.1 cutoff, maintaining 0.05 for consistency with GSEA 

padj_cutoff <- 0.05
plot_title <- "Hippocampus: Sleep Fragmentation vs Control"

plot_hippo <- as.data.frame(resHippo_GENE)
plot_hippo

plot_hippo$Significance <- "Not Significant" 
plot_hippo$Significance[
    plot_hippo$padj < padj_cutoff &
    plot_hippo$log2FoldChange > 0 &
    !is.na(plot_hippo$padj)] <- "Up-regulated"

plot_hippo$Significance[
    plot_hippo$padj < padj_cutoff &
    plot_hippo$log2FoldChange < 0 &
    !is.na(plot_hippo$padj)] <- "Down-regulated"

#top genes for labeling (N/A for dataset because no DEGS)
#top 10 upregulated 
top_up <- plot_hippo %>%
  dplyr::filter(Significance == "Up-regulated") %>%
  dplyr::arrange(padj) %>%
  dplyr::slice_head(n = 10)

#top 10 downregulated 
top_down <- plot_hippo %>%
  dplyr::filter(Significance == "Down-regulated") %>%
  dplyr::arrange(padj) %>%
  dplyr::slice_head(n = 10)


label_df <- dplyr::bind_rows(top_up, top_down)


#even axis 

x_range <- range(c(plot_hippo$log2FoldChange, plot_hippo$log2FoldChange), na.rm = TRUE)
y_range <- range(c(-log10(plot_hippo$pvalue), -log10(plot_hippo$pvalue)), na.rm = TRUE)

#plot 

p_hip <- ggplot(
  plot_hippo,
  aes(
    x = log2FoldChange,
    y = -log10(pvalue),
    color = Significance
  )
) +
  geom_point(
    alpha = 0.8,
    size = 1.5
  ) +
  scale_color_manual(
    name = paste0("Significance (padj < ", padj_cutoff, ")"),
    values = c(
      "Not Significant" = "grey80",
      "Up-regulated" = "firebrick1",
      "Down-regulated" = "royalblue1"
    ),
    guide = guide_legend(
      override.aes = list(
        size = 3,
        alpha = 1
      )
    )
  ) +
  geom_text_repel(
    data = label_df,
    aes(label = symbol),
    size = 3,
    max.overlaps = 30,
    box.padding = 0.5,
    segment.color = "grey",
    segment.size = 0.3,
    fontface = "plain",
    show.legend = FALSE
  ) +
  theme_minimal() +
  coord_cartesian(xlim = x_range, ylim = y_range) +
  labs(
    title = plot_title,
    x = "Log2 Fold Change",
    y = "-Log10(p-value)"
  ) +
  theme(
    plot.title = element_text(
      hjust = 0.5,
      face = "plain"),
      legend.position = "right",
      legend.title = element_text(
      size = 8,
      face = "plain"),
    legend.text = element_text(
      size = 7),
    legend.key.size = unit(
      0.4,
      "cm")
  )

p_hip

ggsave("hippo_volcano.png", plot <- p_hip, device = NULL, path = "figures/hippocampus", scale = 1, 
width = 10, height = 10, dpi = 600)

