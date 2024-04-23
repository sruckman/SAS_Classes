
dir<-"C:\\Users\\SHXU\\Dropbox\\My UCR Teaching\\BPSC148\\BPSC148-2017\\Textbook\\Chapter 12"
setwd(dir)

phe<-read.csv(file="phe.csv",header=TRUE)
aa<-read.csv(file="aa.csv",header=TRUE)
source("mixedFunction.R")

y<-as.matrix(phe$y)
x<-as.matrix(phe$x)
par<-mixed(x=x,y=y,aa=aa,method="REML")
write.csv(x=par,file="mixed-parms.csv",row.names=F)
par$beta
par$va
par$ve

 