#!/usr/bin/env bash

#BATCH --time=03:00:00
#SBATCH --mem-per-cpu=4G
#SBATCH --cpus-per-task=16
#SBATCH --partition=pall
#SBATCH --job-name=indexing
#SBATCH --mail-user=ananda.kurth@students.unibe.ch
#SBATCH --mail-type=begin,end

# set the directories
WORK_DIR=/data/users/akurtz/assembly_annotation_course/assemblies

# add the module
module add UHTS/Aligner/bowtie2/2.3.4.1;

# bowtie index building flye
bowtie2-build ${WORK_DIR}/flye/assembly.fasta ${WORK_DIR}/flye/flyeindex

# bowtie index building canu
bowtie2-build ${WORK_DIR}/canu/An1_3.contigs.fasta ${WORK_DIR}/canu/canuindex

