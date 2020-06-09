# Script CIRCExplorer with STAR

#!/bin/bash -l
##dependencies:
#star/2.7.2b
#CIRCexplorer/1.1.10

#Generate Star genome index
## genomeSAindexNbases calculated to 9,557860944 (...min(14, log2(GenomeLength)/2 - 1))
STAR --runThreadN 4 --runMode genomeGenerate --genomeSAindexNbases 9 --genomeDir /proj/uppstore2017134/stress/circ/star-genome9 \
--genomeFastaFiles /*.fa --sjdbGTFfile NC_003112.gff

##RUN star
##for single file                                                       ###fill in genome                                   ###fill in reads
STAR --chimSegmentMin 10 --runThreadN 18 --genomeDir [DIR/star-genome] --readFilesCommand gzip -c --readFilesIn *.fa.gz

##for paired sequencing
STAR --chimSegmentMin 10 --runThreadN 18 --genomeDir [star-genome] --readFilesCommand gzip -c --readFilesIn *.fa.gz *.fa.gz


star_parse.py Chimeric.out.junction fusion_junction.txt


CIRCexplorer.py -j fusion_junction.txt -g /proj/uppstore2017134/stress/circ/NC_003112.2.fa -r /proj/uppstore2017134/stress/circ/NC_*_Special.txt

CIRCexplorer.py -j fusion_junction.txt -g /proj/uppstore2017134/stress/circ/NC_003112.2.fa -r /proj/uppstore2017134/stress/circ/NC_*.gff
