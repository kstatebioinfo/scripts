#!/bin/bash
export PATH=$PATH:~/samtools-0.1.19
export PATH=$PATH:~/bwa
SCRIPT_PATH=gam-ngs_merge4
THREADS_NUM=4
BWA=bwa
GAM_CREATE=~/gam-ngs/bin/gam-create
GAM_MERGE=~/gam-ngs/bin/gam-merge


#  run_gam_ngs.sh
#
#
#  Created by jennifer shelton on 11/13/13.

cd ~/tca_ref_chrLG_all_to_Kmer_merges_81-scaffolds
mkdir -p ./gam-ngs_merge4
echo -e "\n### GAM-NGS's blocks construction\n"
echo -e "gam-create --master-bam ${SCRIPT_PATH}/gam-ngs_merge4/Allpaths-LG.PE.list.txt --slave-bam ${SCRIPT_PATH}/gam-ngs_merge4/MSR-CA.PE.list.txt --min-block-size 10 --output ${SCRIPT_PATH}/gam-ngs_merge4/out >${SCRIPT_PATH}/gam-create.log.out 2>${SCRIPT_PATH}/gam-create.log.err\n"

# GAM-NGS: Blocks construction phase
~/gam-ngs/bin/gam-create --master-bam ~/scripts/master_tcas_4.0_contigs_PE_bams.txt --slave-bam ~/scripts/slave_scaffolds_PE_bams.txt --min-block-size 10 --output ./gam-ngs_merge4/master.tcas4.0.slave.scaffolds > ${SCRIPT_PATH}/gam-create.log.out 2> ${SCRIPT_PATH}/gam-create.log.err
# GAM-NGS: Merge

echo -e "### GAM-NGS's merging phase\n"
echo -e "gam-merge --blocks-file ${SCRIPT_PATH}/gam-ngs_merge4/out.blocks --master-bam ${SCRIPT_PATH}/gam-ngs_merge4/Allpaths-LG.PE.list.txt --master-fasta ${SCRIPT_PATH}/Assembly/Allpaths-LG/genome.ctg.fasta --slave-bam ${SCRIPT_PATH}/gam-ngs_merge4/MSR-CA.PE.list.txt --slave-fasta ${SCRIPT_PATH}/Assembly/MSR-CA/genome.ctg.fasta --min-block-size 10 --output ${SCRIPT_PATH}/gam-ngs_merge4/out --threads ${THREADS_NUM} >${SCRIPT_PATH}/gam-merge.log.out 2>${SCRIPT_PATH}/gam-merge.log.err\n"


${GAM_MERGE} --blocks-file ${SCRIPT_PATH}/master.tcas4.0.slave.scaffolds.blocks --master-bam ~/scripts/master_tcas_4.0_contigs_PE_bams.txt --master-fasta tcas.scaffolds.fasta --slave-bam ~/scripts/slave_scaffolds_PE_bams.txt --slave-fasta Kmer_merges_81-scaffolds.fa --min-block-size 10 --output ${SCRIPT_PATH}/master.tcas4.0.slave.scaffolds_merge --threads ${THREADS_NUM} >${SCRIPT_PATH}/gam-merge.log.out 2>${SCRIPT_PATH}/gam-merge.log.err

##./Alignments/tcas_4.0_scaffolds/tcas_4.0_scaff_3kb.bwa.sorted.bam
##./Alignments/Kmer_merges_81-scaffolds/Kmer_merges_81_scaff_3kb.bwa.sorted.bam


