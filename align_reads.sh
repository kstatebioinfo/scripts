#!/bin/bash
export PATH=$PATH:~/samtools-0.1.19
export PATH=$PATH:~/bwa

#  align_reads.sh
#  
#
#  Created by jennifer shelton on 11/12/13.
#

#####################################################
################# retrive reads #####################
#####################################################

# scp bioinfo@beocat.cis.ksu.edu:/homes/bioinfo/Tcas/Tribolium3kb_1_prinseq_good_P7uO.fastq ./

# scp bioinfo@beocat.cis.ksu.edu:/homes/bioinfo/Tcas/Tribolium3kb_2_prinseq_good_36G8.fastq ./

#####################################################
################# align reads to ref ################
#####################################################

cd ~/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds
mkdir -p ./Alignments/tcas_4.0_scaffolds

~/bwa/bwa index tcas.scaffolds.fasta
~/bwa/bwa aln -o 0 -t 4 ./tcas.scaffolds.fastat ./Tribolium3kb_1_prinseq_good_P7uO.fastq > ./Alignments/tcas_4.0_scaffolds/Tribolium3kb_1_prinseq_good_P7uO.sai

~/bwa/bwa aln -o 0 -t 4 ./tcas.scaffolds.fasta ./Tribolium3kb_2_prinseq_good_36G8.fastq > ./Alignments/tcas_4.0_scaffolds/Tribolium3kb_2_prinseq_good_36G8.sai

~/bwa/bwa sampe ./tcas.scaffolds.fasta ./Alignments/tcas_4.0_scaffolds/Tribolium3kb_1_prinseq_good_P7uO.sai ./Alignments/tcas_4.0_scaffolds/Tribolium3kb_2_prinseq_good_36G8.sai ./Tribolium3kb_1_prinseq_good_P7uO.fastq ./Tribolium3kb_2_prinseq_good_36G8.fastq | samtools view -Shu -@ 4 - | samtools sort -@ 4 - ./Alignments/tcas_4.0_scaffolds/tcas_4.0_scaff_3kb.bwa.sorted

~/samtools-0.1.19/samtools index ./Alignments/tcas_4.0_scaffolds/tcas_4.0_scaff_3kb.bwa.sorted.bam

#####################################################
################# align reads to slave ##############
#####################################################
mkdir -p ./Alignments/Kmer_merges_81-scaffolds

~/bwa/bwa index Kmer_merges_81-scaffolds.fa
~/bwa/bwa aln -o 0 -t 4 ./Kmer_merges_81-scaffolds.fa ./Tribolium3kb_1_prinseq_good_P7uO.fastq > ./Alignments/Kmer_merges_81-scaffolds/Tribolium3kb_1_prinseq_good_P7uO.sai

~/bwa/bwa aln -o 0 -t 4 ./Kmer_merges_81-scaffolds.fa ./Tribolium3kb_2_prinseq_good_36G8.fastq > ./Alignments/Kmer_merges_81-scaffolds/Tribolium3kb_2_prinseq_good_36G8.sai

~/bwa/bwa sampe ./Kmer_merges_81-scaffolds.fa ./Alignments/Kmer_merges_81-scaffolds/Tribolium3kb_1_prinseq_good_P7uO.sai ./Alignments/Kmer_merges_81-scaffolds/Tribolium3kb_2_prinseq_good_36G8.sai ./Tribolium3kb_1_prinseq_good_P7uO.fastq ./Tribolium3kb_2_prinseq_good_36G8.fastq | samtools view -Shu -@ 4 - | samtools sort -@ 4 - ./Alignments/Kmer_merges_81-scaffolds/Kmer_merges_81_scaff_3kb.bwa.sorted

~/samtools-0.1.19/samtools index ./Alignments/Kmer_merges_81-scaffolds/Kmer_merges_81_scaff_3kb.bwa.sorted.bam
