library(tidyverse)
library(grid)

go <- read.csv(
  "results/hypothalamus/tables/GO_results_table_hyp.csv"
)

terms_to_keep <- c(
  "myelin sheath",
  "modulation of chemical synaptic transmission",
  "Wnt signaling pathway",
  "synapse organization",
  "GABA-ergic synapse",
  "T cell activation",
  "circadian regulation of gene expression",
  "synaptic vesicle membrane",
  "regulation of ERK1 and ERK2 cascade"
)

go_plot <- go %>%
  filter(Description %in% terms_to_keep) %>%
  mutate(
    .sign = if_else(NES > 0, "activated", "suppressed"),
    NES_abs = abs(NES),
    Description = recode(
      Description,
      "myelin sheath" = "Myelin sheath",
      "modulation of chemical synaptic transmission" =
        "Modulation of chemical synaptic transmission",
      "Wnt signaling pathway" = "Wnt signaling pathway",
      "synapse organization" = "Synapse organization",
      "GABA-ergic synapse" = "GABAergic synapse",
      "T cell activation" = "T cell activation",
      "circadian regulation of gene expression" =
        "Circadian regulation of gene expression",
      "synaptic vesicle membrane" = "Synaptic vesicle membrane",
      "regulation of ERK1 and ERK2 cascade" =
        "Regulation of ERK1 and ERK2 cascade"
    )
  )

go_plot$Description <- factor(
  go_plot$Description,
  levels = c(
    "Circadian regulation of gene expression",
    "Wnt signaling pathway",
    "Regulation of ERK1 and ERK2 cascade",
    "T cell activation",
    "Myelin sheath",
    "Modulation of chemical synaptic transmission",
    "Synaptic vesicle membrane",
    "Synapse organization",
    "GABAergic synapse"
  )
)

print(go_plot[, c("Description", "NES", "qvalue", ".sign")])

p <- ggplot(
  go_plot,
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
    limits = c(0, max(go_plot$NES_abs) + 0.2)
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
  "figures/hypothalamus/GO_hypo_IPHYret.png",
  p,
  width = 10,
  height = 8,
  dpi = 600
)

ggsave(
  "figures/hypothalamus/GO_hypo_IPHYret.png",
  p,
  width = 10,
  height = 8,
  dpi = 600
)