#!/bin/bash
VCF=$1

cat $VCF|grep 'PASS'|grep 'SVLEN=0;SVTYPE=SNP\s' > $VCF.passedSNPs.vcf;
head -29 $VCF > header_vcf.txt
cat header_vcf.txt $VCF.passedSNPs.vcf > $VCF.passedSNPsH.vcf
cat $VCF.passedSNPsH.vcf | vcf-to-tab > snps.tab;
vcf_tab_to_fasta_alignment.pl -i snps.tab > $VCF.all_snps.fasta;
rm *.passedSNPs.vcf
rm *.passedSNPsH.vcf
rm snps.tab
rm header_vcf.txt
