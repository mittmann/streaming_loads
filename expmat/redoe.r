require(DoE.base);
library(DoE.wrapper);
library(dplyr)
scenario <- fac.design (
         nfactors=3,
         replications=20,
         repeat.only=FALSE,
         blocks=1,
         randomize=TRUE,
         seed=10373,
         nlevels=c(length(seq(5,8)),length(seq(0,14)),2),
         factor.names=list(
              sizea=seq(5,8),
              sizeb=seq(0,14),
              temp=c("naooo","tt")
         )) ;

export.design(scenario,
              path=".",
              filename="doe",
              type="csv",
              replace=TRUE,
              );
