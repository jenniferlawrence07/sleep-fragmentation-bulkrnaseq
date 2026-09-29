library(clusterProfiler)
library(org.Mm.eg.db)
organism <- "org.Mm.eg.db"

ids_hippo <- bitr(names(gene_list_hippo), fromType = "ENSEMBL", toType = "ENTREZID", OrgDb = organism)

#merge with existing ranked set
kegg_df_hippo <- data.frame(ENSEMBL = names(gene_list_hippo), stat = gene_list_hippo)
kegg_df_hippo <- merge(kegg_df_hippo, ids_hippo, by = "ENSEMBL")
kegg_df_hippo<- kegg_df_hippo[!duplicated(kegg_df_hippo$ENTREZID), ]

#re-sort gene list 
kegg_gene_list_hippo <- kegg_df_hippo$stat
names(kegg_gene_list_hippo) <- kegg_df_hippo$ENTREZID
kegg_gene_list_hippo <- sort(kegg_gene_list_hippo, decreasing = TRUE)

#mus musculus
kegg_organism <- "mmu" 

gse_KEGG_hippo <- gseKEGG(geneList = kegg_gene_list_hippo,
                     organism = kegg_organism,
                     minGSSize= 3,
                     maxGSSize     = 800,
                     pvalueCutoff  = 0.05,
                     pAdjustMethod = "none",
                     keyType  = "ncbi-geneid")
