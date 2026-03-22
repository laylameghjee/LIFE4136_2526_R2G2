# LIFE4136 - ROTATION 2 GROUP 2

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
