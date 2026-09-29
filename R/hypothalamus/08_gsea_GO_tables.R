library(dplyr)

#pathway results 

GO_results_table_hyp <- gseHypo_simplified@result %>%
arrange(p.adjust)%>%
select(ONTOLOGY, ID, Description, NES, pvalue, qvalue, setSize)

write.csv(GO_results_table_hyp, "results/hypothalamus/tables/GO_results_table_hyp.csv"
, row.names = FALSE)


#core enrichment 

gseHypo_readable <- setReadable(gseHypo_simplified, OrgDb = org.Mm.eg.db, keyType = "ENSEMBL")

GO_results_table_hyp_core <- gseHypo_readable@result %>%
  arrange(qvalue) %>%
  select(ONTOLOGY, ID, Description, NES, pvalue, qvalue, setSize, core_enrichment)

write.csv(GO_results_table_hyp_core, "results/hypothalamus/tables/GO_results_table_hyp_core_enrichment.csv", row.names = FALSE)


