library(dplyr);
#library(ggplot2);
library(tidyr);
library(outliers);
args = commandArgs(trailingOnly=TRUE)
df <- read.csv(args[1]);

k <- df %>% select(size,cyc) %>% 
 group_by(size) %>% filter(!cyc %in% c(outlier(cyc)))  %>% summarise(mcyc=mean(cyc))  %>%  as.data.frame() 
 #group_by(size) %>% summarise(mcyc=mean(cyc))  %>%  as.data.frame() 

k
quit()
#head(k)
#k <- gather(k, cyca,l3ma,l3ra,cycb,l3rb,l3mb) #%>% as.data.frame()
#k <- subset(k, select = c(-cyca,-l3ra, -l3ma, -cycb, -l3rb, -l3mb))
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
	a <- select (a, -c(tempb, key,sizea))
	write.table(a, paste0("exportables/outlier/",counter,temp, sep=""), row.names=FALSE, col.names=FALSE, sep=" ")
}

#lista

quit()

      write.csv(k, args[2]) 
