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
mkdir -p ./Alignments2/tcas_4.0_scaffolds

~/bwa/bwa index tcas.scaffolds.fasta
~/bwa/bwa aln -o 0 -t 4 ./tcas.scaffolds.fasta ./Tribolium3kb_1_prinseq_good_P7uO.fastq > ./Alignments2/tcas_4.0_scaffolds/Tribolium3kb_1_prinseq_good_P7uO.sai

~/bwa/bwa aln -o 0 -t 4 ./tcas.scaffolds.fasta ./Tribolium3kb_2_prinseq_good_36G8.fastq > ./Alignments2/tcas_4.0_scaffolds/Tribolium3kb_2_prinseq_good_36G8.sai

~/bwa/bwa sampe ./tcas.scaffolds.fasta ./Alignments2/tcas_4.0_scaffolds/Tribolium3kb_1_prinseq_good_P7uO.sai ./Alignments2/tcas_4.0_scaffolds/Tribolium3kb_2_prinseq_good_36G8.sai ./Tribolium3kb_1_prinseq_good_P7uO.fastq ./Tribolium3kb_2_prinseq_good_36G8.fastq | samtools view -Shu -@ 4 - | samtools sort -@ 4 - ./Alignments2/tcas_4.0_scaffolds/tcas_4.0_scaff_3kb.bwa.sorted

~/samtools-0.1.19/samtools index ./Alignments2/tcas_4.0_scaffolds/tcas_4.0_scaff_3kb.bwa.sorted.bam

# #####################################################
# ################# align reads to slave ##############
# #####################################################
# mkdir -p ./Alignments2/Kmer_merges_81-scaffolds
# 
# ~/bwa/bwa index Kmer_merges_81-scaffolds.fa
# ~/bwa/bwa aln -o 0 -t 4 ./Kmer_merges_81-scaffolds.fa ./Tribolium3kb_1_prinseq_good_P7uO.fastq > ./Alignments2/Kmer_merges_81-scaffolds/Tribolium3kb_1_prinseq_good_P7uO.sai
# 
# ~/bwa/bwa aln -o 0 -t 4 ./Kmer_merges_81-scaffolds.fa ./Tribolium3kb_2_prinseq_good_36G8.fastq > ./Alignments2/Kmer_merges_81-scaffolds/Tribolium3kb_2_prinseq_good_36G8.sai
# 
# ~/bwa/bwa sampe ./Kmer_merges_81-scaffolds.fa ./Alignments2/Kmer_merges_81-scaffolds/Tribolium3kb_1_prinseq_good_P7uO.sai ./Alignments2/Kmer_merges_81-scaffolds/Tribolium3kb_2_prinseq_good_36G8.sai ./Tribolium3kb_1_prinseq_good_P7uO.fastq ./Tribolium3kb_2_prinseq_good_36G8.fastq | samtools view -Shu -@ 4 - | samtools sort -@ 4 - ./Alignments2/Kmer_merges_81-scaffolds/Kmer_merges_81_scaff_3kb.bwa.sorted
# 
# ~/samtools-0.1.19/samtools index ./Alignments2/Kmer_merges_81-scaffolds/Kmer_merges_81_scaff_3kb.bwa.sorted.bam
#####################################################
################# gapped align reads to ref ################
#####################################################

cd ~/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds
mkdir -p ./Alignments_gap/tcas_4.0_scaffolds

~/bwa/bwa index tcas.scaffolds.fasta
~/bwa/bwa aln -o 3 -t 4 ./tcas.scaffolds.fasta ./Tribolium3kb_1_prinseq_good_P7uO.fastq > ./Alignments_gap/tcas_4.0_scaffolds/Tribolium3kb_1_prinseq_good_P7uO.sai

~/bwa/bwa aln -o 3 -t 4 ./tcas.scaffolds.fasta ./Tribolium3kb_2_prinseq_good_36G8.fastq > ./Alignments_gap/tcas_4.0_scaffolds/Tribolium3kb_2_prinseq_good_36G8.sai

~/bwa/bwa sampe ./tcas.scaffolds.fasta ./Alignments_gap/tcas_4.0_scaffolds/Tribolium3kb_1_prinseq_good_P7uO.sai ./Alignments_gap/tcas_4.0_scaffolds/Tribolium3kb_2_prinseq_good_36G8.sai ./Tribolium3kb_1_prinseq_good_P7uO.fastq ./Tribolium3kb_2_prinseq_good_36G8.fastq | samtools view -Shu -@ 4 - | samtools sort -@ 4 - ./Alignments_gap/tcas_4.0_scaffolds/tcas_4.0_scaff_3kb.bwa.sorted

~/samtools-0.1.19/samtools index ./Alignments_gap/tcas_4.0_scaffolds/tcas_4.0_scaff_3kb.bwa.sorted.bam

#####################################################
################# gapped lign reads to slave ##############
#####################################################
mkdir -p ./Alignments_gap/Kmer_merges_81-scaffolds

~/bwa/bwa index Kmer_merges_81-scaffolds.fa
~/bwa/bwa aln -o 3 -t 4 ./Kmer_merges_81-scaffolds.fa ./Tribolium3kb_1_prinseq_good_P7uO.fastq > ./Alignments_gap/Kmer_merges_81-scaffolds/Tribolium3kb_1_prinseq_good_P7uO.sai

~/bwa/bwa aln -o 3 -t 4 ./Kmer_merges_81-scaffolds.fa ./Tribolium3kb_2_prinseq_good_36G8.fastq > ./Alignments_gap/Kmer_merges_81-scaffolds/Tribolium3kb_2_prinseq_good_36G8.sai

~/bwa/bwa sampe ./Kmer_merges_81-scaffolds.fa ./Alignments_gap/Kmer_merges_81-scaffolds/Tribolium3kb_1_prinseq_good_P7uO.sai ./Alignments_gap/Kmer_merges_81-scaffolds/Tribolium3kb_2_prinseq_good_36G8.sai ./Tribolium3kb_1_prinseq_good_P7uO.fastq ./Tribolium3kb_2_prinseq_good_36G8.fastq | samtools view -Shu -@ 4 - | samtools sort -@ 4 - ./Alignments_gap/Kmer_merges_81-scaffolds/Kmer_merges_81_scaff_3kb.bwa.sorted

~/samtools-0.1.19/samtools index ./Alignments_gap/Kmer_merges_81-scaffolds/Kmer_merges_81_scaff_3kb.bwa.sorted.bam
