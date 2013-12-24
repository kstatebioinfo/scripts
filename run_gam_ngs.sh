#!/bin/bash
export PATH=$PATH:~/samtools-0.1.19
export PATH=$PATH:~/bwa
SCRIPT_PATH=~/scripts
OUT=~/ubuntu/gam-ngs_merge
THREADS_NUM=4
BWA=bwa
GAM_CREATE=~/gam-ngs/bin/gam-create
GAM_MERGE=~/gam-ngs/bin/gam-merge


#  sudo bash scripts/run_gam_ngs.sh
#
#
#  Created by jennifer shelton on 11/13/13.

cd ~/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds
mkdir -p ~/ubuntu/gam-ngs_merge
echo -e "\n### GAM-NGS's blocks construction ###\n"
echo -e "${GAM_CREATE} --master-bam ${SCRIPT_PATH}/master_tcas_4.0_scaffolds_PE_bams.txt  --slave-bam ${SCRIPT_PATH}/slave_scaffolds_PE_bams.txt --min-block-size 10 --output ${OUT}/master.tcas4.0.slave.scaffolds > ${OUT}/gam-create.log.out 2> ${OUT}/gam-create.log.err\n"

# GAM-NGS: Blocks construction phase
${GAM_CREATE} --master-bam ${SCRIPT_PATH}/master_tcas_4.0_scaffolds_PE_bams.txt  --slave-bam ${SCRIPT_PATH}/slave_scaffolds_PE_bams.txt --min-block-size 10 --output ${OUT}/master.tcas4.0.slave.scaffolds > ${OUT}/gam-create.log.out 2> ${OUT}/gam-create.log.err
# GAM-NGS: Merge

echo -e "### GAM-NGS's merging phase ###\n"
echo -e "${GAM_MERGE} --blocks-file ${OUT}/master.tcas4.0.slave.scaffolds.blocks --master-bam ${SCRIPT_PATH}/master_tcas_4.0_scaffolds_PE_bams.txt --master-fasta /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/tcas.scaffolds.fasta --slave-bam ${SCRIPT_PATH}/slave_scaffolds_PE_bams.txt --slave-fasta /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/Kmer_merges_81-scaffolds.fa --min-block-size 10 --output ${OUT}/master.tcas4.0.slave.scaffolds_merge --threads ${THREADS_NUM} >${OUT}/gam-merge.log.out 2>${OUT}/gam-merge.log.err\n"


${GAM_MERGE} --blocks-file ${OUT}/master.tcas4.0.slave.scaffolds.blocks --master-bam ${SCRIPT_PATH}/master_tcas_4.0_scaffolds_PE_bams.txt --master-fasta /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/tcas.scaffolds.fasta --slave-bam ${SCRIPT_PATH}/slave_scaffolds_PE_bams.txt --slave-fasta /home/sheltonj/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds/Kmer_merges_81-scaffolds.fa --min-block-size 10 --output ${OUT}/master.tcas4.0.slave.scaffolds_merge --threads ${THREADS_NUM} >${OUT}/gam-merge.log.out 2>${OUT}/gam-merge.log.err

##./Alignments/tcas_4.0_scaffolds/tcas_4.0_scaff_3kb.bwa.sorted.bam
##./Alignments/Kmer_merges_81-scaffolds/Kmer_merges_81_scaff_3kb.bwa.sorted.bam


