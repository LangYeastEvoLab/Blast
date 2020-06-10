#!/bin/bash

#pipeline to use custom blast database to pull out 
#query genes from Saccharomycetaceae genomes
# shell script by KJF
# last modified RCV 06-10-20


#concatenate all genomes
cat Saccharomycetaceae_genomes/genomes/*.fas > all_genomes.fas

#build a blast database from Saccharomycetaceae genomes
makeblastdb -in all_genomes.fas -dbtype nucl -out Sacch_db.fn

for GENE in IME2 STE4
do

#blast using discontinuous megablast. See user manual https://www.ncbi.nlm.nih.gov/books/NBK279668/
#to look at other options.
blastn -task dc-megablast -query query_genes/$GENE\.fas -db ./Sacch_db.fn -outfmt '6 sseqid sseq' -out $GENE\_hits.txt -max_hsps 1

#series of steps to format the file for alignment
awk -F '\t' '{printf ">%s\n%s\n",$1,$2}' $GENE\_hits.txt > $GENE\_hits.fas
#puts file in fasta format
sed -i 's/-//g' $GENE\_hits.fas
#removes dashes (so alignment software is happy)
sed -i 's/=//g' $GENE\_hits.fas
# removes = signs from results file (so alignment software is happy)
sed 's/\[//g;s/\]//g' $GENE\_hits.fas > $GENE\_for_alnmnt.fas
# removes square brackets from results file (alignment software)
sed -i 's/ /_/g' $GENE\_for_alnmnt.fas
# replace spaces with underscores (alignment software)
sed -i 's/,/_/g' $GENE\_for_alnmnt.fas
# replaces commas with underscores (alignment software)

rm *hits*

done
