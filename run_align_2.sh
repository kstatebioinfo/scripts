#!/bin/bash

#
#   USAGE: nohup bash run_align_2.sh &
#
#


#############################################################
######### align reads to tcas abyss assembly ################
#############################################################

bash /home/sheltonj/scripts/align_reads.sh /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/reads/Trib_cast_R1_1000_good_good.fastq /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/reads/Trib_cast_R2_1000_good_good.fastq /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/tcas.scaffolds.fasta

bash /home/sheltonj/scripts/align_reads.sh /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/reads/Trib_cast_R1_2000_good_good.fastq /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/reads/Trib_cast_R2_2000_good_good.fastq /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/tcas.scaffolds.fasta

bash /home/sheltonj/scripts/align_reads.sh /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/reads/Trib_cast_R1_3000_good_good.fastq /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/reads/Trib_cast_R2_3000_good_good.fastq /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/tcas.scaffolds.fasta

bash /home/sheltonj/scripts/align_reads.sh /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/reads/Tribolium3kb_1_prinseq_good_P7uO.fastq /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/reads/Tribolium3kb_2_prinseq_good_36G8.fastq /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/tcas.scaffolds.fasta

bash /home/sheltonj/scripts/align_reads.sh /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/reads/Trib_cast_R1_3500_good_good.fastq /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/reads/Trib_cast_R2_3500_good_good.fastq /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/tcas.scaffolds.fasta

bash /home/sheltonj/scripts/align_reads.sh /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/reads/Trib_cast_R1_36000_good_good.fastq /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/reads/Trib_cast_R2_36000_good_good.fastq /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/tcas.scaffolds.fasta

bash /home/sheltonj/scripts/align_reads.sh /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/reads/Tribolium20kb_1_prinseq_good_xq20.fastq /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/reads/Tribolium20kb_2_prinseq_good_10IC.fastq /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/tcas.scaffolds.fasta 

bash /home/sheltonj/scripts/align_reads.sh /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/reads/Tribolium8kb_1_prinseq_good_ffRe.fastq /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/reads/Tribolium8kb_2_prinseq_good_RaKN.fastq /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/tcas.scaffolds.fasta
