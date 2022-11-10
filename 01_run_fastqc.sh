#!/usr/bin/env bash

#BATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=ananda.kurth@students.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/users/akurtz/assembly_annotation_course/read_QC/output_fastqc_%j.o
#SBATCH --error=/data/users/akurtz/assembly_annotation_course/read_QC/error_fastqc_%j.e
##SBATCH --partition=pcourseassembly

# set the directories
WORK_DIR=/data/users/akurtz/assembly_annotation_course/read_QC/fastqc
READ_DIR=/data/users/akurtz/assembly_annotation_course/participant_3

# load module
module load UHTS/Quality_control/fastqc/0.11.9;

# do fastqc 
fastqc -o ${WORK_DIR}/Illumina ${READ_DIR}/Illumina/*fastq.gz
fastqc -o ${WORK_DIR}/RNAseq ${READ_DIR}/RNAseq/*fastq.gz
fastqc -o ${WORK_DIR}/pacbio ${READ_DIR}/pacbio/*fastq.gz
