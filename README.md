# Sleep Fragmentation Bulk RNA-seq

Bulk RNA-seq analysis for the chronic sleep fragmentation project.

## Brain regions
- Hippocampus
- Hypothalamus

## Main analyses
- DESeq2
- PCA / heatmaps
- Outlier handling
- Gene ID mapping
- Volcano plots
- GO GSEA
- KEGG GSEA

## Project structure
- `R/` analysis scripts
- `data/` processed count matrices
- `results/` exported analysis tables
- `figures/` generated figures
- `docs/` supporting notes and previous regional README files

Relative file paths are used so the same code can run from different computers when the repository root is the working directory.
