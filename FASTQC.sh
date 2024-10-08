#!/usr/bin/bash
#PBS -l nodes=1:ppn=5
 
# locating the directory with data
cd /data/
 
# setting background for conda environment activation
eval "$(conda shell.bash hook)"
 
# activating 'bioinfo' environment with conda
conda activate bioinfo

#unzip files
gunzip *.gz

# quality check
fastqc -t 5 *.fq
 
echo "worked!"
