#!/usr/bin/env bash

#SBATCH --time=10:00:00
#SBATCH --mem-per-cpu=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=samtools
#SBATCH --mail-user=ananda.kurth@students.unibe.ch
#SBATCH --mail-type=begin,end,fail

# set the directories
WORK_DIR=/data/users/akurtz/assembly_annotation_course/assemblies

cd ${WORK_DIR}

# add the module
module load UHTS/Analysis/samtools/1.10;

# samtools flye 
#samtools sort -T -h ${WORK_DIR}/flye/flye.sam -o ${WORK_DIR}/flye/flye_sorted.sam

#samtools view -bS ${WORK_DIR}/flye/flye_sorted.sam > ${WORK_DIR}/flye/flye.bam

samtools index ${WORK_DIR}/flye/flye.bam 

# samtools canu 
samtools sort -T -h ${WORK_DIR}/canu/canu.sam -o ${WORK_DIR}/canu/canu_sorted.sam

samtools view -bS ${WORK_DIR}/canu/canu_sorted.sam > ${WORK_DIR}/canu/canu.bam

samtools index ${WORK_DIR}/canu/canu.bam 
