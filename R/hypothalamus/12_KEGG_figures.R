hypo_dot_plot_KEGG <- dotplot(gse_KEGG_hypo, showCategory = 8, split = ".sign", label_format = 40) +
  facet_grid(. ~ .sign) +
  labs(title = "", x = "Gene Ratio", y = "") +
  theme(
    axis.text.y = element_text(size = 12),
    axis.text.x = element_text(size = 11),
    axis.title.x = element_text(size = 13, face = "bold"),
    strip.text = element_text(size = 15, face = "bold"),
    strip.background = element_rect(color = "black", fill = "gray90", linewidth = 1.2)
  )
hypo_dot_plot_KEGG

#simplify for key terms to include

terms_to_keep_kegg_hypo <- c("Hippo signaling pathway","Inflammatory mediator regulation of TRP channels","Notch signaling pathway",
"Aminoacyl-tRNA biosynthesis","Wnt signaling pathway","p53 signaling pathway","Circadian rhythm","Ribosome")

gse_KEGG_hypo_key_terms <- gse_KEGG_hypo
gse_KEGG_hypo_key_terms@result <- gse_KEGG_hypo_key_terms@result[gse_KEGG_hypo_key_terms@result$Description %in% terms_to_keep_kegg_hypo, ]

KEGG_hypo_dot_plot_key_terms <- dotplot(gse_KEGG_hypo_key_terms, showCategory = length(terms_to_keep_kegg_hypo), split = ".sign", label_format = 40) +
  facet_grid(. ~ .sign) +
  labs(title = "", x = "Gene Ratio", y = "") +
scale_x_continuous(
  breaks = seq(0, 1, by = 0.2),
  labels = scales::label_number(accuracy = 0.1),
  limits = c(0, 1),
) +
  theme(
    axis.text.y = element_text(size = 12, face = "bold"),
    axis.text.x = element_text(size = 11, face = "bold"),
    axis.title.x = element_text(size = 13, face = "bold"),
    strip.text = element_text(size = 15, face = "bold"),
    strip.background = element_rect(color = "black", fill = "gray90", linewidth = 1.2)
  )
KEGG_hypo_dot_plot_key_terms

ggsave("KEGG_hypo_final.png", plot <- KEGG_hypo_dot_plot_key_terms, device = NULL, path = "figures/hypothalamus",
scale = 1, 
width = 10,
height = 10,
dpi = 600)