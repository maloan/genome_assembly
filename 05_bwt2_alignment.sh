#!/usr/bin/env bash

#SBATCH --time=24:00:00
#SBATCH --mem-per-cpu=4G
#SBATCH --cpus-per-task=16
#SBATCH --partition=pall
#SBATCH --job-name=bwt2
#SBATCH --mail-user=ananda.kurth@students.unibe.ch
#SBATCH --mail-type=begin,end,fail

# set the directories
WORK_DIR=/data/users/akurtz/assembly_annotation_course/assemblies
READ_DIR=/data/users/akurtz/assembly_annotation_course/participant_3/Illumina

# add the module
module add UHTS/Aligner/bowtie2/2.3.4.1;

# run bowtie alignment flye 
bowtie2 --sensitive-local -x ${WORK_DIR}/flye/flyeindex -1 ${READ_DIR}/*1.fastq.gz -2 ${READ_DIR}/*2.fastq.gz -S ${WORK_DIR}/flye/flye.sam

# run bowtie alignment canu 
bowtie2 --sensitive-local -x ${WORK_DIR}/canu/canuindex -1 ${READ_DIR}/*1.fastq.gz -2 ${READ_DIR}/*2.fastq.gz -S ${WORK_DIR}/canu/canu.sam
