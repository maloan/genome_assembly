#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=02:00:00
#SBATCH --job-name=kmer
#SBATCH --mail-user=ananda.kurth@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/akurtz/assembly_annotation_course/read_QC/kmer_counting/output_kmer_%j.o
#SBATCH --error=/data/users/akurtz/assembly_annotation_course/read_QC/kmer_counting/error_kmer_%j.e
##SBATCH --partition=pcourseassembly


# set the directories
READ_DIR=/data/users/akurtz/assembly_annotation_course/participant_3
OUT_DIR=/data/users/akurtz/assembly_annotation_course/read_QC/kmer_counting

# load module
module load UHTS/Analysis/jellyfish/2.3.0;

# counting kmers
jellyfish count -C -m 21 -s 8G -t 4 <(zcat ${READ_DIR}/Illumina/*.fastq.gz) -o ${OUT_DIR}/Illumina/reads.jf
jellyfish count -C -m 21 -s 8G -t 4 <(zcat ${READ_DIR}/RNAseq/*.fastq.gz) -o ${OUT_DIR}/RNAseq/reads.jf
jellyfish count -C -m 21 -s 8G -t 4 <(zcat ${READ_DIR}/pacbio/*.fastq.gz) -o ${OUT_DIR}/pacbio/reads.jf

# histogram 
jellyfish histo -t 4 ${OUT_DIR}/Illumina/reads.jf > ${OUT_DIR}/Illumina/reads.histo
jellyfish histo -t 4 ${OUT_DIR}/RNAseq/reads.jf > ${OUT_DIR}/RNAseq/reads.histo
jellyfish histo -t 4 ${OUT_DIR}/pacbio/reads.jf > ${OUT_DIR}/pacbio/reads.histo
