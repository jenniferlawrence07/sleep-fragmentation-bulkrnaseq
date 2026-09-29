library(clusterProfiler)
library(org.Mm.eg.db)
organism <- "org.Mm.eg.db"

ids_hypo <- bitr(names(gene_list_hypo), fromType = "ENSEMBL", toType = "ENTREZID", OrgDb = organism)

#merge with existing ranked set
kegg_df_hypo <- data.frame(ENSEMBL = names(gene_list_hypo), stat = gene_list_hypo)
kegg_df_hypo <- merge(kegg_df_hypo, ids_hypo, by = "ENSEMBL")
kegg_df_hypo <- kegg_df_hypo[!duplicated(kegg_df_hypo$ENTREZID), ]

#re-sort gene list 
kegg_gene_list_hypo <- kegg_df_hypo$stat
names(kegg_gene_list_hypo) <- kegg_df_hypo$ENTREZID
kegg_gene_list_hypo <- sort(kegg_gene_list_hypo, decreasing = TRUE)

#mus musculus
kegg_organism <- "mmu" 

gse_KEGG_hypo <- gseKEGG(geneList = kegg_gene_list_hypo,
                     organism = kegg_organism,
                     minGSSize= 3,
                     maxGSSize     = 800,
                     pvalueCutoff  = 0.05,
                     pAdjustMethod = "none",
                     keyType  = "ncbi-geneid")