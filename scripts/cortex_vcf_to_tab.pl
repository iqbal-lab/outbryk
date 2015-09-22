#!/usr/bin/perl -w
use strict;

use Getopt::Long;

my $vcf="";
my $conf_thresh=5;

&GetOptions(
    'vcf:s'                     =>\$vcf,
    'conf_thresh:i'             =>\$conf_thresh,
    );

## At the moment this doesn't support outputting reference sequence between SNPs

check_args($vcf);
open(FILE, $vcf)||die();
while (<FILE>)
{
    my $line = $_;
    chomp $line;
    if ($line =~ /CHROM/)
    {
	my @head = split(/\s+/, $line);
	print "CHROM\tPOS\tREF\t";
	my $i;
	for ($i=9; $i<scalar(@head); $i++)
	{
	    print $head[$i];
	    if ($i<scalar(@head)-1)
	    {
		print "\t";
	    }
	    else
	    {
		print "\n";
	    }
	}
	
    }
    elsif ($line !~ /^\#/)
    {
	my @sp = split(/\t/, $line);
	my $chrom = $sp[0];
	my $pos = $sp[1];
	my $ref = $sp[3];
	my $alt = $sp[4];
	my $filter = $sp[6];
	my $format = $sp[8];

	if ( ( $filter eq "PASS") && ($line =~ /SVTYPE=SNP/) )
	{
	    print $chrom."\t".$pos."\t".$ref."\t";
	    my $i;
	    for ($i=9; $i<scalar(@sp); $i++)
	    {
		my $fields = $sp[$i];
		my @sp2 = split(/:/, $fields);
		my $gt = $sp2[0];
		my $conf = $sp2[2];
		if ($conf<$conf_thresh)
		{
		    print "./.";
		}
		elsif ($gt eq "0/0") 
		{
		    print $ref."/".$ref;
		}
		elsif ($gt eq "0/1")
		{
		    print $ref."/".$alt;
		}
		elsif ($gt eq "1/1")
		{
		    print $alt."/".$alt;
		}
		elsif ($gt eq "./.")
		{
		    print $gt;
		}
		else
		{
		    die("Unexpected option $gt $conf\n");
		}
		if ($i<scalar(@sp)-1)
		{
		    print "\t";
		}
		else
		{
		    print "\n";
		}
	    }
	}
    }
}
close(FILE);


sub check_args
{
    my ($f) = @_;
    if ($f eq "")
    {
	die("You must specify a VCF file with --vcf\n");
    }
}
