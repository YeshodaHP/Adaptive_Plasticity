# Adaptive_Plasticity

# DE_Analysis
This folder contains the R notebook of the analyses done to assess differentially expressed genes (DEGs) and patterns of expression. Required files can be found in Reference_Files/DE_Analysis

# Mutation_Analysis
This folder contains the R notebook of the analyses done to assess mutations in the salt-adapted lines and their distance from DEGs. Required files can be found in Reference_Files/Mutation_Analysis. The GFF file (Reference_Files/Mutation_Analysis/final.strict.GFF3) has been compressed to allow uploading and must be compressed before running the R notebook

# Network_Analysis
This folder contains the R notebook of the analyses done to assess correlation in gene expression across different cell lines and their conditions. Required files can be found in Reference_Files/Network_Analysis

# Reference_Files
Holds all the source files for the respective projects mentioned above
  ### DE_Analysis
  - read_count_table.SE
    - Contains the table of read counts as a RangedSummarizedExperiment, with rows as genes and columns as samples
  - sampleInfo_Ancestors.csv
    - Contains a table of all the sample data i.e. name of sample, selection category, assay concentration, cell line etc.
    
  ### Mutation_Analysis
  - adaptation.gene_sets.filtered.tsv
    - Contains detailed table of mutation data for salt-adapted lines including gene name, mutation position, type of mutation etc. 
    - From @aays
    
  ### Network_Analysis
  - fpkm.36lines.txt
    - FPKM data for samples
  - ClinicalTraitsBinary.csv
    - Traits of each sample in a binary format for use with WGCNA
   
  ### Annotation_Files
  - Cre_gene2go and Cre_GO_annotation
    - text files with genes to it's multiple attatched GO annotations and genes to GO annotation with description
    - Imported from plantregmap
  - topGO_Annotation.ipynb and topGO_Annotation.r
    - scripts with funcitons to run topGO and simplify it's output to easily make decisions about the data
    
  ### Name_Conversion
  - Clean_conversion_file.txt
    - Gene names of *Chlamydomonas reinhardtii* between different genome versions
  - Gene_Conversion_Functions.ipynb and Gene_Conversion_Functions.r
    - Scripts with funcitons to convert gene lists form v5.3 to v5.5 of the *Chlamydomonas reinhardtii* genome 
