#!/bin/bash
#SBATCH --job-name=bowtie_prep
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --mem=16g
#SBATCH --time=12:00:00
#SBATCH --mail-user=XXXX@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end

source $HOME/.bash_profile #Allows conda use
conda activate tbrucei #Activates conda  env

mkdir bowtie
cd bowtie
mkdir blood
mkdir csf
mkdir index
#sets output directories

bowtie2-build XXX/TBruceiRef.fasta \
        ./index/tbrucei
#Runs indexing
