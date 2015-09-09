#!/bin/bash
VCF=$1

cat $VCF|grep 'PASS'|grep 'SVLEN=0;SVTYPE=SNP\s' > $VCF.passedSNP_p.vcf;
head -26 $VCF > header_vcf.txt
tail -1 header_vcf.txt > column_header.txt
head -23 header_vcf.txt > header2.txt
cat header2.txt column_header.txt $VCF.passedSNP_p.vcf > ${VCF%.vcf}.passedSNPs.vcf
rm $VCF.passedSNP_p.vcf
