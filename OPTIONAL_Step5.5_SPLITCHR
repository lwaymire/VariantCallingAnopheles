#!/usr/bin/bash
#PBS -l nodes=1:ppn=5
#This script is run when I wanted to view variant data by chromosome, rather than at the whole genome level.

# Here we are locating the directory with data.
cd /absolute/path/to/the/working/directory

# Here we are setting the background for conda environment activation. This will retrieve details of the packages installed on Miniconda.
eval "$(conda shell.bash hook)"
conda activate bioinfo

# Here we are filtering biallelic variants as multiallelic variants can complicate downstream analysis.
bcftools view -Oz -m 2 -M 2 -q 0.01:minor nameoffile.calls.norm.flt-indels.vcf.gz -o nameoffile.calls.biallelic.vcf.gz --threads 5

# Here we are indexing the input file.
bcftools index nameoffile.calls.biallelic.vcf.gz

# Here we are splitting our vcf file by chromosome ID in our reference file. You will need to create a .txt file in the directory where your data is, with a list of the chromosome IDs.
for C in `cat chrlist.txt`
do 
bcftools view --regions "${C}" -Oz -o ${C}.vcf.gz nameoffile.calls.biallelic.vcf.gz --threads 5
done
