#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=flye_merqury
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=output_flye_merqury_%j.o
#SBATCH --error=error_flye_merqury_%j.e

DATA_DIR=/data/courses/assembly-annotation-course/
WORK_DIR=/data/users/akurtz/assembly_annotation_course/assemblies
PROJECT_PATH=`realpath .`
OUTPUT_PATH=$PROJECT_PATH/merqury

FWD=`ERR3624579_1.fastq.gz`
BWD=`ERR3624579_1.fastq.gz`

mkdir -p $OUTPUT_PATH

 # find the best k-mer size to use amd save it to var
# KMER=`singularity exec \
#         /software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
#         best_k.sh \
#             135000000 \
#         | sed -n '3 p'` # get the third line of output, which is the kmer


# # build kmers with meryl
 mkdir -p $OUTPUT_PATH/meryl
 singularity exec \
     --bind $PROJECT_PATH,$DATA_DIR \
     /software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
     meryl \
         count \
         k=18 \
         $FWD \
         output $OUTPUT_PATH/meryl/FWD_kmers.meryl \

 singularity exec \
     --bind $PROJECT_PATH,$DATA_DIR \
     /software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
     meryl \
         count \
         k=18 \
         $BWD \
         output $OUTPUT_PATH/meryl/BWD_kmers.meryl \


# # merge kmers with meryl
 singularity exec \
     --bind $PROJECT_PATH,$DATA_DIR \
     /software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
     meryl \
         union-sum \
         output $OUTPUT_PATH/meryl/merged_kmers.meryl \
         $OUTPUT_PATH/meryl/FWD_kmers.meryl \
         $OUTPUT_PATH/meryl/BWD_kmers.meryl


# kmer evaluation
# raw flye asm
mkdir -p $OUTPUT_PATH/flye_p
cd $OUTPUT_PATH/flye_p

ln -s $OUTPUT_PATH/meryl/merged_kmers.meryl .
#ln -s /data/users/akurtz/assembly_annotation_course/assemblies/flye/assembly.fasta .
#ln -s $WORK_DIR/canu/An1_3.contigs.fasta .
ln -s $WORK_DIR/flye/pilon.fasta .
#ln -s $WORK_DIR/canu/pilon.fasta .

singularity exec \
    --bind $PROJECT_PATH,$DATA_DIR \
    /software/singularity/containers/Merqury-1.3-1.ubuntu20.sif \
    merqury.sh \
        merged_kmers.meryl \
        pilon.fasta \
        flye_p

