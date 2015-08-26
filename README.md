# outbryk

Repository for the Cortex-based pipeline we are setting up to enter
the "2015 Rapid NGS Bioinformatic Pipelines for Enhanced Molecular Epidemiologic Investigation of Pathogens"

"We" = Henk denBakker, Zam Iqbal, Phelim Bradley, Jen Gardy, Rachel Norris, Sarah Walker,
      Derrick Crook, Tim Peto
      
First we need to agree on what out pipeline will do

**Salmonella**
Given a new set of fastq

0. Should we do something cheap (MLST?) to separate into phylogroups? Tempted to try MASH https://github.com/marbl/Mash, http://mash.readthedocs.org/en/latest/index.html
1. call variants against ?? which reference Henk?
2. call variants jointly (coords only) then place calls on a reference.
3. produce a pangenome matrix of resistance genes and any other genes of interest (Henk?)
4. Use Fasttree to build a phylogeny? Henk?
      
      
