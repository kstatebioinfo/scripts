#!/bin/bash

~/gam-ngs/bin/gam-create --master-bam ~/scripts/master_tcas_4.0_contigs_PE_bams.txt --slave-bam ~/scripts/slave_scaffolds_PE_bams.txt --min-block-size 10 --output master.tcas4.0.slave.scaffolds
