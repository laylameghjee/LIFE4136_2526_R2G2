#Install packages 
#If you already have these packages, then can comment out certain lines
install.packages("DESeq2")
install.packages("ggplot2")
install.packages("pheatmap")
install.packages("readr")
install.packages("tidyverse")
install.packages("RColorBrewer")
install.packages("dplyr")
install.packages("rtracklayer")
install.packages("ggrepel")

#library all packages into current workspace
library(DESeq2)
library(ggplot2)
library(pheatmap)
library("RColorBrewer")
library(readr)
library(dplyr)
library(rtracklayer)
if (!require("BiocManager",  quiet= TRUE))
  install.packages("BiocManager")
BiocManager::install("apeglm")
library(apeglm)
library(ggrepel)

#importing data from the counts files
#replace with path to working directory
setwd("XXX")

#Convert tab file to tsv
Tissue1<-read.delim("XXX/cancer_counts/STAR_tissue/ERR1404775_tsReadsPerGene.out.tab", header = TRUE, sep = "\t",
                    quote = "")
Tissue2<-read.delim("XXX/cancer_counts/STAR_tissue/ERR1404776_tsReadsPerGene.out.tab", header = TRUE, sep = "\t",
                    quote = "")
Tissue3<-read.delim("XXX/cancer_counts/STAR_tissue/ERR1404777_tsReadsPerGene.out.tab", header = TRUE, sep = "\t",
                    quote = "")
Tissue4<-read.delim("XXX/cancer_counts/STAR_tissue/ERR1404778_tsReadsPerGene.out.tab", header = TRUE, sep = "\t",
                    quote = "")
Tissue5<-read.delim("XXX/cancer_counts/STAR_tissue/ERR1404779_tsReadsPerGene.out.tab", header = TRUE, sep = "\t",
                    quote = "")
Tissue6<-read.delim("XXX/cancer_counts/STAR_tissue/ERR1404780_tsReadsPerGene.out.tab", header = TRUE, sep = "\t",
                    quote = "")
Cell1<-read.delim("XXX/cancer_counts/STAR_cell_line/ERR1404793_clReadsPerGene.out.tab", header = TRUE, sep = "\t",
                  quote = "")
Cell2<-read.delim("XXX/cancer_counts/STAR_cell_line/ERR1404794_clReadsPerGene.out.tab", header = TRUE, sep = "\t",
                  quote = "")
Cell3<-read.delim("XXX/cancer_counts/STAR_cell_line/ERR1404795_clReadsPerGene.out.tab", header = TRUE, sep = "\t",
                  quote = "")
Cell4<-read.delim("XXX/cancer_counts/STAR_cell_line/ERR1404796_clReadsPerGene.out.tab", header = TRUE, sep = "\t",
                  quote = "")

#Load gene annotations
anno <- read.table('XXX/cancer_counts/ref_ann/Homo_sapiens.GRCh38.115.gtf', header = FALSE, sep = '\t')

#Remove columns 3&4
Tissue1 <- select(Tissue1,-c(3,4))
Tissue2 <- select(Tissue2,-c(3,4))
Tissue3 <- select(Tissue3,-c(3,4))
Tissue4 <- select(Tissue4,-c(3,4))
Tissue5 <- select(Tissue5,-c(3,4))
Tissue6 <- select(Tissue6,-c(3,4))
Cell1 <- select(Cell1,-c(3,4))
Cell2 <- select(Cell2,-c(3,4))
Cell3 <- select(Cell3,-c(3,4))
Cell4 <- select(Cell4,-c(3,4))

#Add column names to sample dataframes
colnames(Tissue1) <- c("GeneID", "Tissue1")
colnames(Tissue2) <- c("GeneID", "Tissue2")
colnames(Tissue3) <- c("GeneID", "Tissue3")
colnames(Tissue4) <- c("GeneID", "Tissue4")
colnames(Tissue5) <- c("GeneID", "Tissue5")
colnames(Tissue6) <- c("GeneID", "Tissue6")
colnames(Cell1) <- c("GeneID", "Cell1")
colnames(Cell2) <- c("GeneID", "Cell2")
colnames(Cell3) <- c("GeneID", "Cell3")
colnames(Cell4) <- c("GeneID", "Cell4")


#Remove rows 1-3 (N counts)
Tissue1 <- Tissue1[-c(1:3), ]
Tissue2 <- Tissue2[-c(1:3), ]
Tissue3 <- Tissue3[-c(1:3), ]
Tissue4 <- Tissue4[-c(1:3), ]
Tissue5 <- Tissue5[-c(1:3), ]
Tissue6 <- Tissue6[-c(1:3), ]
Cell1 <- Cell1[-c(1:3), ]
Cell2 <- Cell2[-c(1:3), ]
Cell3 <- Cell3[-c(1:3), ]
Cell4 <- Cell4[-c(1:3), ]


#Concatenate samples into one df
samples <- list(Tissue1, Tissue2, Tissue3, Tissue4, Tissue5, Tissue6, Cell1, Cell2, Cell3, Cell4)
counts <- Reduce(function(x,y) merge(x, y, all=TRUE), samples)
#Remove any/all NA
counts[is.na(counts)] <- 0

#Which sample is which conditions for DESeq2, -1 to exclude GeneID, i dont want to remove it 
coldata <- data.frame(
  condition = factor(c(rep("Tissue", 6), rep("Cell", 4))),
  row.names = colnames(counts[, -1])
)

#build DESEQ2 Dataset
dds <- DESeqDataSetFromMatrix(countData = counts[, -1],
                              colData = coldata,
                              design = ~ condition)
dds

# Pre-filter low-count genes
smallestGroupSize <- 4
keep <- rowSums(counts(dds) >= 10) >= smallestGroupSize
dds <- dds[keep,]

# Run DESeq2
dds <- DESeq(dds)
res <- results(dds, contrast = c("condition", "Tissue", "Cell"))
res

#Significant Adjusted p-val
sum(res$padj < 0.05, na.rm = TRUE)

#vst function does not work here-use fully
vsd <- varianceStabilizingTransformation(dds, blind=FALSE)

# heatmap
sampleDists <- dist(t(assay(vsd)))

sampleDistMatrix <- as.matrix(sampleDists)
rownames(sampleDistMatrix) <- colnames(vsd)
colnames(sampleDistMatrix) <- NULL
colors <- colorRampPalette( rev(brewer.pal(9, "Purples")) )(255)
pheatmap(sampleDistMatrix,
         clustering_distance_rows=sampleDists,
         clustering_distance_cols=sampleDists,
         cluster_cols = FALSE,
         col=colors,
         #long stick on side numbers
         legend_breaks = c(0, 100, 200, 300),
         main="Heatmap of the sample-to-sample distances")


#PCA
#Error-the argument 'intgroup' should specify columns of colData(dds)
colData(dds)
pcaData <- plotPCA(vsd, intgroup=c("condition", "sizeFactor"), returnData=TRUE)
percentVar <- round(100 * attr(pcaData, "percentVar"))
ggplot(pcaData, aes(PC1, PC2, color=condition, label=name)) +
  geom_point(size=2) +
  geom_text_repel(size = 2,  
                  max.overlaps = Inf,
                  box.padding = 1) +
  scale_color_manual(values = c("#B39DDB", "#7B1FA2")) +
  xlab(paste0("PC1: ",percentVar[1],"% variance")) +
  ylab(paste0("PC2: ",percentVar[2],"% variance")) + 
  coord_fixed() +
  ggtitle("PCA Plot")

# MA plot
# shrunken log2 fold changes, which remove the noise associated with log2 fold changes from low count genes
resultsNames(dds)
resLFC <- lfcShrink(dds, coef="condition_Tissue_vs_Cell", type="apeglm")
resLFC
plotMA(resLFC, 
       ylim=c(-12,12),
       main = "Cell vs Tissue MA plot",
       alpha = 0.05)

#Inetractive!!!!
idx <- identify(res$baseMean, res$log2FoldChange)
rownames(res)[idx]

