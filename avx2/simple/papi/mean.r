library(dplyr);
library(ggplot2);
args = commandArgs(trailingOnly=TRUE)
df <- read.csv(args[1]);

k <- df %>% select(app,displaysize,cycles,l3m,l3l) %>% 
 group_by(app,displaysize) %>% summarise(mean_cyc=mean(cycles), mean_l3m=mean(l3m), mean_l3l=mean(l3l), sd_c=sd(cycles), sd_m=sd(l3m),sd_l=sd(l3l))
      write.csv(k, args[2]) 
