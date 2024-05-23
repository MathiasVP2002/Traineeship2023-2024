#!/bin/bash
# Change directory
cd /home/genomics/mvanpoucke/03_data_analysis/
	
# Build bowtie2 index
bowtie2-build --threads 25 01_assembly/01_metaSPAdes/04_result/metaSPAdes.sample4855.contigs.fa\
 02_binning/01_metabat/03_data_analysis/03_metaSPAdes_sample4855/metaSPAdes.sample4855.contigs

# Align reads using bowtie2 and pipe the output to samtools view
Bowtie2 -x 02_binning/01_metabat/03_data_analysis/03_metaSPAdes_sample4855/metaSPAdes.sample4855.contigs\
 -1 /home/genomics/mvanpoucke/02_data/022_009_230328_999_4855_318_01_4041_1.fq.bz2\
 -2 /home/genomics/mvanpoucke/02_data/022_009_230328_999_4855_318_01_4041_2.fq.bz2 -p 25\
 | samtools view -bS -o 02_binning/01_metabat/03_data_analysis/03_metaSPAdes_sample4855/metaSPAdes_sample4855_unsorted.bam
	
# Sort bam file
samtools sort 02_binning/01_metabat/03_data_analysis/03_metaSPAdes_sample4855/metaSPAdes_sample4855_unsorted.bam\
 -o 02_binning/01_metabat/03_data_analysis/03_metaSPAdes_sample4855/metaSPAdes_sample4855.bam
	
# Index sorted bam file
samtools index --threads 5 02_binning/01_metabat/03_data_analysis/03_metaSPAdes_sample4855/metaSPAdes_sample4855.bam
	
# Run MetaBat
runMetaBat.sh -t 30 --noAdd 01_assembly/01_metaSPAdes/04_result/metaSPAdes.sample4855.contigs.fa\
 02_binning/01_metabat/03_data_analysis/03_metaSPAdes_sample4855/metaSPAdes_sample4855.bam