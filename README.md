# Sleep Fragmentation Bulk RNA-seq Analysis

**Transcriptomic Analysis of Chronic Sleep Fragmentation in the Hippocampus and Hypothalamus**

This repository contains bulk RNA-seq analyses investigating the molecular effects of chronic sleep fragmentation in the hippocampus and hypothalamus of mice.

The project uses differential gene expression and gene set enrichment analysis to examine transcriptomic responses to prolonged sleep fragmentation.

## 1. Background and Research Question

Sleep fragmentation is characterized by fragmenting sleep while typically not affecting total sleep time.

Chronic sleep disruption has been linked to a variety of inflammatory consequences and pathologies, so this project investigated the molecular changes associated with chronic sleep fragmentation.

**Research question:** How does eight weeks of chronic sleep fragmentation affect gene expression and biological pathways in the hippocampus and hypothalamus?

## 2. Experimental Design

Bulk RNA sequencing was performed using hippocampal and hypothalamic tissue collected from adult male mice following eight weeks of sleep fragmentation.

| Variable | Description |
| Animal model | C57BL/6 mice |
| Sex | Male |
| Age | Approximately 3–5 months |
| Experimental groups | Sleep fragmentation (SF) and control |
| Sample size | n = 8 per group |
| Exposure duration | 8 weeks |
| Apparatus | Lafayette Instruments automated sleep-fragmentation chamber |
| Fragmentation protocol | Sweeper-bar movement every 2 minutes |
| Light cycle | 12:12-hour light–dark cycle |
| Brain regions | Hippocampus and hypothalamus |
| Sequencing approach | Bulk RNA-seq |

### Sleep Fragmentation Protocol

Chronic sleep fragmentation was induced using a Lafayette Instruments automated sleep-fragmentation chamber equipped with a mechanical sweeper bar that sweeps the floor of the cage ever 2 minutes.

Mice in the sleep-fragmentation group were exposed to sweeper-bar movement every two minutes over an eight-week period. Control mice were undisturbed during this time.

Following the experimental period, hippocampal and hypothalamic tissue was collected for region-specific transcriptomic analysis.

## 3. Computational Analysis

General workflow followed:

**FASTQ → fastp → STAR → featureCounts → Gene Count Matrix**

### Upstream RNA-seq Processing

Upstream sequencing processing was done on CU Boulder's Alpine HPC cluster and downstream transcriptomic analysis in R.

Upstream analysis included:

1. **fastp:** Paired-end read quality control and trimming.
2. **STAR:** Alignment to the mouse reference genome (mm39).
3. **featureCounts:** Gene-level read quantification.

Processing scripts are organized by brain region and use SLURM for HPC job submission.

### Downstream RNA-seq Processing

Downstream processing was done in R using the processed gene count matrices.

### Differential Gene Expression

Differential gene expression analysis was conducted using **DESeq2** to identify transcriptional differences between sleep-fragmented and control mice.

Analyses included:

- Count matrix preparation and sample quality assessment
- Principal component analysis (PCA)
- Sample clustering and heatmap visualization
- Differential gene expression analysis
- Gene identifier mapping
- Volcano plots and other gene expression visualizations

### Gene Set Enrichment Analysis

Gene Set Enrichment Analysis (GSEA) was performed to investigate coordinated changes in biological pathways that may not be apparent through individual gene-level analyses.

Functional enrichment analyses included:

- Gene Ontology (GO)
- Kyoto Encyclopedia of Genes and Genomes (KEGG)
- Ranked gene list generation (DESeq2 Wald statistic)
- Pathway enrichment analysis
- Enrichment visualizations and biological interpretation

Analyses were performed separately for the hippocampus and hypothalamus.

### Statistical Thresholds

Statistical significance was evaluated using multiple-testing-adjusted p-values.

- **Differential gene expression (DESeq2):** Adjusted p-value < 0.05.
- **Gene set enrichment analysis (GSEA):** Benjamini–Hochberg (BH)-adjusted p-value (FDR) < 0.05.

Genes were ranked for GSEA using the DESeq2 Wald statistic, allowing pathway enrichment to be evaluated across the ranked gene list rather than restricting the analysis to significantly differentially expressed genes.

## 4. Key Findings

### Hippocampal Transcriptomic Responses

Differential expression analysis of the hippocampus did not identify statistically significant differentially expressed genes following eight weeks of sleep fragmentation (adjusted p-value < 0.05).

However, Gene Set Enrichment Analysis (GSEA) revealed coordinated changes in biological pathways despite the absence of significant individual gene-level differences.

Following Benjamini–Hochberg (BH) correction, **2,131 Gene Ontology (GO) terms and 130 KEGG pathways** met the significance threshold of FDR < 0.05.

**Positively enriched pathways included:**

- GABAergic, glutamatergic, and dopaminergic synaptic signaling
- Synaptic vesicle cycling, synapse organization, and neuronal plasticity
- Circadian rhythm regulation and circadian entrainment
- MAPK, mTOR, and Wnt signaling
- T-cell receptor and integrated stress-response signaling
- Myelin sheath-associated processes
- Inflammatory mediator regulation of TRP channels

**Negatively enriched pathways included:**

- Ribosome and ribosomal subunit-associated processes
- Cytosolic and mitochondrial ribosomal components
- Cilium-dependent cell motility

### Hypothalamic Transcriptomic Responses

Differential expression analysis of the hypothalamus did not identify statistically significant differentially expressed genes following eight weeks of sleep fragmentation (adjusted p-value < 0.05).

However, Gene Set Enrichment Analysis (GSEA) revealed coordinated changes in biological pathways despite the absence of significant individual gene-level differences.

Following Benjamini–Hochberg (BH) correction, **730 Gene Ontology (GO) terms and 15 KEGG pathways** met the significance threshold of FDR < 0.05.

**Positively enriched pathways included:**

- Circadian rhythm regulation
- T-cell activation and immune-associated processes
- p53-associated cellular stress signaling
- Hippo, Notch, and Wnt signaling
- Cilia-associated processes

**Negatively enriched pathways included:**

- GABAergic and synaptic signaling
- Myelin sheath-associated processes
- Myelination
- Inflammatory mediator regulation of TRP channels

### Pathway-Level Interpretation

These findings suggest that chronic sleep fragmentation may be associated with coordinated changes in circadian regulation, cellular stress responses, immune signaling, and neuronal function.

The enrichment results highlight the value of pathway-level analyses for identifying potential molecular responses to prolonged sleep disruption, particularly when no individual genes reach statistical significance.

These findings remain exploratory and do not establish direct changes in pathway activity or causal mechanisms without additional experimental validation.

## 5. Repository Structure

```text
sleep-fragmentation-bulkrnaseq/
│
├── R/
│   ├── hippocampus/
│   └── hypothalamus/
│
├── data/
│   ├── hippocampus/
│   └── hypothalamus/
│
├── results/
│   └── Differential expression and
│       pathway enrichment results
│
├── figures/
│   └── Generated analysis figures
│
├── docs/
│   └── Supporting documentation
│
└── README.md
```

## 6. Software and Computational Tools

| Category | Tools |
|---|---|
| Programming language | R |
| Differential expression | DESeq2 |
| Functional enrichment | clusterProfiler, GSEA |
| Gene set databases | GO, KEGG |
| Data visualization | PCA, heatmaps, volcano plots, enrichment figures |
| Version control | Git, GitHub |

## 7. Reproducibility

The repository is organized to separate processed sequencing data, downstream analyses, and results.

### Data Preparation

Processed gene count matrices are organized by brain region within the `data/` directory.

### Downstream Analysis

The `R/` directory contains region-specific scripts for:

1. Data preparation and quality control
2. Exploratory analysis and PCA
3. Differential gene expression
4. Ranked gene list generation
5. GO and KEGG gene set enrichment analysis
6. Visualization of analytical results

Analysis outputs are organized in the `results/` and `figures/` directories.

Relative file paths are used where possible to support execution from the repository root.

### Current Limitations

The repository focuses on downstream analysis of processed RNA-seq data and does not currently contain a validated end-to-end FASTQ processing workflow.

Full software environment specification and automated execution remain areas for future improvement.

## 8. Ongoing Development

Planned improvements include:

- Standardizing software environments and dependencies
- Improving documentation of analysis execution order
- Developing a reusable Snakemake workflow for upstream RNA-seq processing
- Implementing additional automated testing and reproducibility checks

## 9. Research Context

This project investigates molecular responses to chronic sleep fragmentation, with a focus on identifying transcriptomic changes associated with disrupted sleep consolidation.

The analyses contribute to ongoing research examining the relationship between sleep disruption, cellular stress responses, and neurological function.

All pathway-level findings should be interpreted as exploratory until supported by additional experimental validation.
