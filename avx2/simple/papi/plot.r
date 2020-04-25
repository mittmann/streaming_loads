library(dplyr);
library(ggplot2);

df <- read.csv("saida.csv");


k <- df %>% select(counter,size,memtype,temp,opt,value) %>% 
    	      group_by(counter,size,memtype,temp,opt) %>% summarise(mean=mean(value), n=n(), sd=sd(value), se=sd/sqrt(n), ic=2.576*se)
      write.csv(k, "pp.csv")
      exit

k <- k[k$size=="huge",]
k <- k[k$counter=="PAPI_TOT_CYC",]

ggplot(k, aes(x=temp, y = mean)) + geom_point() + 
	geom_errorbar(aes(ymin=mean-ic, ymax=mean+ic), color="grey") +
	xlab("Versão") + ylab(k$counter) +
	#scale_y_continuous(expand = c(0,0)) +
	scale_y_continuous(trans="log10") +
	scale_fill_grey() + 
	facet_wrap(~opt+memtype) + 
	#theme_bw() +
	theme(axis.text.x = element_text(angle = 90, hjust = 1))


