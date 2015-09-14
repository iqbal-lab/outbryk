import vcf
import numpy as np
import pandas as pd
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-f", "--filename",
                  help="(path to) combined vcf")
parser.add_argument("-t", "--threshold", type=int, default=30,
                  help="genotype confidence threshold to exceed")
parser.add_argument("--indels", action="store_true", help="instead output presence/absence matrix of indels")

args = parser.parse_args()
(VCF,CONF_THRESHOLD, INDELS) = (args.filename, args.threshold, args.indels)

vcf_reader = vcf.Reader(open(VCF, 'r'))

# make a matrix of rows of the vcf showing which samples have high confidence ref/alt alleles
m = []
for record in vcf_reader:
    #if record.is_snp:
    if (INDELS and (record.is_indel or record.var_subtype == 'INS' or record.var_subtype == 'DEL')) or (record.is_snp and not INDELS):
        row = []
        for sample in vcf_reader.samples:
            if record.genotype(sample)['GT'] == '0/0' and record.genotype(sample)['GT_CONF'] > CONF_THRESHOLD:
                row.append(0)
            elif record.genotype(sample)['GT'] == '1/1' and record.genotype(sample)['GT_CONF'] > CONF_THRESHOLD:
                row.append(1)
            else:
                row.append(None)
        if 0 in row and 1 in row:
            m.append(row)
assert m!=[], "Matrix of presence/absence of differentiating variation is empty. This could be because the confidence threshold set is too high, or there is no variant which differentiates the sample."
df = pd.DataFrame(m)
df.columns = vcf_reader.samples

if INDELS:
    csv_file = VCF.split('.vcf')[0] + 'indelsmat.txt'
    df.to_csv(csv_file, sep='\t', na_rep='NaN')
else:
    snp_df = pd.DataFrame(index=vcf_reader.samples, columns=vcf_reader.samples)
    snp_df = snp_df.fillna(0) # with 0s rather than NaNs
    for s1 in vcf_reader.samples:
        for s2 in vcf_reader.samples:
            snp_df.loc[s1,s2] = np.nansum(abs(df[s1] - df[s2]))
    #print snp_df

    csv_file = VCF.split('.vcf')[0] + 'SNPdiffmat.txt'
    snp_df.to_csv(csv_file, sep='\t', na_rep='NaN')
    
