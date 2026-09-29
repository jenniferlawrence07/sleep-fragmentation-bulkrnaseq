# 8-Week Sleep Fragmentation —  Hypothalamus Bulk RNA-seq

## Project

Bulk RNA-seq analysis of hypothalamic gene expression following
8 weeks of chronic sleep fragmentation via sweeper boxes in male mice (n=8) 

## Analysis workflow

Raw sequencing reads
→ CU Alpine preprocessing
→ processed count matrix
→ R-based analysis
→ QC
→ DESeq2
→ GSEA
→ figures
→ Quarto reports

## Directory structure

- `data/` — metadata and processed count data
- `scripts/R/` — R analysis scripts
- `scripts/alpine/` — Alpine preprocessing scripts
- `results/` — analysis outputs
- `figures/` — final figures
- `quarto/` — Quarto analysis reports
- `docs/` — project documentation and analysis decisions

## Dataset

Tissue: Hypothalamus
Experiment: 8-week sleep fragmentation  
Analysis type: Bulk RNA-seq

## Status
In progress. 