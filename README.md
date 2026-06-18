# Projeto-Bioinf

Extension of specmine and WebSpecmine for Unsupervised Analysis.

**Author:** Pedro Fontão  
**Institution:** Centre of Biological Engineering, University of Minho  
**Supervisors:** Diogo Cachetas, Marcelo Maraschin, Miguel Rocha

---

## Repository Structure

This repository contains the deliverables and source code for the project
**"Extension of specmine and WebSpecmine for Unsupervised Analysis"**.

| Branch | Contents |
|--------|----------|
| [`main`](https://github.com/PedroFontao/Projeto-Bioinf/tree/main) | Project documents and deliverables (this branch) |
| [`specmine`](https://github.com/PedroFontao/Projeto-Bioinf/tree/specmine) | Extended specmine R package and WebSpecmine Shiny app |

---

## Documents

### State of the Art
An initial survey of existing metabolomics analysis tools and unsupervised
learning methods, covering specmine, WebSpecmine, MetaboAnalyst, XCMS Online,
MZmine, PCA, ICA, UMAP, and t-SNE.

[Estado_da_arte_projeto.pdf](./Estado_da_arte_projeto.pdf)

### Project Presentation
Slide deck presenting the project objectives, implemented contributions,
and key results.

[Apresentação Projeto.pdf](./Apresentação%20Projeto.pdf)

### Final Paper
Conference paper submitted in LNCS format describing the full implementation
and validation of the new unsupervised learning capabilities in specmine
and WebSpecmine.

> Paper available upon request or after publication.

---

## Project Summary

This project extends the [specmine](https://github.com/BioSystemsUM/specmine)
R package and the WebSpecmine web application with new unsupervised learning
capabilities:

- **Dimensionality reduction**: UMAP, t-SNE, ICA (2D and 3D)
- **Clustering**: DBSCAN, HDBSCAN, Gaussian Mixture Models, Hierarchical Clustering
- **WebSpecmine modules**: Preprocessing tab, Embeddings tab, Clustering tab,
  Comparison dashboard, PCA/HCA loading analysis panel

For installation and usage instructions, see the
[`specmine` branch](https://github.com/PedroFontao/Projeto-Bioinf/tree/specmine).
