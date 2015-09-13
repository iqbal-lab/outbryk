#!/bin/bash
#draft bash reference selector and index creator; given a dir with fastq.gz data and a dir with potential references
# picks one fastq.gz file, trims it, and gives the closest reference hit; also creates index etc.  
# to run: sh ref_selector.sh /path/to/ref_dir /path/to/fastqgz_dir
ref_dir=$1
fastqgz_dir=$2
THREADS=$3
prefix=$4

#use Mash to make 'sketch' of potential reference genomes    
mash sketch -o $ref_dir/refs $ref_dir/*.fasta ## sketch

cd $fastqgz_dir; ## get into raw data dir

Y=$(shuf -n1 -e $fastqgz_dir/*.fastq.gz) ## select a fastq.gz file randomly for clean up   

##trimmomatic to clean up randomly selected file
java -jar /home/henk/Trimmomatic-0.33/trimmomatic-0.33.jar SE -threads $THREADS $Y output.fastq.gz ILLUMINACLIP:/home/henk/Trimmomatic-0.33/adapters/NexteraPE-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36;

##compute mash distances between cleaned file and refs and output highest match as new reference sequence
new_ref=$(mash dist -u $ref_dir/refs.msh output.fastq.gz|sort -nrk 5| head -1 | awk '{print $1;}')
echo $new_ref ## use highest match as ref

cd $fastqgz_dir
rm output.fastq.gz

##create file with path to raw data for each fastq.gz file
for f in *.fastq.gz;
do 
readlink -f $f > $f.se;
done
##remove old index file
rm index.txt
##create index for all isolates in the raw data directory
for f in *_1.fastq.gz; 
do
 echo -e ${f%_1.fastq.gz}'\t'.'\t'$f.se'\t'${f%_1.fastq.gz}_2.fastq.gz.se >>index.txt;
done