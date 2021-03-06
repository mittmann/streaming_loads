require(DoE.base);
library(DoE.wrapper);
library(dplyr)
scenario <- fac.design (
         nfactors=3,
         replications=50,
         repeat.only=FALSE,
         blocks=1,
         randomize=TRUE,
         seed=10373,
         nlevels=c(length(seq(1,14)),length(seq(0,14)),4),
         factor.names=list(
              sizea=seq(1,14),
              sizeb=seq(0,14),
              temp=c("nn","nt","tn","tt")
         )) ;

scenario$sizea <- as.numeric(as.character(scenario$sizea))
scenario$sizeb <- as.numeric(as.character(scenario$sizeb))
scenario <- scenario[scenario$sizea>=scenario$sizeb,]
scenario <- scenario %>% Dopt.design(nruns=nrow(scenario))

scenario$sizea <- as.factor(as.character(scenario$sizea))
scenario$sizeb <- as.factor(as.character(scenario$sizeb))
export.design(scenario,
              path=".",
              filename="doe",
              type="csv",
              replace=TRUE,
              );
