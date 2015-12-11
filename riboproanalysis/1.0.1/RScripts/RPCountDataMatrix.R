#!/usr/bin/env Rscript

args <- commandArgs(TRUE)

nbSample <- length(args)
rp.matrix <- read.table(paste(args[1],"_RPcounts.txt",sep=""))
rp.matrix <- rp.matrix[order(rp.matrix[,1]),]

for (i in 2:nbSample) {
new.rp.matrix <- read.table(paste(args[i],"_RPcounts.txt",sep=""))
new.rp.matrix <- new.rp.matrix[order(new.rp.matrix[,1]),]
rp.matrix <- cbind(rp.matrix,new.rp.matrix[,2])
}


names(rp.matrix) <- c("geneIds",args)

write.table(rp.matrix, "RPmainMatrix.txt", sep = "\t", na = " ", row.names = F, col.names = T)

