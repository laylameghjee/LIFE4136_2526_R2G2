#!/bin/bash
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=5g
#SBATCH --time=1:00:00
#SBATCH --job-name=htseq
#SBATCH --mail-type=ALL
#SBATCH --array=1-5
#SBATCH --mail-user=XXX@nottingham.ac.uk

source $HOME/.bash_profile
conda activate tbrucei

#SAM file names for array
BLOOD="Blood"$SLURM_ARRAY_TASK_ID".sam.gz"
CSF="CSF"$SLURM_ARRAY_TASK_ID".sam.gz"

#settind directories
#replace XXX with file path to home directory
PD=XXX

#Input file paths for sorted BAM files and gene annotation
BLOOD_PATH="$PD"/bowtie/blood/$BLOOD
CSF_PATH=$PD"/bowtie/csf/$CSF

#if reference genomes have been moved then change this file path
GENE="$PD"/ReferenceGenomes/TBruceiRef.gff

#Output path and file names
mkdir -p "$PD"/counts
            
OUTDIR="$PD"/counts

BLOOD_OUT="Blood"$SLURM_ARRAY_TASK_ID"SAM.txt"
CSF_OUT="CSF"$SLURM_ARRAY_TASK_ID"SAM.txt"


htseq-count --format sam -i ID "$BLOOD_PATH" "$GENE" > "$OUTDIR"/"$BLOOD_OUT"

htseq-count --format sam -i "$CSF_PATH" "$GENE" > "$OUTDIR"/"$CSF_OUT"

conda deactivate
