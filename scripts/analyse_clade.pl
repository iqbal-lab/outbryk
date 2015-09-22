#!/usr/bin/perl

# Program to try and get more resolution in a cluster/clade. 
# It does this by:
#	i) Choose another ref (MASH)
#	ii) run_calls.pl again. Will rebuild graphs and give a single vcf at end. use --wkflow joint, --ref coordinates_only and --do_union yes
#	iii) make tree
#	iv) make indel matrix of indels vs sample presence/absence
#	v) make matrix of presence/absence of big contigs
#	vi) phages: cortex --colourlist COL --pan_genome_matrix phage.fasta
# Takes as input a file with a list of sample ids which form a cluster.
#
# Notes: trimmomatic step without number of threads specified will use 16 and about 24 CPUs. Currently restricted to 4.
#	 This script currently calls a vcf_CortextofastaSNPs2.sh outbryk file - this is Henks script but pointing to things in the right place for me...
#	 Seems to be slow!
#	 If the outdir specified doesn't exist, script will make it.
#	 SNPdiffmatrix script requires your python to have pyvcf, pandas, numpy

use strict;
use warnings;
use Getopt::Long;
use Cwd 'abs_path';

BEGIN
{
    my $cortex_dir = '~/apps/cortex/';
    push ( @INC, $cortex_dir."scripts/calling/");
}

use BasicUtils qw ( check_cortex_runnable add_slash is_fastq count_bases_in_fasta create_dir_if_does_not_exist );

my $input_list;
my $outdir;
my $data_dir;
my $ref_mash;
my $index_dir;
my $ref_dir;
my $phage_fasta;

my $outbryk_dir = '/Net/cycloid/data2/users/rachel/projects/outbryk';
my $cortex_dir = '~/apps/cortex/';
my $vcftools_dir = '~/apps/vcftools_0.1.13/';
my $stampy_bin = '/apps/well/stampy/1.0.24-py2.7/stampy.py';
my $fasttree_dir = '/apps/well/fasttree/20150325/FastTree';

my $usage = "usage: $0 -i input_list.txt -o outdir -data_dir /path/to/samples/ -ref_mash /path/to/refs.msh -index_dir /path/to/full/INDEX -ref_dir /path/to/refs/ -phage_fasta /path/to/phages.fasta";

my $result = GetOptions (	"i=s"			=> \$input_list,
				"o=s"			=> \$outdir,
				"data_dir=s"		=> \$data_dir,
				"ref_mash=s"		=> \$ref_mash,
				"index_dir=s"		=> \$index_dir,
				"ref_dir=s"		=> \$ref_dir,
				"phage_fasta=s"		=> \$phage_fasta
						) or die "Incorrect usage. $usage\n";
$outdir = BasicUtils::add_slash($outdir);
BasicUtils::create_dir_if_does_not_exist($outdir, "make outdir if doesn't exist");
my $working_dir = abs_path('.');

# print start time
print "Start time: ";
my $st = "date";
my $ret_st = qx{date};
print "$ret_st\n";

########################
# i) MASH
########################
# Take first sample mentioned in cluster list and run trimmomatic on it.
my $cmd1 = "head -1 $input_list";
my $first = qx{$cmd1};
chomp $first;
print "\nFirst sample in clade list: $first\n";

my $cmd2 = "ls $data_dir/$first\*.fastq\*";
my $ret_cmd2 = qx{$cmd2};
my @fastqs = split("\n",$ret_cmd2);
print "\nFound fastqs: @fastqs \n\n";

my $trim = "java -classpath ~/apps/Trimmomatic-0.33/trimmomatic-0.33.jar org.usadellab.trimmomatic.TrimmomaticPE -threads 4 @fastqs $outdir/trim_1P.fq $outdir/trim_1U.fq $outdir/trim_2P.fq $outdir/trim_2U.fq SLIDINGWINDOW:4:15";
#print "\n$trim\n";
my $ret_trim = qx{$trim};

# Then use mash to pick a new reference
my $mash = "mash dist -u $ref_mash $outdir/trim\*.fq > $outdir/mash_summary.txt";
my $ret_mash = qx{$mash};
my $mash2 = "sort -nrk5 $outdir/mash_summary.txt | head -5";
my $ret_mash2 = qx{$mash2};
print "\nBest reference hits with mash were:\n$ret_mash2";
my @r = split("\n",$ret_mash2);
my @r2 =  split("\t", $r[0]);
my $ref = $r2[0];
print "\nChosen reference: $ref\n";

#######################
#ii) run_calls.pl again
#######################
# Create INDEX for just the samples named in cluster file
my $index = "for sample in \$(cat $input_list); do cat $index_dir | grep \$sample &>> $outdir/INDEX; done";
my $ret_index = qx{$index};

# Make a list for the reference
my $list = "ls $ref_dir/$ref &> $outdir/list_ref_fa";
my $ret_list = qx{$list};

# Re-run cortex
my $prepare = "perl $cortex_dir/scripts/calling/prepare.pl --index $outdir/INDEX  --ref_fa $ref_dir/$ref --dir_for_ref_objects $outdir/ref --vcftools_dir $vcftools_dir --outdir $outdir/results --stampy_bin $stampy_bin --kmer 31";
print "\n$prepare\n";
my $ret_prepare = qx{$prepare};

my $run_calls = "perl $cortex_dir/scripts/calling/run_calls.pl --first_kmer 31 --fastaq_index $outdir/INDEX --auto_cleaning yes --bc yes --pd no --outdir $outdir/results --outvcf output_cluster --ploidy 1 --stampy_hash $outdir/ref/stampy/REF --stampy_bin $stampy_bin --list_ref_fasta $outdir/list_ref_fa --refbindir $outdir/ref/ctx_bins/ --genome_size 4800000 --qthresh 5 --mem_height 20 --mem_width 100 --vcftools_dir $vcftools_dir --do_union yes --ref CoordinatesOnly --workflow joint --logfile $outdir/log_run_calls.txt";
print "\n$run_calls\n";
my $ret_run_calls = qx{$run_calls};

#######################
#iii) make tree
#######################
my $filter = "perl $outbryk_dir/scripts/filter_cortex_vcf.pl $outdir/results/vcfs/output_cluster_wk_flow_J_RefCO_FINALcombined_BC_calls_at_all_k.raw.vcf";
my $ret_filter = qx{$filter};
my $to_fasta = "bash $outbryk_dir/scripts/vcf_CortextofastaSNPs.sh  $outdir/results/vcfs/output_cluster_wk_flow_J_RefCO_FINALcombined_BC_calls_at_all_k.raw.vcf.filtered";
my $ret_to_fasta = qx{$to_fasta};
my $fasttree = "$fasttree_dir -nt $outdir/results/vcfs/output_cluster_wk_flow_J_RefCO_FINALcombined_BC_calls_at_all_k.raw.vcf.filtered.all_snps.fasta > $outdir/results/vcfs/output_cluster_wk_flow_J_RefCO_FINALcombined_BC_calls_at_all_k.raw.vcf.filtered.all_snps.fasta.fasttree";
my $ret_fasttree = qx{$fasttree};
my $snp_sites = "snp-sites -p -o $outdir/results/vcfs/mergedPassed.vcf.all_snps.phy $outdir/results/vcfs/output_cluster_wk_flow_J_RefCO_FINALcombined_BC_calls_at_all_k.raw.vcf.filtered.all_snps.fasta";
my $ret_snp_sites = qx{$snp_sites};
my $tree = "phyml -i $outdir/results/vcfs/mergedPassed.vcf.all_snps.phy -d nt -q -b 250 -m K80 --quiet";
print "\n$tree\n";
my $ret_tree = qx{$tree};

########################
#iv) make indel presence/absence matrix
#######################
my $matrix = "python $outbryk_dir/scripts/vcf_to_SNPdiffmatrix.py -f $outdir/results/vcfs/output_cluster_wk_flow_J_RefCO_FINALcombined_BC_calls_at_all_k.raw.vcf -t 5 --indels";
print "\n$matrix\n";
my $ret_matrix = qx{$matrix};

###########################
#v) make cortex contig matrix
############################
my $list2 = "cd $outdir; ls results/binaries/cleaned/k31/*.ctx > FLIST; cd $working_dir";
my $ret_list2 = qx{$list2};
my $list3 = "echo FLIST > $outdir/COLLIST";
my $ret_list3 = qx{$list3};
my $supernodes = "cortex_var_31_c1 --colour_list $outdir/COLLIST --kmer 31 --mem_height 21 --mem_width 100 --output_supernodes $outdir/contigs.fa --max_var_len 100000";
print "\n$supernodes\n";
my $ret_supernodes = qx{$supernodes};

# Find the length of the longest contig, and throw away contigs with <500bp
my $longest = 0;
open (READFILE, "<$outdir/contigs.fa");
open (WRITEFILE, ">$outdir/contigs.filtered.fa");
$/ = "\n>";
while (<READFILE>) {
    s/>//g;
    my ($id, @seq) = split (/\n/, $_);
    my $seq = join "", @seq;
    if ((length $seq) > 500){
        print WRITEFILE ">$id\n$seq\n";
        }
    if ((length $seq) > $longest){
        $longest = (length $seq);
        }
}
close (READFILE);
close (WRITEFILE);

# Prepare and run cortex --pan_genome_matrix
my $cmd3 = "for sample in \$(cat $input_list); do cd $outdir/results/binaries/cleaned/k31/; ls \$sample\*.ctx > \$sample.ctx.list; cd $working_dir; done";
my $ret_cmd3 = qx{$cmd3};
my $cmd4 = "cd $outdir; ls results/binaries/cleaned/k31/\*.ctx.list > COLLIST2; cd $working_dir";
my $ret_cmd4 = qx{$cmd4};
my $count = "cat $input_list | wc -l";
my $ret_count = qx{$count};
my @num_samples = split("\n",$ret_count);
my $num_samples = $num_samples[0];
my $pan_genome = "cortex_var_31_c$num_samples --kmer 31 --mem_height 21 --mem_width 100 --colour_list $outdir/COLLIST2 --pan_genome_matrix $outdir/contigs.filtered.fa --max_read_len $longest";
print "\n$pan_genome\n";
my $ret_pan_genome = qx{$pan_genome};

#########################
#vi) spot phages
########################
my $copy = "cp $phage_fasta $outdir";
my $ret_copy = qx{$copy};
my @ret_copy2 = split('/',$phage_fasta);
my $p = $ret_copy2[-1];
my $phage = "cortex_var_31_c$num_samples --kmer 31 --mem_height 21 --mem_width 100 --colour_list $outdir/COLLIST2 --pan_genome_matrix $outdir/$p --max_read_len 100000";
print "\n$phage\n";
my $ret_phage = qx{$phage}; 

# print end time
print "Finish time: ";
my $ft = "date";
my $ret_ft = qx{date};
print "$ret_ft\n";
