#!/usr/bin/env bash

#SBATCH --time=6:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=merqury_init
#SBATCH --mail-type=begin,fail,end
#SBATCH --partition=pall
#SBATCH --error=/data/users/akurtz/assembly_annotation_course/merqury/error_merq%j.e

# Define paths to directories
WORKDIR=/data/users/akurtz/assembly_annotation_course
dir_reads=/data/users/akurtz/assembly_annotation_course/participant_3/Illumina
dir_meryl=${WORKDIR}/merqury/meryl
DATADIR=/data/courses/assembly-annotation-course

# Prepare meryl dbs
singularity exec \
--bind $WORKDIR \
--bind $DATADIR \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
meryl union-sum \
 output sum.meryl \
 [count k=21 ERR3624579_1.fastq.gz output read1.meryl] \
 [count k=21 ERR3624579_2.fastq.gz output read2.meryl]
