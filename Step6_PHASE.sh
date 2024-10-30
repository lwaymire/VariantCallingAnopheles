#!/usr/bin/bash
#PBS -l nodes=1:ppn=20

# Here we are locating the directory with data.
cd /absolute/path/to/the/working/directory

# Here we are setting the background for conda environment activation.
eval "$(conda shell.bash hook)"

# Here we are setting the background for conda environment activation. This will retrieve details of the packages installed on Miniconda.
conda activate bioinfo

# Here we are setting the for loop, for beagle to run each vcf file.
for CHR in `ls *.vcf.gz`
do

# Here we are setting out input and output prefixes.
input_vcf="$CHR"
output_prefix="${input_vcf%.vcf}"

# Count the number of samples in the VCF file
num_samples=$(awk '/^#CHROM/ {print NF-9}' "$input_vcf")
 
beagle -Xmx20g \
        gt="$input_vcf" \
        out="$output_prefix.phased" \
        nthreads=20

done
