library("AnnotationDbi")
library("EnsDb.Mmusculus.v79")
edb <- EnsDb.Mmusculus.v79

# sort by padj first (smallest/most significant first)
resHypo_sorted <- resHypo_filtered[order(resHypo_filtered$padj), ]

symbol <- mapIds(x = edb, keys = rownames(resHypo_sorted), column = "SYMBOL", keytype = "GENEID")
head(symbol)

resHypo_GENE <- cbind(symbol, as.data.frame(resHypo_sorted))
resHypo_GENE$GeneID <- rownames(resHypo_sorted)

resHypo_GENE <- resHypo_GENE[!is.na(resHypo_GENE$symbol), ]
resHypo_GENE <- resHypo_GENE[!duplicated(resHypo_GENE$symbol), ]

head(resHypo_GENE, 20)

#results ordered by padj 

write.csv(resHypo_GENE, "results/hypothalamus/tables/res_hypo_padj.csv" # nolint
, row.names = FALSE)

#results ordered by L2FC 
resHypo_L2FC <- resHippo_GENE[
    order(resHippo_GENE$log2FoldChange),]

write.csv(resHypo_L2FC, "results/hypothalamus/tables/res_hypo_L2FC.csv"
, row.names = FALSE)

#results ordered by L2FC AND padj 
resHypo_L2FC_padj <- resHypo_GENE[
    order(resHypo_GENE$padj,
          -abs(resHypo_GENE$log2FoldChange)),]

write.csv(resHypo_L2FC_padj, "results/hypothalamus/tables/res_hypo_L2FC_padj.csv"
, row.names = FALSE)