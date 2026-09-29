hippo_dot_plot_GO <- dotplot(gseHippo, showCategory = 8, split = ".sign", label_format = 40) +
  facet_grid(. ~ .sign) +
  labs(title = "", x = "Gene Ratio", y = "") +
  theme(
    axis.text.y = element_text(size = 12),
    axis.text.x = element_text(size = 11),
    axis.title.x = element_text(size = 13, face = "bold"),
    strip.text = element_text(size = 15, face = "bold"),
    strip.background = element_rect(color = "black", fill = "gray90", linewidth = 1.2)
  )
hippo_dot_plot_GO

#simplify for key terms to include

terms_to_keep_hippo <- c("cytosolic large ribosomal subunit","GABA-ergic synapse","synaptic vesicle membrane","positive regulation of synaptic transmission","circadian rhythm","translation at postsynapse",
"regulation of cellular response to stress","myelin sheath","synaptic vesicle recycling","mRNA destabilization","neurotransmitter secretion")

gseHippo_key_terms <- gseHippo_simplified
gseHippo_key_terms@result <- gseHippo_key_terms@result[gseHippo_key_terms@result$Description %in% terms_to_keep_hippo, ]

#capitalization fix for final figures 

gseHippo_key_terms@result$Description <- c("Cytosolic large ribosomal subunit","GABAergic synapse","Synaptic vesicle membrane","Positive regulation of synaptic transmission","Circadian rhythm","Translation at postsynapse",
"Regulation of cellular response to stress","Myelin sheath","Synaptic vesicle recycling","mRNA destabilization","Neurotransmitter secretion")


GO_hippo_dot_plot_key_terms <- dotplot(gseHippo_key_terms, showCategory = length(terms_to_keep_hippo), split = ".sign", label_format = 40) +
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
GO_hippo_dot_plot_key_terms

ggsave("GO_hippo_final.png", plot <- GO_hippo_dot_plot_key_terms, device = NULL, path = "figures/hippocampus",
scale = 1,
width = 10,
height = 10,
dpi = 600)