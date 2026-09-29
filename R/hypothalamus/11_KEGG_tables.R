library(dplyr)

KEGG_results_table_hypo <- gse_KEGG_hypo@result %>%
arrange(p.adjust)%>%
select(ID, Description, NES, pvalue, qvalue, setSize)

write.csv(KEGG_results_table_hypo, "results/hypothalamus/tables/KEGG_results_table_hypo.csv",
row.names = FALSE)

#core enrichment 

gse_KEGG_hypo_readable <- setReadable(gse_KEGG_hypo, OrgDb = org.Mm.eg.db, keyType = "ENTREZID")

KEGG_results_table_hyp_core <- gse_KEGG_hypo_readable@result %>%
  arrange(qvalue) %>%
  select(ID, Description, NES, pvalue, qvalue, setSize, core_enrichment)

write.csv(KEGG_results_table_hyp_core, "results/hypothalamus/tables/KEGG_results_table_hyp_core_enrichment.csv", row.names = FALSE)