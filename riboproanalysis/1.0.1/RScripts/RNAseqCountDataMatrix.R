#!/usr/bin/env Rscript

args <- commandArgs(TRUE)

nbSample <- length(args)
rna.matrix <- read.table(paste(args[1],"_mRNAcounts.txt",sep=""))
rna.matrix <- rna.matrix[order(rna.matrix[,1]),]

for (i in 2:nbSample) {
new.rna.matrix <- read.table(paste(args[i],"_mRNAcounts.txt",sep=""))
new.rna.matrix <- new.rna.matrix[order(new.rna.matrix[,1]),]
rna.matrix <- cbind(rna.matrix,new.rna.matrix[,2])
}


names(rna.matrix) <- c("geneIds",args)

write.table(rna.matrix, "mRNAmainMatrix.txt", sep = "\t", na = " ", row.names = F, col.names = T)
