require(DoE.base);
#library(DoE.wrapper);
#library(dplyr)
scenario <- fac.design (
         nfactors=2,
         replications=50,
         repeat.only=FALSE,
         blocks=1,
         randomize=TRUE,
         seed=10373,
         nlevels=c(length(seq(0,14)),3),
         factor.names=list(
              size=seq(0,14),
              temp=c("n","t","e")
         )) ;

export.design(scenario,
              path=".",
              filename="doe",
              type="csv",
              replace=TRUE,
              );
