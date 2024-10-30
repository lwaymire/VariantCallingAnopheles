#!/usr/bin/bash
#PBS -l nodes=1:ppn=10

# Here we are locating the directory with data.
cd /absolute/path/to/the/working/directory

# Here we are setting the background for conda environment activation. This will retrieve details of the packages installed on Miniconda.
eval "$(conda shell.bash hook)"
conda activate bioinfo

# Here we are calling the variants using bcftools. Ploidy is set to 2 because An. stephensi is a diploid organism.
bcftools mpileup -Ou -f /path/to/reference/ANSTEPv1.fna *.sorted.bam | bcftools call --ploidy 2 -mv -Oz -o <nameoffile>.calls.vcf.gz
bcftools index <nameoffile>.calls.vcf.gz

# Here we are normalizing indels.
bcftools norm -f /path/to/reference/ANSTEPv1.fna <nameoffile>.calls.vcf.gz -Ob --threads 35 -o <nameoffile>.calls.norm.bcf

# Here we are filtering adjacent indels within 5bp.
bcftools filter --IndelGap 5 -e 'QUAL<30 || DP<10' <nameoffile>.calls.norm.bcf -Ov -o <nameoffile>.calls.norm.flt-indels.vcf

# Here we are using bgzip to zip the normalized and filtered calls.
bgzip <nameoffile>.calls.norm.flt-indels.vcf

# Here we are indexing the filtered calls.
bcftools index <nameoffile>.calls.norm.flt-indels.vcf.gz
