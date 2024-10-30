#!/usr/bin/bash
#PBS -l nodes=1:ppn=5

# locating the directory with data
cd /data/waymirel/ASTMH_Analysis_Oct_2024/bychromosomebams/beagle

# Here we are setting the background for conda environment activation. This will retrieve details of the packages installed on Miniconda.
eval "$(conda shell.bash hook)"
conda activate bioinfo

# Here we are unzipping the files.
gunzip *.vcf.gz

# Here we are setting our for loop for our phased files.
for CHR in `ls *phased.vcf`
do

# Here we are performing the linkage pruning - i.e. identify prune sites.
plink --vcf $CHR --double-id --allow-extra-chr \
--set-missing-var-ids @:#\$1,\$2 \
--indep-pairphase 20 10 0.1 --out ${CHR}_prune --make-bed

done
