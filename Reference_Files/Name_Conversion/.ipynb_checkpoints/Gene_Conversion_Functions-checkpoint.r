name_conversion <- function(gene_list){
    conversion_file <- read.csv("../Reference_Files/Name_Conversion/Clean_conversion_file.txt", sep = '\t')[,c(1,8)]
    #Replace the .t#.t# with nothing 
    conversion_file$`X.5.5` <- gsub(".t\\d.?\\d?", "", conversion_file$`X.5.5`)
    conversion_file$`X5.3.1` <- gsub(".t\\d.?\\d?", "", conversion_file$`X5.3.1`)
    
    #predefine empty vector
    translated <- character(length(gene_list))
    
    #do the loop
    for (gene in 1:length(gene_list)) {
        #since apparently now the file has multiple genes with the same name (previously different transcripts), 
        #some genes in 5.3 will have repeats in 5.5
        #Just take the first one
        
        translated[gene] <- conversion_file[conversion_file$`X5.3.1` == gene_list[gene],]$`X.5.5`[1]
    }
    
    #return the translated genes :)
    return(translated)
}

Ensembl_name_conversion <- function(gene_list){
    translated <- name_conversion(gene_list)
    
    #Ensembl genes look like: CHLRE_07g326200v5
    #5.5 genes look like: Cre01.g001350
    translated <- gsub("Cre", "CHLRE_", translated)
    translated <- gsub("\\.", "", translated)
    translated <- paste0(translated, 'v5')
    
    return(translated)
}
