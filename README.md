# outbryk

Repository for the Cortex-based pipeline we are setting up to enter
the "2015 Rapid NGS Bioinformatic Pipelines for Enhanced Molecular Epidemiologic Investigation of Pathogens"

"We" = Henk denBakker, Zam Iqbal, Phelim Bradley, Jen Gardy, Rachel Norris, Sarah Walker,
      Derrick Crook, Tim Peto
      
First we need to agree on what out pipeline will do


First, we produce a set of reference genomes that represent the major
clades of the species of interest. We produce a set of SNPs
that differentiate them.

Second we produce a large pool of samples which can be used as representation
of "background genetic variation". Once we get our dataset which we want to analyse
(which I'll call the challenge dataset), we will select a subsample of these background
samples, to jointly analyse with our challenge samples


Given a new set of fastq for the challenge:

0. Run the Cortex standard independent workflow using a predetermined reference genome
   on the challenge samples and (if not done already) on the background samples.
   Only run the workflow as far as getting one per-sampe VCF each (don't make a unified site-list yet).
1. Choose a set of background samples
2. Complete the Cortex independent workflow with challenge+selected background, producing a single VCF
3, Build a tree and look for clusters
4. For each cluster, use MASH to choose a closer reference genome https://github.com/marbl/Mash, http://mash.readthedocs.org/en/latest/index.html
5. Now use the Cortex joint workflow (ie compare samples directly, with no reference involved) using this closer reference for coordinates.
6. See if this new callset provides better resolution of the cluster
7. Produce a pangenome matrix of genes of interest (phages initially)
8. Make manual decisions about outbreak
 

Step 1 is somewhat open. Options are
a) Use the SNPs between ref-genomes to choose the closest reference to each challenge sample, and thus determine
   which clades they lie in. 
   Then do the same for ALL the background samples, and choose a subset which are in the same subclades as the challenge

b) Genotype all challenge and background samples at the ref-SNPs, and build a tree using FastTree

c) Use MASH on all samples and choose closest ref, and thus choose background samples.
        
      
