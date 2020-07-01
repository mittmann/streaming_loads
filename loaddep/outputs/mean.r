library(dplyr);
library(tidyr);
#library(outliers);
args = commandArgs(trailingOnly=TRUE)
df <- read.csv(args[1]);

k <- df %>% select(size,mem,temp,shuff,cyc,l3r,l3m) %>% 
 group_by(size,mem,temp,shuff) %>% summarise(mcyc=mean(cyc), ml3m=mean(l3m), ml3r=mean(l3r) )%>%  as.data.frame()  #%>% summarise(mean_cyc=mean(cycles), mean_l3m=mean(l3m), mean_l3l=mean(l3l), sd_c=sd(cycles), sd_m=sd(l3m),sd_l=sd(l3l))
#k <- k[k$sizeb!=16,]

k <- gather(k, key="key", value="value", -size, -mem, -temp, -shuff) %>% as.data.frame()
k$aux <- paste(k$mem,k$temp,k$shuff, sep=".")
k$mem <- NULL
k$temp <- NULL
k$shuff <- NULL

lista <- k %>% group_by(key, .add = TRUE)  %>% group_split()
lista


for (t in lista) {
    a <- spread(t, aux, value)
	print(a)
	a <- a %>% mutate_if(is.factor, as.character)
	a <- a %>% mutate_if(is.integer, as.character)
	counter = a$key[1]
	#a <- select (a, -c(key))
	a <- select (a, -c(key,size))
	#write.table(a, paste0("exportables/",counter, sep=""), row.names=FALSE, col.names=TRUE, sep=" ")
	write.table(a, paste0("exportables/",counter, sep=""), row.names=FALSE, col.names=FALSE, sep=" ")
}
