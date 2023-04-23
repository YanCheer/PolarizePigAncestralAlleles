# PolarizePigAncestralAlleles
This repository is deposited with scripts for polarization of ancestral alleles of pig reference genome (_Sscrofa11.1_). <br>
The report has been prepared for submission.<br>

* Genome_Alignment_Scripts <br>
The `Genome_Alignment_Scripts` directory includes the scripts of `Progressive Cactus` pipeline to align reference genomes together and deposit results in HAL format. The HAL format file is converted into MAF format with Sscrofa11.1 as reference. <br>
Then the reconstructed ancestral sequences of pig, _Sus_, and _Suidae_ are exported. <br> 
The `Linux Shell` scripts should be run in order 01, 02, 03. The other scripts and files will be automatically called by `.sh` scripts for running. <br>

* Rscript_to_Validate_AA_byMP_inSplitChr.R <br>
The R script `Rscript_to_Validate_AA_byMP_inSplitChr.R` is used to perform the polarization via the major alleles of suids at a locus. The polarization is based on three representative outgroup species and a maximum-parsimony principle with details that have been listed in the script.
