#!/user/bin/perl -w
use strict;


## Remove any site with missingness, and any site which does not have
## BOTH a confident 0/0 call, and a confident 1/1 call.

## What do we do at sites with mixture? I think
## if a SAMPLE shows evidence of mixture, we need to handle that specifically.

my $vcf =  shift;
my $out = $vcf.".filtered";
my $conf_thresh = 2;

open(FILE, $vcf)||die();
open(OUT, ">".$out)||die();

while (<FILE>)
{
    my $line  = $_;
    chomp $line;
    if ($line =~ /^\#/)
    {
	print OUT $line."\n";
    }
    else
    {
	##split out the tab-separated fields into an array
	my @sp = split(/\t/, $line);
	my $filter = $sp[6];
	if ($filter eq "PASS")
	{
	    ##if no sample is marked ./. (missing data - probably means this site is not in the core genome
	    ## or sequence is somehow diverged - could be a nearby SNP)
	    if ($line !~ /\.\/\./)
	    {
		### Now collect all the genotypes and confidences

		my $descriptor = $sp[8]; #   GT:GL:GT_CONF:COV
		##really I should just parse it
		if  ($descriptor ne "GT:GL:GT_CONF:COV")
		{
		    die("Combined VCF is not in the format I expected, descriptor is $descriptor not GT:GL:GT_CONF:COV\n");
		}
		my %gt=();
		my %conf=();
		my $i;
		my $one_confident_00=0;
		my $one_confident_11=0;

		for ($i=9; $i<scalar(@sp); $i++)
		{
		    my @fields = split(/:/, $sp[$i]);
		    $conf{$i} = $fields[2];
		    $gt{$i}=$fields[0];
		    if ( ($gt{$i} eq "0/0") && ($conf{$i}> $conf_thresh) )
		    {
			$one_confident_00=1;
		    }
		    elsif ( ($gt{$i} eq "1/1") && ($conf{$i}> $conf_thresh) )
		    {
			$one_confident_11=1;
		    }
		}
		if ( ($one_confident_00==1) 
		     && 
		     ($one_confident_11==1) )
		{
		    print OUT "$line\n";
		}
	    }
	}
    }
}
close(FILE);
close(OUT);
