hippo_dot_plot_KEGG <- dotplot(gse_KEGG_hippo, showCategory = 8, split = ".sign", label_format = 40) +
  facet_grid(. ~ .sign) +
  labs(title = "", x = "Gene Ratio", y = "") +
  theme(
    axis.text.y = element_text(size = 12),
    axis.text.x = element_text(size = 11),
    axis.title.x = element_text(size = 13, face = "bold"),
    strip.text = element_text(size = 15, face = "bold"),
    strip.background = element_rect(color = "black", fill = "gray90", linewidth = 1.2)
  )
hippo_dot_plot_KEGG

#simplify for key terms to include

terms_to_keep_kegg_hippo <- c("Ribosome","Circadian entrainment","Wnt signaling pathway","MAPK signaling pathway","cAMP signaling pathway",
"GABAergic synapse","Dopaminergic synapse","Synaptic vesicle cycle","T cell receptor signaling pathway","Cytokine-cytokine receptor interaction",
"Inflammatory mediator regulation of TRP channels","mTOR signaling pathway","Glutamatergic synapse")

gse_KEGG_hippo_key_terms <- gse_KEGG_hippo
gse_KEGG_hippo_key_terms@result <- gse_KEGG_hippo_key_terms@result[gse_KEGG_hippo_key_terms@result$Description %in% terms_to_keep_kegg_hippo, ]

KEGG_hippo_dot_plot_key_terms <- dotplot(gse_KEGG_hippo_key_terms, showCategory = length(terms_to_keep_kegg_hippo), split = ".sign", label_format = 40) +
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
KEGG_hippo_dot_plot_key_terms

ggsave("KEGG_hippo_final.png", plot <- KEGG_hippo_dot_plot_key_terms, device = NULL, path = "figures/hippocampus",
scale = 1,
width = 10,
height = 10,
dpi = 600)