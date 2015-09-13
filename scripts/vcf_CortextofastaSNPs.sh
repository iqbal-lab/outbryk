#!/bin/bash
VCF=$1

cat $VCF | vcf-to-tab > snps.tab;
vcf_tab_to_fasta_alignment.pl -i snps.tab > $VCF.all_snps.fasta;
rm snps.tab
