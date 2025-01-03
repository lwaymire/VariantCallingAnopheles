#!/usr/bin/bash
#PBS -l nodes=1:ppn=5

# Here we are locating the directory with data.
cd /absolute/path/to/the/working/directory

# Here we are setting the background for conda environment activation.
eval "$(conda shell.bash hook)"
conda activate bioinfo

# Here we are filtering biallelic variants as multiallelic variants can complicate downstream analysis.
bcftools view -Oz -m 2 -M 2 -q 0.01:minor nameoffile.calls.norm.flt-indels.vcf.gz -o nameoffile.calls.biallelic.vcf.gz --threads 5

# Here we are indexing the input file.
bcftools index nameoffile.calls.biallelic.vcf.gz

done
