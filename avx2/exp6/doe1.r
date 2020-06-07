require(DoE.base);
library(DoE.wrapper);
library(dplyr)
scenario <- fac.design (
         nfactors=2,
         replications=40,
         repeat.only=FALSE,
         blocks=1,
         randomize=TRUE,
         seed=10373,
         nlevels=c(length(seq(4,17)),2),
         factor.names=list(
              sizea=seq(4,17),
              temp=c("tt","nt")
         )) ;

export.design(scenario,
              path=".",
              filename="doe",
              type="csv",
              replace=TRUE,
              );
