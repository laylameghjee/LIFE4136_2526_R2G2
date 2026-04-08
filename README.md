# LIFE4136 - Rotation 2 Group 2

## Repository Outline

[Project Overview](#project-overview)  
[Biological Background](#biological-background)  
[Prerequisites](#prerequisites)  
- [Data Overview](#data-overview)  
-- [Reference Files](#reference-files)  
-- [Cloning the Git repository](#cloning-the-git-repository)  
[Tools](#tools)   
- [Environment Set up](#environment-set-up)
- []
[Analysis](#analysis)  
[Troubleshooting](#troubleshooting)    
[Authors](#authors)  


## Project Overview 

This repository contains the scripts, reference files, and documentation used for the RNA-seq analysis completed for the LIFE4136 25/26 module. The repository is intended to allow another user to understand the workflow, recreate the computational environment and reproduce the analysis steps in the correct order. 

### Biological Background

**Part One: Trypanosoma brucei**

The Trypanosoma brucei (T. brucei) parasite is a single-celled protozoan parasite that causes Human African Trypanosomiasis (HAT) which is also more commonly known as sleeping sickness. The parasite itself is transmitted by the tsetse fly and cycles between stages in the human host and the fly vector. Once the human is infected, T. brucei can be first detected within the bloodstream and as infection progresses the infection spreads into other tissues and fluids within the body. The disease becomes fatal when the parasite crosses the blood-brain barrier and enters the central nervous system causing severe neurological symptoms, coma and then eventually death. 

The aim of the analysis within part one is to investigate how gene expression changes between different disease stages of the parasite, giving us an idea of the lifecycle of T. brucei. RNA-seq is used within this as the number of reads mapping to each gene gives an estimate of mRNA abundance, which allows for a comparison of expression levels between different samples. 

The samples used within this part of the study were cells in blood and cells in cerebrospinal fluid (CSF) which help us to investigate stages I and II respectively of the disease. Other studies from the cohort looked at comparing a range of other sources including cells in Adipose tissue, cells in culture and cells from rat blood. These studies will also help to provide different comparisons of expression levels to further develop the understanding of this parasite. 

**Part Two: Human Glioma Analysis**

Part two of the analysis focused on analysing human cancer samples for differential gene expression, specifically comparing glioma tissue with a glioma cell line. Gliomas are tumours that arise from glial cells within the central nervous system. By comparing these two sample types, the aim is to identify differences in gene expression that may reflect tumour biology and changes in cellular processes associated with disease progression. 


## Prerequisites 

## Data Overview 

Part One: Trypanosoma brucei  

Organism - Trypanosoma brucei  
Sample Types - blood and cerebrospinal fluid  
Number of samples - 9 
Sample IDs - Blood1 - Blood5 and CSF1 - CSF4  
Read Type - single end  
Original Input format - compressed FASTQ files  
File Size - between 2.5G and 7.4G

Part Two: Human Glioma RNA-seq data  

Organism - Homo sapiens  
Sample Types - glioma tissue and glioma cell line  
Number of samples - 10 Biological Samples producing 20 FASTQ files
Sample IDs - ERR1404775_1 & ERR1404775_2 - ERR1404780_1 & ERR1404780_2 and ERR1404793_1 & ERR1404793_2 - ERR1404796_1 & ERR1404796_2
Read Type - paired end  
Original Input format - compressed FASTQ files 
File Size - between 877M and 1.9G 

### Reference Files

All references files used within this project are stored within the ```ReferenceGenomes ``` directory. Contains T. brucei and Homo sapiens (GRCh38) reference genome and annotation files that are used for alignment and indexing. For your reference, the files provided have been downloaded [here](https://tritrypdb.org) for the T. brucei and [here](https://www.ensembl.org) for the Homo sapiens (GRCh38). 


### Cloning the Git repository

To clone this Git repo to your local computer follow these steps:  

1. Copy the URL for this git repo: https://github.com/laylameghjee/LIFE4136_2526_R2G2.git  
2. Open the terminal on your local computer
3. Navigate to the directory/location where you want to clone the repo
4. Type ```git clone``` followed by the URL and then press enter

This will clone the entire repo to your chosen directory, giving you access to all the files and scripts. If there are any issues with cloning, use the [GitHub Guide](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) to help. 

## Tools

To carry out the analysis required in this study a range of tools and programmes were used, they are listed below with the corresponding versions. To replicate this analysis the same tools will need to be used by either creating your own conda environment and installing them individually or you can use the yml file which already has the tools downloaded into the conda environment. The easiest way is to use the yml file already provided.

### Environment set up 

Creating environment from yml file  

Ensuring yml file is in your current working directory, type the following into your command line
```
conda env create -f tbrucei.yml
``` 

To check that the installation has worked use the following code
```
conda env list 
```
This should have ```tbrucei``` in the list if it has created correctly. 

If you wish to see all the packages and their versions within the environment use the following code
```
conda list -n tbrucei
```

Creating a conda environment by yourself  

To create the conda environment use:
```
conda create python=3.10 -n tbrucei 
``` 
It is vital to specify the version of python, so ensure that part is included. 

### Main command-line tools  

Once the conda environment has been created then install the following packages. Install by typing `conda install` followed by the package name and then version into the command line. An example would be 
```conda install fastqc=0.12.1```


| Tool       | Version | 	GitHub Links                                           |
| ----       | ------- | --------------------------------------------------------- |
|FastQC     |	0.12.1 | [fastqc](https://github.com/s-andrews/FastQC)             |
|Trim Galore |	0.6.11 | [trim galore](https://github.com/FelixKrueger/TrimGalore) |
|Bowtie2	 | 2.5.5   | [bowtie2](https://github.com/BenLangmead/bowtie2)         |
|HTSeq	     | 2.1.2   | [htseq](https://github.com/simon-anders/htseq)            |
|STAR	     | 2.7.11b | [star](https://github.com/alexdobin/STAR)                 |
|samtools    | 1.22.1  | [samtools](https://github.com/samtools/samtools)          |

In order to activate and deactivate the conda environment use the code below
```
conda activate tbrucei
conda deactivate 
```

### Further Analysis tools

R and RStudio  

If you don't already have either R or RStudio installed, you will need to install one of them for the additional analysis within this project. Please follow the installation instructions [here](https://rstudio-education.github.io/hopr/starting.html) ensuring you follow the correct instructions for your local machine. 

Any additional packages needed within R and RStudio are specified within the scripts and the scripts will install them for you but they are listed below. 


| Tool        | Version | 	        Links                                                          |
| ----        | ------- | -------------------------------------------------------------------------|
|DESeq2       |	1.50.1  | [DESeq2](https://bioconductor.org/packages/release/bioc/html/DESeq2.html)|
|ggplot2      |	4.0.0   | [ggplot2](https://ggplot2.tidyverse.org)                                 |
|pheatmap	  | 1.0.13  | [pheatmap](https://cran.r-project.org/web/packages/pheatmap/pheatmap.pdf)|
|readr        | 2.1.5   | [readr](https://readr.tidyverse.org)                                     |
|tidyverse	  | 2.0.0   | [tidyverse](https://tidyverse.org)                                       |
|RColorBrewer | 1.1.3   | [RColorBrewer](https://cran.r-project.org/web/packages/RColorBrewer/index.html)|


IGV  

If you don't already have IGV installed and set up, follow the instructions [here](https://igv.org) to download it so it is ready for the additional analysis. 

## Analysis

Each numbered step below corresponds to the numbered script. The scripts should be run in numerical order. Please note any sections denoted with ‘XXX’ must be replaced by your own paths or file names. Paths must be either:  
 - Relative paths if your files are arranged within the repository structure  
 - Absolute paths if your files are stored elsewhere on your systems  

These scripts were developed for use on an HPC system using SLURM. They may also be adapted for local use, although some steps may take longer and/or require more memory. 

### Part One

**1.**	Quality Control  
Using FastQC to produce quality control data that gives insight into the sequence length, data quality, reliability etc of the data you are analysing. 

Script name: 1_QC.sh  
Input(s): raw FASTQ files  
Output(s): FastQC HTML reports  

**2.**	Trim data
Trim Galore allows for the sequence reads to be trimmed before alignment

Script name: 2_Trim.sh  
Input(s): raw FASTQ files  
Output(s): trimmed FASTQ files   

**3.**	Mapping

This step is split into two parts as there needs to be some prep done before the reads can be mapped. Firstly, in step A, Bowtie2-build is used to create a bowtie index for mapping and then in step B, Bowtie2 is used to map each trimmed fastq file to the reference genome. 

Script name: 3a_BowtiePrep.sh  
Input(s): TBrucei Reference genome  
Output(s): Bowtie2 index files  

Script name: 3b_Bowtie.sh  
Input(s): FASTQ files and Bowtie2 index  
Output(s): SAM alignment files  

**4.**	Creating BAM files

Again, this step is split into two parts as well. Script 4a converts the SAM files into BAM files first and then script 4b sorts the bam files. 

Script name: 4a_SamToBam.sh  
Input(s): SAM files  
Output(s): BAM files    

Script name: 4b_SortBam.sh  
Input(s): BAM files   
Output(s): sorted BAM files and .bai index files   

**5.**	Generate read counts with HTSeq

HTSeq helps to turn the sequencing data into counts for further analysis. In this analysis there are scripts for both the BAM files and SAM files to be able to produce data for both sets. 

Script name: 5_HtseqBam.sh  
Input(s): BAM files, TBrucei GFF annotation genome  
Output(s): TSV count file  

Script name: 5_HtseqSam.sh  
Input(s): SAM files, TBrucei GFF annotation genome  
Output(s): TXT count files

### Additional Analysis and Visualisation 

**A1.** Using IGV to visualise 

Use the IGV software to look at the distribution of mapped reads for one or more of the samples. 

For A2 – A4 below, all the visualisations can be done using the AA1 script. This script should be run in R or RStudio. Any packages used within this analysis install as part of the scripts. 

**A2.** Use DESeq2 in R to visualise 

**A3.** Use R to create clustered heatmap of sample to sample 

**A4.** Use R to create PCA graph of samples

### Part Two

**6.**	STAR Indexing 

For this script, ensure that both of the Homo sapiens GRCh38 genomes have been unzipped before running the script. This can be done by the following line:  
```
unzip filename.zip
```

Script name: 6_StarIndexing.sh  
Input(s): GRCh38.fa and GRCH38.gtf reference genomes  
Output(s): STAR genome index

**7.**	Run STAR
STAR was run on both the glioma cell line (Script 7a) and the glioma tissue (Script 7b). 

Script name: 7a_StarGCellLine.sh  
Input(s): paired-end FASTQ files 
Output(s): aligned sam file, log files, readspergene.tab file, SJ.tab file  

Script name: 7b_StarGTissue.sh  
Input(s): paired compressed fastq files  
Output(s): aligned SAM file, STAR log files, readspergene.tab file, SJ.tab file  


You can then do further analysis on the human cancer samples including: DESeq2, a heatmap and a PCA graph.

## Troubleshooting 

Input files cannot be found  
- Check all paths are correct and all placeholders (XXX) have been replaced  
- Check all input files are stored in the correct locations  

Reference genomes missing  
- Confirm all required files are present in the ```ReferenceGenomes``` directory  
- For Part Two ensure you have unzipped the files before running the scripts  

Scripts not running on a local machine 
- As these scripts were written for use on an HPC system with SLURM there may be issues when running on a local machine  
- When running locally, some of the #SBATCH lines may need to be removed or changed  
- Some steps, especially indexing and alignment might require more memory and longer runtimes on a local machine  

R packages not installing  
- If the R packages are not installing correctly when running the script, try running just the installation lines alone

Script not running as expected 
- Ensure that the previous step has run correctly and the output files are what are expected
- Ensure all input paths are correct

## Authors

Caleb Thornber - mbyct9@nottingham.ac.uk  
Hannah Byrne - mbxhb5@nottingham.ac.uk  
Layla Meghjee - mbxlm9@nottingham.ac.uk  
Shahwar Nadeem - mzysn15@nottingham.ac.uk  

