#Install packages 
#If you already have these packages, then can comment out certain lines
install.packages("ggplot2")
install.packages("pheatmap")
install.packages("readr")
install.packages("tidyverse")
install.packages("RColorBrewer")
if (!require("BiocManager",  quiet= TRUE))
  install.packages("BiocManager")
BiocManager::install("DESeq2")

#library all packages into current workspace
library(DESeq2)
library(ggplot2)
library(pheatmap)
library(readr)
library(tidyverse)
library(RColorBrewer)

#replace with path to working directory
setwd("XXX")

#replace XXX with file path to htseq count output
directory <- "XXX/counts/"

#lists all files within the directory and removes .tsv at the end 
sampleFiles <- list.files(directory)
sampleNames <- sub(".tsv", "", sampleFiles)
sampleCondition <- ifelse(grepl("Blood",sampleFiles), "Blood", 
                          ifelse(grepl("CSF",sampleFiles), "CSF", NA))
                          
#building the metadata table for key info for DESeq2
sampleTable <- data.frame(sampleName = sampleNames,
                          fileName = sampleFiles,
                          condition = sampleCondition)
sampleTable$condition <- factor(sampleTable$condition)

#making logs to be able to make a log v log plot
#tidying up table to ensure we only have necessary cols
make_loglog <- function(file1, file2, directory){
  fileA <- paste(directory, file1, sep = "")
  fileB <- paste(directory, file2, sep = "")
  df1 <- read_tsv(fileA)
  df2 <- read_tsv(fileB)
  colnames(df1) <- c('1', '2')
  colnames(df2) <- c('3', '4')
  mdf <- cbind(df1, df2)
  mdf <- mdf %>% select(-"3")
  colnames(mdf) <- c('gene', 'sample1', 'sample2')
  mdf$sample1 <- mdf$sample1 + 0.001
  mdf$sample2 <- mdf$sample2 + 0.001
  
 #creates scatter plot 
  xy <- ggplot(data = mdf, aes(x = log(sample1), y = log(sample2))) + 
    geom_point()
  return(xy)
}

#this compares two specific samples, can be changed out depending on what 
#is wanting to be compared
SampleComparison <- make_loglog("Blood1.tsv", "CSF3.tsv", directory)
return(SampleComparison)

#creates DESeq2 dataset 
dds <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable,
                              directory = directory,
                              design= ~ condition)

#variance stabilisation and sample distance heatmap 
vsd <- varianceStabilizingTransformation(dds, blind=FALSE)
sampleDists <- dist(t(assay(vsd)))

sampleDistMatrix <- as.matrix(sampleDists)
rownames(sampleDistMatrix) <- paste(vsd@colData@rownames, vsd$type)
colnames(sampleDistMatrix) <- paste(vsd@colData@rownames, vsd$type)
colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)

#plots heatmap
heatmapplot <- pheatmap(sampleDistMatrix,
         clustering_distance_rows=sampleDists,
         clustering_distance_cols=sampleDists)
return(heatmapplot)

#running the main DESeq2 analysis step
dds <- DESeq(dds)
#provides results 
res <- results(dds)

#plots PCA using transformed data
pcaplot <- plotPCA(vsd, intgroup=c("condition"))
return(pcaplot)