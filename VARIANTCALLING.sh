#!/usr/bin/bash
#PBS -l nodes=1:ppn=10

# locating the directory with data
cd /absolute/path/to/the/working/directory

# setting background for conda environment activation
eval "$(conda shell.bash hook)"

# activating environment with conda
conda activate bioinfo

# call variants
bcftools mpileup -Ou -f ../../anstephUCI/ANSTEPv1.fna *.sorted.bam | bcftools call --ploidy 2 -mv -Oz -o 18and22_DD.calls.vcf.gz
bcftools index 18and22_DD.calls.vcf.gz

# normalize indels
bcftools norm -f ../../anstephUCI/ANSTEPv1.fna 18and22_DD.calls.vcf.gz -Ob --threads 35 -o 18and22_DD.calls.norm.bcf

# filter adjacent indels within 5bp
bcftools filter --IndelGap 5 -e 'QUAL<30 || DP<10' 18and22_DD.calls.norm.bcf -Ov -o 18and22_DD.calls.norm.flt-indels.vcf

# bgzipping the normalized and filtered calls
bgzip 18and22_DD.calls.norm.flt-indels.vcf

# Indexing filtered calls
bcftools index 18and22_DD.calls.norm.flt-indels.vcf.gz
