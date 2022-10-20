library(topGO)

geneID2GO <- readMappings(file = "../Reference_Files/Annotation_Files/Cre_gene2go")
geneNames <- names(geneID2GO)

RunTopGO <- function(interesting_genes, rownum = 1){
    geneList <- factor(as.integer(geneNames %in% interesting_genes))
    names(geneList) <- geneNames
    
    storage <- data.frame(i=integer(), Annotation = I(list()))
    
    ontology = c("MF", "BP", "CC")
    for (term in 1:length(ontology)) {
        #set up the GOdata and run the algorithms 
        GOdata <- new("topGOdata", ontology = ontology[term], allGenes = geneList, annot = annFUN.gene2GO, 
                      gene2GO = geneID2GO)
        resultFis <- runTest(GOdata, algorithm = "classic", statistic = "fisher")
        
        #Generate the results table 
        gene_table <- GenTable(GOdata, classic = resultFis, orderBy = "classic", topNodes = length(usedGO(GOdata)), numChar=10000)
        gene_table$classic <- as.numeric(gene_table$classic)
        #just get the significant genes
        gene_table <- gene_table[gene_table$classic <= 0.01,]
        gene_table$adjusted_p <- p.adjust(gene_table$classic, method = "BH")
        
        #store gene table
        gene_table <- gene_table[order(gene_table$classic, -gene_table$Significant),] 
        storage[1, "i"] <- rownum
        if (nrow(gene_table) > 0){
            gene_table$component <- ontology[term]
            storage[[1, "Annotation"]] <- rbind(storage[[1, "Annotation"]], gene_table)
        }
    }
    return(storage)
}

summariseGO <- function(Annotation){
    if (length(Annotation) == 0) {
        return(data.frame(count_summary = "NA",
                    pval_summary = "NA"))
    }
    
    #get the highest scoring annotation for both the counts and the pvalue
    summarise_counts <- ""
    summarise_pval <- ""
    
    AnnotationMF <- Annotation[Annotation$component == "MF", ]
    AnnotationCC <- Annotation[Annotation$component == "CC", ]
    AnnotationBP <- Annotation[Annotation$component == "BP", ]

    summarise_counts <- paste(unlist(c("MF: ", AnnotationMF[order(-AnnotationMF$Significant),][1, "Term"], 
                                                      ", BP: ", AnnotationBP[order(-AnnotationBP$Significant),][1, "Term"],
                                                      ", CC: ", AnnotationCC[order(-AnnotationCC$Significant),][1, "Term"])), collapse = "")

    summarise_pval <- paste(unlist(c("MF: ", AnnotationMF[order(AnnotationMF$classic),][1, "Term"], 
                                                      ", BP: ", AnnotationBP[order(AnnotationBP$classic),][1, "Term"],
                                                      ", CC: ", AnnotationCC[order(AnnotationCC$classic),][1, "Term"])), collapse = "")
    return(data.frame(count_summary = summarise_counts,
                    pval_summary = summarise_pval))
    
}





