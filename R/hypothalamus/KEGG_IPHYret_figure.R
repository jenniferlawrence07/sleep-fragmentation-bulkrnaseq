library(tidyverse)
library(grid)

kegg <- read.csv(
  "results/hypothalamus/tables/KEGG_results_table_hypo.csv"
)

terms_to_keep <- c(
  "Circadian rhythm",
  "Notch signaling pathway",
  "Hippo signaling pathway",
  "Wnt signaling pathway",
  "p53 signaling pathway",
  "Ribosome",
  "Peroxisome",
  "Inflammatory mediator regulation of TRP channels"
)

kegg_plot <- kegg %>%
  filter(Description %in% terms_to_keep) %>%
  mutate(
    .sign = if_else(NES > 0, "activated", "suppressed"),
    NES_abs = abs(NES),
    Description = recode(
      Description,
      "Circadian rhythm" = "Circadian rhythm",
      "Notch signaling pathway" = "Notch signaling pathway",
      "Hippo signaling pathway" = "Hippo signaling pathway",
      "Wnt signaling pathway" = "Wnt signaling pathway",
      "p53 signaling pathway" = "p53 signaling pathway",
      "Ribosome" = "Ribosome",
      "Peroxisome" = "Peroxisome",
      "Inflammatory mediator regulation of TRP channels" =
        "Inflammatory mediator regulation of TRP channels"
    )
  )

kegg_plot$Description <- factor( 
  kegg_plot$Description,
  levels = c(
    "Circadian rhythm",
    "Notch signaling pathway",
    "Hippo signaling pathway",
    "Wnt signaling pathway",
    "p53 signaling pathway",
    "Ribosome",
    "Peroxisome",
    "Inflammatory mediator regulation of TRP channels"
  )
)

print(kegg_plot[, c("Description", "NES", "qvalue", ".sign")])

p <- ggplot(
  kegg_plot,
  aes(
    x = NES_abs,
    y = Description,
    size = setSize,
    color = qvalue
  )
) +
  geom_point() +
  facet_grid(. ~ .sign, scales = "free_x", space = "free_x") +
  labs(
    title = "",
    x = "Normalized Enrichment Score (NES)",
    y = "",
    color = "q-value",
    size = "Count"
  ) +
  scale_x_continuous(
    breaks = seq(0, 3, by = 0.5),
    limits = c(0, max(kegg_plot$NES_abs) + 0.2)
  ) +
  theme_bw() +
  theme(
    axis.text.y = element_text(size = 12, face = "bold", color = "black"),
    axis.text.x = element_text(size = 11, face = "bold", color = "black"),
    axis.title.x = element_text(size = 13, face = "bold", color = "black"),
    strip.text = element_text(size = 15, face = "bold", color = "black"),
    strip.background = element_rect(
      color = "black",
      fill = "gray90",
      linewidth = 1.2
    ),
    panel.grid.major = element_line(color = "gray90"),
    panel.grid.minor = element_blank(),
    panel.spacing = unit(1.2, "cm")
  )

print(p)

ggsave(
  "figures/hypothalamus/KEGG_hypo_IPHYret.png",
  p,
  width = 10,
  height = 8,
  dpi = 600
)