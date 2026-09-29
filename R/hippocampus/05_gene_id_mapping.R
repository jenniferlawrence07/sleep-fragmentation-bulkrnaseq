library("AnnotationDbi")
library("EnsDb.Mmusculus.v79")
edb <- EnsDb.Mmusculus.v79

# sort by padj first (smallest/most significant first)
resHippo_sorted <- resHippo_filtered[order(resHippo_filtered$padj), ]

symbol <- mapIds(x = edb, keys = rownames(resHippo_sorted), column = "SYMBOL", keytype = "GENEID")
head(symbol)

resHippo_GENE <- cbind(symbol, as.data.frame(resHippo_sorted))
resHippo_GENE$GeneID <- rownames(resHippo_sorted)

resHippo_GENE <- resHippo_GENE[!is.na(resHippo_GENE$symbol), ]
resHippo_GENE <- resHippo_GENE[!duplicated(resHippo_GENE$symbol), ]

head(resHippo_GENE, 20)

#results ordered by padj 

write.csv(resHippo_GENE, "results/hippocampus/tables/res_hippo_padj.csv" # nolint
, row.names = FALSE)

#results ordered by L2FC

resHippo_L2FC <- resHippo_GENE[order(
    resHippo_GENE$log2FoldChange),]

write.csv(resHippo_L2FC, "results/hippocampus/tables/res_hippo_L2FC.csv"
, row.names = FALSE)

#results ordered by L2FC AND padj 
resHippo_L2FC_padj <- resHippo_GENE[
    order(resHippo_GENE$padj,
          -abs(resHippo_GENE$log2FoldChange)),]

write.csv(resHippo_L2FC_padj, "results/hippocampus/tables/res_hippo_L2FC_padj.csv"
, row.names = FALSE)
