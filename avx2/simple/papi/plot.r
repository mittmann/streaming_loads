library(dplyr);
library(ggplot2);

df <- read.csv("saida.csv");


k <- df %>% select(counter,size,memtype,temp,opt,value) %>% 
    	      group_by(counter,size,memtype,temp,opt) %>% summarise(mean=mean(value), n=n(), sd=sd(value), se=sd/sqrt(n), ic=1.96*se)

k <- k[k$size=="huge",]
k <- k[k$counter=="PAPI_TOT_CYC",]

ggplot(k, aes(x=opt:temp:memtype:opt, y = mean)) + geom_point() 

