library(dplyr)

#pathways

KEGG_results_table_hippo <- gse_KEGG_hippo@result %>%
arrange(p.adjust)%>%
select(ID, Description, NES, pvalue, qvalue, setSize)

write.csv(KEGG_results_table_hippo, "results/hippocampus/tables/KEGG_results_table_hippo.csv",
row.names = FALSE)

#core enrichment 

gse_KEGG_hippo_readable <- setReadable(gse_KEGG_hippo, OrgDb = org.Mm.eg.db, keyType = "ENTREZID")

KEGG_results_table_hippo_core <- gse_KEGG_hippo_readable@result %>%
  arrange(qvalue) %>%
  select(ID, Description, NES, pvalue, qvalue, setSize, core_enrichment)

write.csv(KEGG_results_table_hippo_core, "results/hippocampus/tables/KEGG_results_table_hippo_core_enrichment.csv", row.names = FALSE)