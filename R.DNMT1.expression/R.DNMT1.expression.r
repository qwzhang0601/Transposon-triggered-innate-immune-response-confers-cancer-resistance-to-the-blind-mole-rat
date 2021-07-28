#############
#heatmap of DNMT1 expression in different tissues of BMR and mouse

rm(list=ls())
library("pheatmap")

path_files=""; ## set the path of the files
file_geneExpression=paste(path_files,"DNMT1.tpm.txt",sep=""); #file saving DNMT1 gene expression in different tissues of BMR and mouse

data=read.table(file=file_geneExpression,header=TRUE);

tpm=as.matrix(data[,3:12])
rownames(tpm)=as.character(data[,1])

z_scores=matrix(rep(0,8*10),ncol=10) 
rownames(z_scores)<-as.character(data[,1])
colnames(z_scores)<-colnames(z_scores)
for(i in 1:8)
{
       row_mean=mean(log2(tpm[i,]))
       row_sd=sd(log2(tpm[i,]))
       for(j in 1:10)
       {
           z_scores[i,j]=(log2(tpm[i,j])-row_mean)/row_sd
       }
}

#!! change the path if want to save it under a different address
pdf(file="./DNMT1.zscore.log2.heatmap.pdf",height=4)
pheatmap(t(z_scores),show_rownames=TRUE,display_numbers=FALSE,cluster_cols=FALSE,border_color=NA,cluster_rows=FALSE)
dev.off()

