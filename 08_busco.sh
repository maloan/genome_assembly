#!/usr/bin/env bash

#SBATCH --time=24:00:00
#SBATCH --mem-per-cpu=32G
#SBATCH --cpus-per-task=8
#SBATCH --partition=pall
#SBATCH --job-name=busco
#SBATCH --mail-user=ananda.kurth@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=/data/users/akurtz/assembly_annotation_course/outputs/output_busco_%j.o
#SBATCH --error=/data/users/akurtz/assembly_annotation_course/outputs/error_busco_%j.e

# set the directories
PRODJDIR=/data/users/akurtz/assembly_annotation_course/quality_control
WORK_DIR=/data/users/akurtz/assembly_annotation_course/assemblies

# load busco and specify the running params
module load UHTS/Analysis/busco/4.1.4;

# make sure we have augustus (we copy the cluster default Augustus to our own location)
if [[ ! -d "augustus_config" ]]; then
    echo "Copying augustus_config to parent directory";
    cp -r /software/SequenceAnalysis/GenePrediction/augustus/3.3.3.1/config augustus_config
fi
export AUGUSTUS_CONFIG_PATH=./augustus_config

# flye 
busco -i ${WORK_DIR}/flye/assembly.fasta -l brassicales_odb10 -m genome --out ${PROJDIR}/ -o busco_flye
busco -i ${WORK_DIR}/flye/pilon.fasta -l brassicales_odb10 -m genome --out ${PROJDIR}/ -o busco_flye_P

# canu 
busco -i ${WORK_DIR}/canu/An1_3.contigs.fasta -l brassicales_odb10 -m genome --out ${PROJDIR}/ -o busco_canu
busco -i ${WORK_DIR}/canu/pilon.fasta -l brassicales_odb10 -m genome --out ${PROJDIR}/ -o busco_canu_P

# trinity 
busco -i ${WORK_DIR}/trinity/Trinity.fasta -l brassicales_odb10 -m transcriptome --out ${PROJDIR}/ -o busco_trinity
