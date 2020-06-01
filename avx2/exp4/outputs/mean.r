library(dplyr);
library(ggplot2);
library(tidyr);
args = commandArgs(trailingOnly=TRUE)
df <- read.csv(args[1]);

k <- df %>% select(sizea,sizeb,tempb,cyca,l3ma,l3ra,cycb,l3mb,l3rb) %>% 
 group_by(sizea,sizeb,tempb) %>% as.data.frame()  #%>% summarise(mean_cyc=mean(cycles), mean_l3m=mean(l3m), mean_l3l=mean(l3l), sd_c=sd(cycles), sd_m=sd(l3m),sd_l=sd(l3l))

#head(k)
#k <- gather(k, cyca,l3ma,l3ra,cycb,l3rb,l3mb) #%>% as.data.frame()
k <- gather(k, key="key", value="value", -sizea, -sizeb, -tempb) %>% as.data.frame()

lista <- k %>% group_by(tempb, key, add = TRUE) %>% group_split(value)
#lista
#lista
for (t in lista) {
	#print (t)
    a <- spread(t, sizeb, value)
	#print(a)
	a <- a %>% mutate_if(is.factor, as.character)
	a <- a %>% mutate_if(is.integer, as.character)
	counter = a$key[1]
	temp = a$tempb[1] 
	a <- select (a, -c(tempb, key))
	write.table(a, paste0("exportables/names/",counter,temp, sep=""), row.names=FALSE, col.names=TRUE, sep=" ")
}

#lista

quit()

      write.csv(k, args[2]) 
