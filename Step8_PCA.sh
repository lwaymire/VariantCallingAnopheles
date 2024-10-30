#!/usr/bin/bash
#PBS -l nodes=1:ppn=5

# Here we are locating the directory with data.
cd /absolute/path/to/the/working/directory

# Here we are setting the background for conda environment activation. This will retrieve details of the packages installed on Miniconda.
eval "$(conda shell.bash hook)"
conda activate bioinfo

# Here we are setting the for loop for the PCA calculation.
for CHR in `ls *phased.vcf`
do

# Here we are doing the PCA calculation.
plink --vcf ${CHR} --double-id --allow-extra-chr --set-missing-var-ids @:#\$1,\$2 \
--extract ${CHR}_prune.prune.in \
--make-bed --pca --out ${CHR}

done
