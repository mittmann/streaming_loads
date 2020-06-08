require(DoE.base);
library(DoE.wrapper);
library(dplyr)
scenario <- fac.design (
         nfactors=3,
         replications=30,
         repeat.only=FALSE,
         blocks=1,
         randomize=TRUE,
         seed=10373,
         nlevels=c(length(seq(0,17)),length(seq(0,19)),2),
         factor.names=list(
              sizea=seq(0,17),
              sizeb=seq(0,19),
              temp=c("n","t")
         )) ;

export.design(scenario,
              path=".",
              filename="doe",
              type="csv",
              replace=TRUE,
              );
