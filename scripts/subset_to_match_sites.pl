#!/usr/bin/perl -w
use strict;


use File::Basename;
use File::Spec;
use Getopt::Long;
use Benchmark;


my $bigvcf="";
my $sitesvcf="";
my $outfile = "";
&GetOptions(
    'bigvcf:s'                     =>\$bigvcf,
    'sitesvcf:s'                    =>\$sitesvcf,
    'outfile:s'                    =>\$outfile,
    );


### First make a hash - remember the sites you want 

## This will be a mapping between chromosome position and REFallele - underscore - ALTallele
my %sites = ();
get_sites(\%sites, $sitesvcf);

open(OUT, ">".$outfile)||die("Cannot open $outfile");
open(FILE, $bigvcf)||die("Cannot open $bigvcf");
while (<FILE>)
{
    my $line = $_;
    chomp $line;
    if ($line =~ /^\#/)
    {
	print OUT $line."\n";
    }
    else
    {
	## split by tab
	my @sp = split(/\t/, $line);
	my $pos = $sp[1];
	my $ref = $sp[3];
	my $alt = $sp[4];

	
	if (exists $sites{$pos})
	{
	    ## Then this VCF has a variant at one of the positions we are interested in
	    if ($sites{$pos} eq $ref."_".$alt)
	    {
		# Then the variant at this position has same alleles as the one in our sites VCF
		print OUT $line."\n";
	    }
	}
    }
}
close(FILE);
close(OUT);


sub get_sites
{
    my ($href, $f) = @_;
    open(FILE, $f)||die();

    while (<FILE>)
    {
	my $line = $_;
	chomp $line;
	
	if ($line !~ /^\#/)
	{
	    my @sp = split(/\t/, $line);
	    my $pos = $sp[1];
	    my $ref = $sp[3];
	    my $alt = $sp[4];
	    $href->{$pos}=$ref."_".$alt;
	    #print "Add $pos ---> ".$ref."_".$alt."\n";

	}
    }
    close(FILE);

}
