library(dplyr);
#library(ggplot2);
library(tidyr);
args = commandArgs(trailingOnly=TRUE)
df <- read.csv(args[1]);

k <- df %>% select(size,temp,overhead,cyca,l3ma,l3ra,repsb) %>% 
 #group_by(size,overhead,temp) %>% summarise(mcyca=median(cyca), ml3ma=median(l3ma), ml3ra=median(l3ra), mrepsb=median(repsb) ) %>%  as.data.frame()  #%>% summarise(mean_cyc=mean(cycles), mean_l3m=mean(l3m), mean_l3l=mean(l3l), sd_c=sd(cycles), sd_m=sd(l3m),sd_l=sd(l3l))
 #group_by(size,overhead,temp) %>% summarise(mcyca=min(cyca), ml3ma=min(l3ma), ml3ra=min(l3ra), mrepsb=min(repsb) ) %>%  as.data.frame()  #%>% summarise(mean_cyc=mean(cycles), mean_l3m=mean(l3m), mean_l3l=mean(l3l), sd_c=sd(cycles), sd_m=sd(l3m),sd_l=sd(l3l))
 #group_by(size,overhead,temp) %>% summarise(mcyca=mean(cyca), ml3ma=mean(l3ma), ml3ra=mean(l3ra), mrepsb=mean(repsb) ) %>%  as.data.frame()  #%>% summarise(mean_cyc=mean(cycles), mean_l3m=mean(l3m), mean_l3l=mean(l3l), sd_c=sd(cycles), sd_m=sd(l3m),sd_l=sd(l3l))
 group_by(size,overhead,temp) %>% summarise(mcyca=max(cyca), ml3ma=max(l3ma), ml3ra=max(l3ra), mrepsb=max(repsb) ) %>%  as.data.frame()  #%>% summarise(mean_cyc=mean(cycles), mean_l3m=mean(l3m), mean_l3l=mean(l3l), sd_c=sd(cycles), sd_m=sd(l3m),sd_l=sd(l3l))

#head(k)
#k <- gather(k, cyca,l3ma,l3ra,cycb,l3rb,l3mb) #%>% as.data.frame()
#k <- subset(k, select = c(-cyca,-l3ra, -l3ma, -cycb, -l3rb, -l3mb))
k <- gather(k, key="key", value="value", -size, -overhead, -temp) %>% as.data.frame()
head(k)

lista <- k %>% group_by(temp, key, add = TRUE) %>% group_split(value)
head(lista)
#lista
#lista
for (t in lista) {
	#print (t)
    a <- spread(t, overhead, value)
#	print(a)
	#a <- a %>% mutate_if(is.factor, as.character)
	#a <- a %>% mutate_if(is.integer, as.character)
#	print(a)
	counter = a$key[1]
	temp = a$temp[1] 
	a <- select (a, -c(temp, key,size))
	write.table(a, paste0("exportables/max/",counter,temp, sep=""), row.names=FALSE, col.names=FALSE, sep=" ")
}

#lista

quit()

      write.csv(k, args[2]) 
