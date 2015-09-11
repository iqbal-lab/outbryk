# outbryk

Repository for the Cortex-based pipeline we are setting up to enter
the "2015 Rapid NGS Bioinformatic Pipelines for Enhanced Molecular Epidemiologic Investigation of Pathogens"

"We" = Henk denBakker, Zam Iqbal, Phelim Bradley, Jen Gardy, Rachel Norris, Sarah Walker,
      Derrick Crook, Tim Peto
      
First we need to agree on what out pipeline will do

Given a new set of fastq

0. Run the Cortex stadard independent workflow using a predetermined reference genome
1. Build a tree and look for clusters
2. For each cluster, use MASH to choose a closer reference genome https://github.com/marbl/Mash, http://mash.readthedocs.org/en/latest/index.html
3. Now use the Cortex joint workflow (ie compare samples directly, with no reference involved) using this closer reference for coordinates.
4. See if this new callset provides better resolution of the cluster
5. Produce a pangenome matrix of genes of interest (phages initially)
6. Make manual decisions about outbreak
      
      
