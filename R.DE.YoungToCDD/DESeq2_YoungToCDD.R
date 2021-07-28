
#######################
#Gene expression differential analysis between young cells and cells before CCD
rm(list=ls())
library("DESeq2")
library("ggplot2")

path_files=""; ## set the path of the files
file_readCounts=paste(path_files,"/TEtransM100.cntTable",sep=""); # the file saving gene expression of gene and TE from TEtranscripts tool based on RNA-seq data;
file_colData=paste(path_files,"/TEtransM100.cntTable",sep=""); # the file saving experimental factors of each sample;

readCounts <- read.table(file=file_readCounts,header=T,row.names=1);
colData <- read.table(file=file_colData,header=TRUE)

#pre-filtering
min_read <- 5 #filter gene/TE if read count less than 5 in all samples
readCounts <- readCounts[apply(readCounts,1,function(x){max(x)}) > min_read,]
colData <- read.table(file="./readCounts/colData.txt",header=TRUE)

dds <- DESeqDataSetFromMatrix(countData = readCounts,colData = colData,design = ~ Age)
dds <- DESeq(dds)

#counts(dds,normalized=T)
#nomalized counts
rld <- rlog(dds)
rldCount=assay(rld)
#!! change the path if want to save it under a different address
write.table(rldCount,file="./DeSeq_rlog.txt",quote = FALSE)

res=results(dds,contrast=c("Age","Old","Young"))
#We can order our results table by the smallest adjusted p value:
resOrdered <- res[order(res$padj),]

#!! change the path if want to save it under a different address
write.csv(as.data.frame(resOrdered),file="./DeSeq_results.csv")
write.table(as.data.frame(resOrdered),file="./DeSeq_results.txt",quote = FALSE)










