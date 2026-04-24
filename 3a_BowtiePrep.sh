#!/bin/bash
#SBATCH --job-name=bowtie_prep
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=16g
#SBATCH --time=12:00:00
#SBATCH --mail-user=XXXX@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end

source $HOME/.bash_profile #Allows conda use
conda activate tbrucei #Activates conda  env

#creating directoriess
#replace XXX with file path to home directory
PD=XXX

mkdir -p "$PD"/bowtie/blood
mkdir -p "$PD"/bowtie/csf
mkdir -p "$PD"/bowtie/index

#if reference genomes have been moved then change this file path
RD="$PD"/ReferenceGenomes

bowtie2-build "$RD"/TBruceiRef.fasta \
        "$PD"/bowtie/index/tbrucei
#Runs indexing
