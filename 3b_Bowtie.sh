#!/bin/bash
#SBATCH --job-name=bowtie
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16g
#SBATCH --time=12:00:00
#SBATCH --mail-user=XXXX@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end
#SBATCH --array=1-5

source $HOME/.bash_profile #Allows conda use
conda activate tbrucei #Activates conda env

#settind directories
#replace XXX with file path to home directory
PD=XXX

cd "$PD"/bowtie #Enters bowtie

SAMPLE="Blood"$SLURM_ARRAY_TASK_ID"_trimmed.fq.gz" #Sets sample name
SAM="Blood"$SLURM_ARRAY_TASK_ID".sam.gz" #Sets SAM file name
LOG="Blood"$SLURM_ARRAY_TASK_ID".log" #Sets log file name

cd "$PD"/blood #Moves to blood
bowtie2 -x "$PD"/bowtie//index/tbrucei \
        -U "$PD"/bowtie/trimmed/blood/$SAMPLE \
        -p 8 \
        -S ""$PD"/bowtie/blood/SAM \
        2> "$PD"/bowtie/blood/LOG
#Indexes blood samples. Sets names to $SAMPLE above. Uses 8 threads, and outputs as a gzipped SAM. Creates a log file

SAMPLE="CSF"$SLURM_ARRAY_TASK_ID"_trimmed.fq.gz" #Sets sample name
SAM="CSF"$SLURM_ARRAY_TASK_ID".sam.gz" #Sets SAM file name
LOG="CSF"$SLURM_ARRAY_TASK_ID".log" #Sets log file name

cd "$PD"/csf
bowtie2 -x "$PD"/bowtie//index/tbrucei \
        -U "$PD"/bowtie/trimmed/csf/$SAMPLE \
        -p 8 \
        -S ""$PD"/bowtie/csf/SAM \
        2> "$PD"/bowtie/csf/LOG

#Indexes csf samples. Sets names to $SAMPLE above. Uses 8 threads, and outputs as a gzipped SAM. Creates a log file


