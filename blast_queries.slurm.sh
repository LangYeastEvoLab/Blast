#!/bin/bash

# modify for each use 
	 # --mail-user = rcv216@lehigh.edu
	 # export path to directory containing blast_queries.sh

#SBATCH --partition=lts
#SBATCH --qos=nogpu
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --job-name=query_blast_pipeline
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rcv216@lehigh.edu

module load blast-plus/2.9.0
export PATH=$PATH:/share/ceph/gil213group/shared/blast_pipeline
blast_queries.sh
exit
