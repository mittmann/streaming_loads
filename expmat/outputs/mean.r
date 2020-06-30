library(dplyr);
library(tidyr);
#library(outliers);
args = commandArgs(trailingOnly=TRUE)
df <- read.csv(args[1]);

k <- df %>% select(sizea,sizeb,temp,cyca,l3ma,l3ra,cycb,l3mb,l3rb) %>% 
 group_by(sizea,sizeb,temp) %>% summarise(mcyca=mean(cyca), ml3ma=mean(l3ma), ml3ra=mean(l3ra), mcycb=mean(cycb), ml3mb=mean(l3mb), ml3rb=mean(l3rb) ) %>%  as.data.frame()  #%>% summarise(mean_cyc=mean(cycles), mean_l3m=mean(l3m), mean_l3l=mean(l3l), sd_c=sd(cycles), sd_m=sd(l3m),sd_l=sd(l3l))
#k <- k[k$sizeb!=16,]
k2 <- k;
k2$sizea = k$sizeb;
k2$sizeb = k$sizea;
k2$mcyca = k$mcycb;
k2$mcycb = k$mcyca;
k2$ml3ra = k$ml3rb;
k2$ml3rb = k$ml3ra;
k2$ml3ma = k$ml3mb;
k2$ml3mb = k$ml3ma;

k2$temp <- replace(as.character(k2$temp), k2$temp == "nt","tmp")
k2$temp <- replace(as.character(k2$temp), k2$temp == "tn","nt")
k2$temp <- replace(as.character(k2$temp), k2$temp == "tmp","tn")
combined <- rbind(k,k2)
k <- subset( combined, select = -c(mcycb,ml3rb,ml3mb));
k <- k %>% group_by(sizea,sizeb,temp) %>% summarise( mcyca=mean(mcyca), ml3ra=mean(ml3ra), ml3ma=mean(ml3ma),);
k <- k %>% rename (cyc = mcyca, l3r = ml3ra, l3m = ml3ma)
k <- k[k$sizea!=16,]

k <- gather(k, key="key", value="value", -sizea, -sizeb, -temp) %>% as.data.frame()

lista <- k %>% group_by(temp, key, .add = TRUE)  %>% group_split()
for (t in lista) {
    a <- spread(t, sizeb, value)
	a <- a %>% mutate_if(is.factor, as.character)
	a <- a %>% mutate_if(is.integer, as.character)
	counter = a$key[1]
	temp = a$temp[1] 
	#a <- select (a, -c(temp, key))
	a <- select (a, -c(temp, key, sizea))
	#write.table(a, paste0("exportables/names/",counter,temp, sep=""), row.names=FALSE, col.names=TRUE, sep=" ")
	write.table(a, paste0("exportables/",counter,temp, sep=""), row.names=FALSE, col.names=FALSE, sep=" ")
}
