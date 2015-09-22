#!/usr/bin/perl -w
use strict;
use File::Basename;
use File::Spec;
use Getopt::Long;
use Benchmark;
use Cwd    qw( abs_path );
use FindBin qw($Bin);



### Take a sites VCF, and a set of samples which already have cortex graphs
### and make a cortex graph of alleles and reference-intersect-bubbles
###  - all the things you need to then parallelise

### Make sure cortex/scripts/calling, cortex/scripts/analyse_variants/perl_modules/Statistics-Descriptive-2.6,
###  and cortex/scripts/analyse_variants/bioinf-perl/lib are in your PERL5LIB

use Descriptive;
use VCFFile;
use lib "/home/zam/dev/git/cortex/scripts/calling/";
use ConfigMgmt qw( get_from_config_if_undef print_to_config get_all_info_from_config_if_undef check_outdir);
use BasicUtils qw ( add_slash create_dir_if_does_not_exist);

my %vars = ( "invcf" => "",
	     "refname" => "",
	     "ref_fa" =>"",
	     "ref_binary" => "",
	     "outdir" => "",
	     "prefix" => "",
	     "kmer" => "",
	     "mem_height" => "",
	     "mem_width" => "",
	     "vcftools_dir" => "",
	     "genome_size" => "",
	     "bubble_graph" => "",
	     "ref_overlap_bubble_graph" => "",
	     "bubble_callfile" => "",
	     "cortex_dir"=>"");


&GetOptions(
    'invcf:s'           => \$vars{"invcf"},
    'vcftools_dir:s'    => \$vars{"vcftools_dir"},
    'outdir:s'          => \$vars{"outdir"},## this is the same dir where we run the cortex indep wkflow on all samples
    'prefix:s'          => \$vars{"prefix"},
    'refname:s'       => \$vars{"refname"},
    'ref_fasta:s'       => \$vars{"ref_fa"},
    'ref_binary:s'       => \$vars{"ref_binary"},
    'kmer:i'            =>\$vars{"kmer"},
    'mem_height:i'      =>\$vars{"mem_height"},
    'mem_width:i'       =>\$vars{"mem_width"},
    'cortex_dir:s'        => \$vars{"cortex_dir"},
);

##check that was entered on commandline, that it exists, and add slash
check_outdir(\%vars);
check_args(\%vars);
#make sure there is a slash on the end
$vars{"cortex_dir"} = BasicUtils::add_slash($vars{"cortex_dir"});

my $comb_dir = $vars{"outdir"}."selecting_background/";
create_dir_if_does_not_exist($comb_dir, "prep_for_genotyping_at_clade_snps.pl");

get_all_info_from_config_if_undef(\%vars, $vars{"outdir"}."config.par.txt");
get_all_info_from_config_if_undef(\%vars, $vars{"outdir"}."config.prep.txt");
$vars{"vcftools_dir"} = BasicUtils::add_slash($vars{"vcftools_dir"});

my $scripts_dir = $vars{"cortex_dir"}."scripts/analyse_variants/bioinf-perl/vcf_scripts/";
my $analyse_dir = $vars{"cortex_dir"}."scripts/analyse_variants/";
my $scripts_dir2 = $vars{"cortex_dir"}."scripts/analyse_variants/combine/";

my $output_config = $comb_dir."config.txt";
my $fh_CONFIG;
open($fh_CONFIG, ">".$output_config)||die("Cannot open output config file $output_config\n");
print_to_config("kmer", \%vars, $fh_CONFIG);


## annotate flanks

my $af = $scripts_dir."vcf_add_flanks.pl";
my $kp4 = $vars{"kmer"}+4;
#print "Annotate flanks\n";
my $outvcf2=$comb_dir.basename($vars{"invcf"}).".annot_flanks";
my$libdir = $vars{"cortex_dir"}."/scripts/analyse_variants/bioinf-perl/lib/";
my $cmd2 = "perl  -I $libdir $af $kp4 ".$vars{"invcf"}." ".$vars{"refname"}." ".$vars{"ref_fa"}." > $outvcf2 2>/dev/null";
#print "$cmd2\n";
my $ret2 = qx{$cmd2};
#print "$ret2\n";



###############################################
##make pseudo callfile
$vars{"bubble_callfile"} = $comb_dir.$vars{"prefix"}.".pseudo_callfile";

my $ps = $scripts_dir2."build_pseudo_callfile_from_vcf.pl";
#print "Make pseudo callfile\n";
my $cmd3 = "perl $ps $outvcf2 ".$vars{"bubble_callfile"};
#print "$cmd3\n";
my $ret3 = qx{$cmd3};
#print "$ret3\n";
#print $fh_CONFIG "bubble_callfile\t$pseudo_callfile\n";
print_to_config("bubble_callfile", \%vars, $fh_CONFIG);


###############################################    
## make branch file, and dump binaries

my $branches = $vars{"bubble_callfile"}.".branches.fasta";
my $branches_log = $branches.".log";
my $cmd_b1 = "perl $analyse_dir"."make_branch_fasta.pl --callfile ".$vars{"bubble_callfile"}." --kmer ".$vars{"kmer"}." > $branches_log 2>&1 ";
#print "$cmd_b1\n";
my $ret_b1 = qx{$cmd_b1};
#print "$ret_b1\n";


##calculate max allele length
$vars{"max_allele"} = calculate_max_allele_len($branches);
if ($vars{"max_allele"}==0)
{
    die("Error creating pseudocallfile - seems to be empty\n");
}

print_to_config("max_allele", \%vars, $fh_CONFIG);


if (!(-e $branches))
{
    die("Failed to create $branches. See logfile $branches_log\n");
}

my $branches_list = $branches.".list";
my $bn = basename($branches);
my $cmd_b2 = "echo $bn > $branches_list";
#print "$cmd_b2\n";
my $ret_b2 = qx{$cmd_b2};
#print "$ret_b2\n";

my $ctx_binary1 = check_cortex_compiled_1colour($vars{"cortex_dir"}, $vars{"kmer"});
$vars{"bubble_graph"} = $branches;
my $k = "k".$vars{"kmer"};
$vars{"bubble_graph"} =~ s/fasta/$k.ctx/;
my $bubble_graph_log = $vars{"bubble_graph"}.".log";
my $cmd_b3 = $ctx_binary1." --se_list $branches_list --mem_height ".$vars{"mem_height"};
$cmd_b3 .= " --mem_width ".$vars{"mem_width"};
$cmd_b3 .= " --kmer_size ".$vars{"kmer"};
$cmd_b3 .= " --dump_binary ".$vars{"bubble_graph"}."  > $bubble_graph_log 2>&1";
#print "$cmd_b3\n";
my $ret_b3 = qx{$cmd_b3};
#print "$ret_b3\n";
#print $fh_CONFIG "bubble_graph\t$bubble_graph\n";
print_to_config("bubble_graph", \%vars, $fh_CONFIG);

print "Allele graph constructed for phylo-informative SNPs.\n";


my $ctx_binary2 = check_cortex_compiled_2colours($vars{"cortex_dir"}, $vars{"kmer"});
my $suffix = "intersect_bubbles";
my $ref_intersect_log = basename($vars{"ref_binary"}.".intersect_bubbles.log");
$ref_intersect_log=$comb_dir.$ref_intersect_log;
my ($reflist, $ref_col_list) =get_ref_col_list($vars{"ref_binary"}, $comb_dir);
$vars{"ref_overlap_bubble_graph"} = $reflist."_intersect_bubbles.ctx";


my $cmd_b4 = $ctx_binary2." --kmer_size ".$vars{"kmer"};
$cmd_b4 .= " --multicolour_bin ".$vars{"bubble_graph"}." --mem_height ".$vars{"mem_height"};
$cmd_b4 .= " --mem_width ".$vars{"mem_width"};
$cmd_b4 .= " --colour_list $ref_col_list  ";
$cmd_b4 .= "--load_colours_only_where_overlap_clean_colour 0 ";
$cmd_b4 .= "--successively_dump_cleaned_colours $suffix  > $ref_intersect_log 2>&1";
#print "$cmd_b4\n";
my $ret_b4 = qx{$cmd_b4};
#print "$ret_b4\n";

print_to_config("ref_overlap_bubble_graph", \%vars, $fh_CONFIG);
close($fh_CONFIG);
print "Intersection of reference genome and allele graph constructed\n";

## Now just make a filelist of sample graphs
make_sample_graph_filelist($vars{"outdir"}, $vars{"kmer"}, $comb_dir);


printf("Config file $output_config will be needed as an argument by scripts/calling/gt_1sample_at_phylosnps.pl\n");


sub check_args
{
    my ($hashref) = @_;

    if ($hashref->{"prefix"} eq "")
    {
	$hashref->{"prefix"} = "XYZ";
    } 
    if ($hashref->{"refname"} eq "")
    {
	$hashref->{"refname"} = "REF";
    }

}
sub make_sample_graph_filelist
{
    my ($rcdir, $k, $combine_dir) = @_;
     
    my $reg = $rcdir."\*/binaries/cleaned/k".$k.'/'."\*ctx";

    my $listing_cmd = "ls $reg";
    my $listing = qx{$listing_cmd};
    my @sp = split(/\n/, $listing);
    my $outfile = $combine_dir."list_args_for_final_step";
    open(OUT, ">".$outfile)||die("Cannot open $outfile\n");
    foreach my $f (@sp)
    {
	if ($f=~ /\/([^\/]+)\.kmer/)
	{
	    my $id = $1;
	    my $sample_odir;
	    if ($f=~ /($rcdir.+)binaries/)
	    {
		$sample_odir = $1;
	    }
	    
	    my $sample_gtdir= $sample_odir."phylosnp_typing";
	    if (!(-d $sample_gtdir))
	    {
		create_dir_if_does_not_exist($sample_gtdir, 
					     "make_sample_graph_filelist() in prep_for_genotyping_at_clade_snps.pl");
	    }
	    print OUT "$id\t$sample_gtdir\t$f\n";
	}
    }
    close(OUT);
}


sub get_ref_col_list
{
    my ($ref, $odir) = @_;
    my $ref_col_list = $odir.basename($ref.".colour_list");
    my $bn_ref_col_list = basename($ref.".colour_list");
    my $ref_list = $odir.basename($ref.".list");
    my $bn_ref_list = basename($ref.".list");
    my $c1 = "ls $ref > $ref_list";
    #print "$c1\n";
    my $r1=qx{$c1};
    my $c2 = "echo $bn_ref_list  > $ref_col_list";
    #print "$c2\n";
    my $r2 =qx{$c2};
    #print "$r2\n";
    return ($ref_list, $ref_col_list);
}



sub check_cortex_compiled_1colour
{
    my ($dir, $k) = @_;

    my $maxk=31;
    if (($k>32) && ($k<64) )
    {
	$maxk=63;
    }
    elsif ($k<32)
    {
	#maxk is already 31
    }
    else
    {
	die("This script expects you to use a k<64");
    }
	
    if (-e $dir."bin/cortex_var_".$maxk."_c1")
    {
	return $dir."bin/cortex_var_".$maxk."_c1";
    }
    else
    {
	die("Please go and compile Cortex in ".$vars{"cortex_dir"}." for k=$k with 1 colour");
    }
}


sub check_cortex_compiled_2colours
{
    my ($dir, $k) = @_;

    my $maxk=31;
    if (($k>32) && ($k<64) )
    {
	$maxk=63;
    }
    elsif ($k<32)
    {
	#maxk is already 31
    }
    else
    {
	die("This script expects you to use a k<64");
    }
	
    if (-e $dir."bin/cortex_var_".$maxk."_c2")
    {
	return $dir."bin/cortex_var_".$maxk."_c2";
    }
    else
    {
	die("Please go and compile Cortex in ".$vars{"cortex_dir"}." for k=$k with 2 colours");
    }
}

sub calculate_max_allele_len
{
    my ($fasta) = @_;
    
    my $max = 0;
    open(FA, $fasta)||die();
    while (<FA>)
    {
	my $readline = $_;
	if ($readline=~ /^>/)
	{
	    $readline = <FA>;
	    chomp $readline;
	    my $len = length($readline);
	    if ($len>$max)
	    {
		$max=$len;
	    }

	}
    }
    close(FA);
    return $max;
    
}

