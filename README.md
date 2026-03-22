# LIFE4136 - Rotation 2 Group 2

# Introduction

## PART ONE

The Trypanosoma brucei (T. brucei) parasite is a single-celled protozoan parasite that causes Human African Trypanosomiasis (HAT) which is also more commonly known as sleeping sickness. The parasite itself is transmitted by the tsetse fly and cycles between stages in the human host and the fly vector. Once the human is infected, T. brucei can be first detected within the bloodstream and as infection progresses the infection spreads into other tissues and fluids within the body. The disease becomes fatal when the parasite crosses the blood-brain barrier and enters the central nervous system causing severe neurological symptoms, coma and then eventually death. 

The aim of the analysis within this project is to investigate how gene expression changes between different disease stages of the parasite, giving us an idea of the lifecycle of T. brucei. RNA-seq is used within this as the number of reads mapping to each gene gives an estimate of mRNA abundance, which allows for a comparison of expression levels between different samples. 

The samples used within this part of the study were cells in blood and cells in central spinal fluid (CSF) which help us to investigate stages I and II respectively of the disease. Other studies from the cohort looked at comparing a range of other sources including cells in Adipose tissue, cells in culture and cells from rat blood. These studies will also help to provide different comparisons of expression levels to further develop the understanding of this parasite. 

## PART TWO

The second part of the analysis focused on analysing human cancer samples for differential gene expression, specifically comparing glioma tissue with a glioma cell line. Gliomas are tumours that arise from glial cells within the central nervous system. By comparing these two sample types, the aim is to identify differences in gene expression that may reflect tumour biology and changes in cellular processes associated with disease progression. 


# Prerequisites 

## Tools

To carry out the analysis required in this study a range of tools and programmes were used, they are listed below with the corresponding versions. To replicate these analyses the same tools will need to be used by either creating your own conda environment and installing them individually or you can use the yml file which already has the tools downloaded into the conda environment. The easiest way is to use the yml file already provided.

### Creating environment from yml file

Ensuring yml file is in your current working directory, type the following into your command line
```
conda env create -f tbrucei.yml
``` 

To check that the installation has worked use the following code
```
conda env list 
```
This should have tbrucei in the list if it has created correctly. 

If you wish to see all the packages and their versions within the environment use the following code
```
conda list -n tbrucei
```

### Creating a conda environment by yourself 

To create the conda environment use:
```
conda create python=3.10 -n tbrucei 
``` 
It is vital to specifiy the version of python, so ensure that part is included. Once the conda environment has been created then install the following packages. Install by typing `conda install` followed by the package name and then version into the command line. An example would be 
```conda install fastqc=0.12.1```


| Tool       | Version | 	GitHub Links                                           |
| ----       | ------- | --------------------------------------------------------- |
|fastqc      |	0.12.1 | [fastqc](https://github.com/s-andrews/FastQC)             |
|trim-galore |	0.6.11 | [trim galore](https://github.com/FelixKrueger/TrimGalore) |
|bowtie2	 | 2.5.5   | [bowtie2](https://github.com/BenLangmead/bowtie2)         |
|htseq	     | 2.1.2   | [htseq](https://github.com/simon-anders/htseq)            |
|star	     | 2.7.11b | [star](https://github.com/alexdobin/STAR)                 |


In order to activate and deactivate the conda environment use the code below
```
conda activate tbrucei
conda deactivate 
```

# Analysis

Each numbered step below corresponds to the numbered script. The scripts should be run in order. Please note any sections denoted with ‘XXX’ must be replaced by your own paths or file names. During our analysis, a HPC was used however the scripts can be run on a local computer, they just may take longer. Under each step the input and output files are listed. 

### Part One

**1.**	QC data 
Using fastqc to produce quality control data that gives you insight to the sequence length, data quality, reliability etc of the data you are analysing. 

Script name: 1_QC.sh
Input(s): fastq files
Output(s): html files

**2.**	Trim data
Trim-galore allows for the datasets to be appropriately trimmed for mapping 

Script name: 2_Trim.sh
Input(s): fastq files
Output(s): compressed fastq files (fq.gz)

**3.**	Mapping

This step is split into two parts as there needs to be some prep done before the reads can be mapped. Firstly, in step A, bowtie2-build is used to create a bowtie index for mapping and then in step B, bowtie2 is used to map each trimmed fastq file to the reference genome. 

Script name: 3a_BowtiePrep.sh
Input(s): TBrucei Reference genome
Output(s): Indexed Genome

Script name: 3b_Bowtie.sh
Input(s): compressed fastq files and indexed genome
Output(s): compressed sam file 

**4.**	Creating BAM files

Again, this step is split into two parts as well. Script 4a converts the SAM files into BAM files first and then script 4b sorts the bam files. 

Script name: 4a_SamToBam.sh  
Input(s): compressed sam files
Output(s): bam file, compressed sorted bam file

Script name: 4b_SortBam.sh 
Input(s): compressed sorted bam
Output(s): aligned bam file, sorted .bam.bai file

**5.**	Htseq

Htseq helps to turn the sequencing data into counts for further analysis. In this analysis there are scripts for both the BAM files and SAM files to be able to produce data for both sets. 

Script name: 5_HtseqBam.sh 
Input(s): .bam files, TBrucei .gff reference genome
Output(s): tsv file

Script name: 5_HtseqSam.sh
Input(s): compressed sam files, TBrucei .gff reference genome
Output(s): txt file

### Additional Analysis and Visualisation 

**A1.** Using IGV to visualise 

Following the instructions [here](https://igv.org) download IGV and use the software to look at the distribution of mapped reads for one or more of the samples. 

For A2 – A4 below, all the visualisations can be done using the AA1 script. This script should be run in R. 

**A2.** Use DESeq2 in R to visualise 

**A3.** Use R to create clustered heatmap of sample to sample 

**A4.** Use R to create PCA graph of samples

Script name:
Input(s):
Output(s): 


### Part Two

**6.**	STAR Indexing 

For this script, ensure that both of the Homo sapien GRCh38 genomes have been unzipped before running the script. This can be done by the following line:  

unzip filename.zip

Script name:
Input(s):
Output(s): 

For your reference, the files provided within the Reference Genomes directory have been downloaded from: www.ensembl.org 

**7.**	Run STAR
STAR was run on both the glioma cell line (Script 7a) and the glioma tissue (Script 7b). 

Script name:
Input(s):
Output(s): 

Script name:
Input(s):
Output(s): 

You can then do further analysis on the human cancer samples including: DESeq2, a heatmap and a PCA graph.

