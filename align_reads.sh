#!/bin/bash
export PATH=$PATH:~/samtools-0.1.19
export PATH=$PATH:~/bwa
read_1=$1
read_2=$2
reference=$3
##################################################################################
#   
#	USAGE: bash align_reads.sh [read 1] [read 2] [reference]
#
# bash /home/sheltonj/scripts/align_reads.sh /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/reads/Tribolium3kb_1_prinseq_good_P7uO.fastq /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/reads/Tribolium3kb_2_prinseq_good_36G8.fastq /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/tcas.scaffolds.fasta
#  Created by jennifer shelton
#
##################################################################################
##################################################################################
##############       retrive reads: from the VM on NGS1         ##################
##################################################################################

# sudo mount -t vboxsf ubuntu /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/reads #from the VM

##################################################################################
##############            retrive reads: from NGS1              ##################
##################################################################################

# cd /home/sheltonj/ubuntu # from NGS1
# scp bioinfo@beocat.cis.ksu.edu:/homes/bioinfo/Tcas/Tribolium3kb_*_prinseq_good_*.fastq ./
# scp bioinfo@beocat.cis.ksu.edu:/homes/bioinfo/Tcas/sanger_reads/Trib_cast_R*_*_good_good.fastq ./
# scp bioinfo@beocat.cis.ksu.edu:/homes/bioinfo/Tcas/Tribolium20kb_*_prinseq_good_*.fastq ./  
# scp bioinfo@beocat.cis.ksu.edu:/homes/bioinfo/Tcas/Tribolium8kb_*_prinseq_good_*.fastq ./
##################################################################################
##############             get path to reads                    ##################
##################################################################################

filename_1="${1##*/}"                      # Strip longest match of */ from start
dir_1="${1:0:${#1} - ${#filename}}" # Substring from 0 thru pos of filename
base_1="${filename%.[^.]*}"                       # Strip shortest match of . plus at least one non-dot char from end
ext_1="${filename:${#base} + 1}"                  # Substring from len of base thru end
if [[ -z "$base" && -n "$ext" ]]; then          # If we have an extension and no base, it's really the base
base_1=".$ext"
ext_1=""
fi
echo "${filename}";
echo "${dir}";

filename_2="${2##*/}"                      # Strip longest match of */ from start
dir_2="${2:0:${#2} - ${#filename_2}}" # Substring from 0 thru pos of filename
base_2="${filename_2%.[^.]*}"                       # Strip shortest match of . plus at least one non-dot char from end
ext_1="${filename_2:${#base_2} + 1}"                  # Substring from len of base thru end
if [[ -z "$base_2" && -n "$ext_2" ]]; then          # If we have an extension and no base, it's really the base
base_1=".$ext_2"
ext_1=""
fi
echo "${filename}";
echo "${dir}";

##################################################################################
##############            get path to reference                 ##################
##################################################################################

ref_filename="${3##*/}"                      # Strip longest match of */ from start
ref_dir="${3:0:${#3} - ${#ref_filename}}" # Substring from 0 thru pos of filename
ref_base="${ref_filename%.[^.]*}"                       # Strip shortest match of . plus at least one non-dot char from end
ref_ext="${ref_filename:${#ref_base} + 1}"                  # Substring from len of base thru end
if [[ -z "$ref_base" && -n "$ref_ext" ]]; then          # If we have an extension and no base, it's really the base
ref_base=".$ref_ext"
ref_ext=""
fi
##################################################################################
##############             create output directory              ##################
##################################################################################
if [ ! -d "${dir}Alignments/${ref_base}" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  mkdir -p "${dir}Alignments/${ref_base}"
fi


#####################################################
################# align reads to ref ################
#####################################################
cd ${dir}

~/bwa/bwa index ${reference}
~/bwa/bwa aln -o 0 -t 4 ${reference} ${filename_1} > "${dir}Alignments/${ref_base}/${base_1}.sai" 

~/bwa/bwa aln -o 0 -t 4 ${reference} ${filename_2} > "${dir}Alignments/${ref_base}/${base_2}.sai"

~/bwa/bwa sampe ${reference} "${dir}Alignments/${ref_base}/${base_1}.sai" "${dir}Alignments/${ref_base}/${base_2}.sai" ${read_1} ${read_2} | samtools view -Shu -@ 4 - | samtools sort -@ 4 - "${dir}Alignments/${ref_base}/${base_1}.bwa.sorted"
~/samtools-0.1.19/samtools index "${dir}Alignments/${ref_base}/${base_1}.bwa.sorted"




# #!/bin/bash
# export PATH=$PATH:~/samtools-0.1.19
# export PATH=$PATH:~/bwa

# #  align_reads.sh
# #  
# #
# #  Created by jennifer shelton on 11/12/13.
# #

# #####################################################
# ################# retrive reads #####################
# #####################################################

# # scp bioinfo@beocat.cis.ksu.edu:/homes/bioinfo/Tcas/Tribolium3kb_1_prinseq_good_P7uO.fastq ./

# # scp bioinfo@beocat.cis.ksu.edu:/homes/bioinfo/Tcas/Tribolium3kb_2_prinseq_good_36G8.fastq ./

# #####################################################
# ################# align reads to ref ################
# #####################################################

# cd ~/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds
# mkdir -p ./Alignments2/tcas_4.0_scaffolds

# ~/bwa/bwa index tcas.scaffolds.fasta
# ~/bwa/bwa aln -o 0 -t 4 ./tcas.scaffolds.fasta ./Tribolium3kb_1_prinseq_good_P7uO.fastq > ./Alignments2/tcas_4.0_scaffolds/Tribolium3kb_1_prinseq_good_P7uO.sai

# ~/bwa/bwa aln -o 0 -t 4 ./tcas.scaffolds.fasta ./Tribolium3kb_2_prinseq_good_36G8.fastq > ./Alignments2/tcas_4.0_scaffolds/Tribolium3kb_2_prinseq_good_36G8.sai

# ~/bwa/bwa sampe ./tcas.scaffolds.fasta ./Alignments2/tcas_4.0_scaffolds/Tribolium3kb_1_prinseq_good_P7uO.sai ./Alignments2/tcas_4.0_scaffolds/Tribolium3kb_2_prinseq_good_36G8.sai ./Tribolium3kb_1_prinseq_good_P7uO.fastq ./Tribolium3kb_2_prinseq_good_36G8.fastq | samtools view -Shu -@ 4 - | samtools sort -@ 4 - ./Alignments2/tcas_4.0_scaffolds/tcas_4.0_scaff_3kb.bwa.sorted

# ~/samtools-0.1.19/samtools index ./Alignments2/tcas_4.0_scaffolds/tcas_4.0_scaff_3kb.bwa.sorted.bam

# # #####################################################
# # ################# align reads to slave ##############
# # #####################################################
# # mkdir -p ./Alignments2/Kmer_merges_81-scaffolds
# # 
# # ~/bwa/bwa index Kmer_merges_81-scaffolds.fa
# # ~/bwa/bwa aln -o 0 -t 4 ./Kmer_merges_81-scaffolds.fa ./Tribolium3kb_1_prinseq_good_P7uO.fastq > ./Alignments2/Kmer_merges_81-scaffolds/Tribolium3kb_1_prinseq_good_P7uO.sai
# # 
# # ~/bwa/bwa aln -o 0 -t 4 ./Kmer_merges_81-scaffolds.fa ./Tribolium3kb_2_prinseq_good_36G8.fastq > ./Alignments2/Kmer_merges_81-scaffolds/Tribolium3kb_2_prinseq_good_36G8.sai
# # 
# # ~/bwa/bwa sampe ./Kmer_merges_81-scaffolds.fa ./Alignments2/Kmer_merges_81-scaffolds/Tribolium3kb_1_prinseq_good_P7uO.sai ./Alignments2/Kmer_merges_81-scaffolds/Tribolium3kb_2_prinseq_good_36G8.sai ./Tribolium3kb_1_prinseq_good_P7uO.fastq ./Tribolium3kb_2_prinseq_good_36G8.fastq | samtools view -Shu -@ 4 - | samtools sort -@ 4 - ./Alignments2/Kmer_merges_81-scaffolds/Kmer_merges_81_scaff_3kb.bwa.sorted
# # 
# # ~/samtools-0.1.19/samtools index ./Alignments2/Kmer_merges_81-scaffolds/Kmer_merges_81_scaff_3kb.bwa.sorted.bam
# #####################################################
# ################# gapped align reads to ref ################
# #####################################################

# cd ~/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds
# mkdir -p ./Alignments_gap/tcas_4.0_scaffolds

# ~/bwa/bwa index tcas.scaffolds.fasta
# ~/bwa/bwa aln -o 3 -t 4 ./tcas.scaffolds.fasta ./Tribolium3kb_1_prinseq_good_P7uO.fastq > ./Alignments_gap/tcas_4.0_scaffolds/Tribolium3kb_1_prinseq_good_P7uO.sai

# ~/bwa/bwa aln -o 3 -t 4 ./tcas.scaffolds.fasta ./Tribolium3kb_2_prinseq_good_36G8.fastq > ./Alignments_gap/tcas_4.0_scaffolds/Tribolium3kb_2_prinseq_good_36G8.sai

# ~/bwa/bwa sampe ./tcas.scaffolds.fasta ./Alignments_gap/tcas_4.0_scaffolds/Tribolium3kb_1_prinseq_good_P7uO.sai ./Alignments_gap/tcas_4.0_scaffolds/Tribolium3kb_2_prinseq_good_36G8.sai ./Tribolium3kb_1_prinseq_good_P7uO.fastq ./Tribolium3kb_2_prinseq_good_36G8.fastq | samtools view -Shu -@ 4 - | samtools sort -@ 4 - ./Alignments_gap/tcas_4.0_scaffolds/tcas_4.0_scaff_3kb.bwa.sorted

# ~/samtools-0.1.19/samtools index ./Alignments_gap/tcas_4.0_scaffolds/tcas_4.0_scaff_3kb.bwa.sorted.bam

# #####################################################
# ################# gapped lign reads to slave ##############
# #####################################################
# mkdir -p ./Alignments_gap/Kmer_merges_81-scaffolds

# ~/bwa/bwa index Kmer_merges_81-scaffolds.fa
# ~/bwa/bwa aln -o 3 -t 4 ./Kmer_merges_81-scaffolds.fa ./Tribolium3kb_1_prinseq_good_P7uO.fastq > ./Alignments_gap/Kmer_merges_81-scaffolds/Tribolium3kb_1_prinseq_good_P7uO.sai

# ~/bwa/bwa aln -o 3 -t 4 ./Kmer_merges_81-scaffolds.fa ./Tribolium3kb_2_prinseq_good_36G8.fastq > ./Alignments_gap/Kmer_merges_81-scaffolds/Tribolium3kb_2_prinseq_good_36G8.sai

# ~/bwa/bwa sampe ./Kmer_merges_81-scaffolds.fa ./Alignments_gap/Kmer_merges_81-scaffolds/Tribolium3kb_1_prinseq_good_P7uO.sai ./Alignments_gap/Kmer_merges_81-scaffolds/Tribolium3kb_2_prinseq_good_36G8.sai ./Tribolium3kb_1_prinseq_good_P7uO.fastq ./Tribolium3kb_2_prinseq_good_36G8.fastq | samtools view -Shu -@ 4 - | samtools sort -@ 4 - ./Alignments_gap/Kmer_merges_81-scaffolds/Kmer_merges_81_scaff_3kb.bwa.sorted

# ~/samtools-0.1.19/samtools index ./Alignments_gap/Kmer_merges_81-scaffolds/Kmer_merges_81_scaff_3kb.bwa.sorted.bam
