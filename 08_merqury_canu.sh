#!/usr/bin/env bash

#SBATCH --time=6:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --job-name=merqury_flye
#SBATCH --mail-type=begin,fail,end
#SBATCH --partition=pall
#SBATCH --output=/data/users/akurtz/assembly_annotation_course/merqury/output_merq%j.o
#SBATCH --error=/data/users/akurtz/assembly_annotation_course/merqury/error_merq%j.e

# Define paths to directories
WORKDIR=/data/users/akurtz/assembly_annotation_course
dir_meryl=${WORKDIR}/merqury/meryl

# Go to working directory for merqury
cd ${WORKDIR}/merqury/canu

# Run the container with merqury
singularity exec \
--bind $WORKDIR \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh \
$dir_meryl/sum.meryl \
${WORKDIR}/assemblies/canu/An1_3.contigs.fasta \
canu

# Run the container with merqury
singularity exec \
--bind $WORKDIR \
/software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
merqury.sh \
$dir_meryl/sum.meryl \
${WORKDIR}/assemblies/canu/pilon.fasta \
canu_polished
