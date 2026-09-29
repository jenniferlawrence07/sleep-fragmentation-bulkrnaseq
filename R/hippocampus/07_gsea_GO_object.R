library(clusterProfiler)
library(enrichplot)
library(ggplot2)
library(org.Mm.eg.db)
library(DOSE)

organism <- "org.Mm.eg.db"

original_gene_list_hippo <- resHippo_filtered$stat
names(original_gene_list_hippo) <- rownames(resHippo_filtered)
gene_list_hippo <- na.omit(original_gene_list_hippo)
gene_list_hippo <- sort(gene_list_hippo, decreasing = TRUE)

gseHippo <- gseGO(
  geneList = gene_list_hippo,
  ont = "ALL",
  keyType = "ENSEMBL",
  minGSSize = 3,
  maxGSSize = 800,
  pvalueCutoff = 0.05,
  verbose = TRUE,
  OrgDb = organism,
  pAdjustMethod = "none"
)

# simplify redundant terms
gseHippo_simplified <- clusterProfiler::simplify(
  gseHippo,cutoff = 0.7,by = "p.adjust",select_fun = min
)
nrow(gseHippo_simplified@result)
