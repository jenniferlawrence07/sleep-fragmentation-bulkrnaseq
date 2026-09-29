
library(clusterProfiler)
library(enrichplot)
library(ggplot2)
library(org.Mm.eg.db)
library(DOSE)

organism <- "org.Mm.eg.db"

original_gene_list_hypo <- resHypo_filtered$stat
names(original_gene_list_hypo) <- rownames(resHypo_filtered)
gene_list_hypo <- na.omit(original_gene_list_hypo)
gene_list_hypo <- sort(gene_list_hypo, decreasing = TRUE)

gseHypo <- gseGO(
  geneList = gene_list_hypo,
  ont = "ALL",
  keyType = "ENSEMBL",
  minGSSize = 3,
  maxGSSize = 800,
  pvalueCutoff = 0.05,
  verbose = TRUE,
  OrgDb = organism,
  pAdjustMethod = "none"
)

#simplify redundant terms

gseHypo_simplified <- clusterProfiler::simplify(gseHypo, cutoff = 0.7, by = "p.adjust", select_fun = min)
nrow(gseHypo_simplified@result)