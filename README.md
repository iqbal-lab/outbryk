# outbryk

Repository for the Cortex-based pipeline we are setting up to enter
the "2015 Rapid NGS Bioinformatic Pipelines for Enhanced Molecular Epidemiologic Investigation of Pathogens"

"We" = Henk denBakker, Zam Iqbal, Phelim Bradley, Jen Gardy, Rachel Norris, Sarah Walker,
      Derrick Crook, Tim Peto
      

Given a new set of fastq, called the "challenge" for the moment, Outbryk will:


1. Complete the Cortex independent workflow with challenge+selected background, producing a single VCF
2, Build a tree and look for clusters
3. For each cluster, use MASH to choose a closer reference genome https://github.com/marbl/Mash, http://mash.readthedocs.org/en/latest/index.html
4. Now use the Cortex joint workflow (ie compare samples directly, with no reference involved) using this closer reference for coordinates.
5. See if this new callset provides better resolution of the cluster
6. Study contig sharing, phage presence and indel presence within clusters

Outbryk is not ready for outside use, but feel free to take a look, and trial it if you wish. We need to make it more robust before we push it out, but the ASM NGS challenge has been a very useful trial
