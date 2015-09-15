#!/bin/bash
VCF=$1
script_dir=`dirname $0`

cat $VCF|grep 'PASS'|grep 'SVLEN=0;SVTYPE=SNP\s' > $VCF.passedSNPs.vcf;
head -31 $VCF > $VCF.header_vcf.txt
cat $VCF.header_vcf.txt $VCF.passedSNPs.vcf > $VCF.passedSNPsH.vcf
cat $VCF.passedSNPsH.vcf | vcf-to-tab > $VCF.snps.tab;
perl $script_dir/vcf_tab_to_fasta_alignment.pl -i $VCF.snps.tab > $VCF.all_snps.fasta;
rm $VCF.passedSNPs.vcf
rm $VCF.passedSNPsH.vcf
rm $VCF.snps.tab
rm $VCF.header_vcf.txt
