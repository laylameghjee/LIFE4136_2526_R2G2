#!/bin/bash
#SBATCH --job-name=STAR_index
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=90g
#SBATCH --time=12:00:00
#SBATCH --mail-user=XXX@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end

source $HOME/.bash_profile #Allows conda use
conda activate tbrucei #Activates rotation2 env

#replace all XXX with pathway to reference genomes file

STAR --runMode genomeGenerate \
        --genomeDir XXX/ReferenceGenomes \
        --genomeFastaFiles XXX/ReferenceGenomes/GRCh38.fa \
        --sjdbGTFfile XXX/ReferenceGenomes/GRCH38.gtf \
        --sjdbOverhang 99 \
        --runThreadN 8

#Runs STAR to index samples. Sets overhang lenght as 99 bp, and uses 8 cores

conda deactivate
