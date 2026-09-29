library(dplyr)

#pathways 

GO_results_table_hippo <- gseHippo_simplified@result %>%
arrange(p.adjust)%>%
select(ONTOLOGY, ID, Description, NES, pvalue, qvalue, setSize)

write.csv(GO_results_table_hippo, "results/hippocampus/tables/GO_results_table_hippo.csv"
, row.names = FALSE)

#core enrichment

gseHippo_readable <- setReadable(gseHippo_simplified, OrgDb = org.Mm.eg.db, keyType = "ENSEMBL")

GO_results_table_hippo_core <- gseHippo_readable@result %>%
  arrange(qvalue) %>%
  select(ONTOLOGY, ID, Description, NES, pvalue, qvalue, setSize, core_enrichment)

write.csv(GO_results_table_hippo_core, "results/hippocampus/tables/GO_results_table_hippo_core_enrichment.csv", row.names = FALSE)