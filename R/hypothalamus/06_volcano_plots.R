library(dplyr)
library(ggplot2)
library(ggrepel)

#nothing with 0.05 or 0.1 cutoff, maintaining 0.05 for consistency with GSEA 

padj_cutoff <- 0.05
plot_title <- "Hypothalamus: Sleep Fragmentation vs Control"

plot_hypo <- as.data.frame(resHypo_GENE)
plot_hypo

plot_hypo$Significance <- "Not Significant" 
plot_hypo$Significance[
    plot_hypo$padj < padj_cutoff &
    plot_hypo$log2FoldChange > 0 &
    !is.na(plot_hypo$padj)] <- "Up-regulated"

plot_hypo$Significance[
    plot_hypo$padj < padj_cutoff &
    plot_hypo$log2FoldChange < 0 &
    !is.na(plot_hypo$padj)] <- "Down-regulated"

#top genes for labeling (N/A for dataset because no DEGS)
#top 10 upregulated 
top_up <- plot_hypo %>%
  dplyr::filter(Significance == "Up-regulated") %>%
  dplyr::arrange(padj) %>%
  dplyr::slice_head(n = 10)

#top 10 downregulated 
top_down <- plot_hypo %>%
  dplyr::filter(Significance == "Down-regulated") %>%
  dplyr::arrange(padj) %>%
  dplyr::slice_head(n = 10)


label_df <- dplyr::bind_rows(top_up, top_down)

#even axis 

x_range <- range(c(plot_hippo$log2FoldChange, plot_hypo$log2FoldChange), na.rm = TRUE)
y_range <- range(c(-log10(plot_hippo$pvalue), -log10(plot_hypo$pvalue)), na.rm = TRUE)


#plot 

p_hyp <- ggplot(
  plot_hypo,
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
      "Down-regulated" = "#3417d9"
    )
  ) +
  geom_text_repel(
    data = label_df,
    aes(label = symbol),
    size = 3,
    max.overlaps = 30,
    box.padding = 0.5,
    segment.color = "grey80",
    segment.size = 0.3,
    show.legend = FALSE
  ) +
  coord_cartesian(xlim = x_range, ylim = y_range) +
  theme_minimal() +
  labs(
    title = plot_title,
    x = "Log2 Fold Change",
    y = "-Log10(p-value)"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.position = "right"
  )

p_hyp

ggsave("hypo_volcano.png", plot <- p_hyp, device = NULL, path = "figures/hypothalamus", scale = 1, 
width = 10, height = 10, dpi = 600)
