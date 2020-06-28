require(DoE.base);
#library(DoE.wrapper);
#library(dplyr)
scenario <- fac.design (
         nfactors=4,
         replications=30,
         repeat.only=FALSE,
         blocks=1,
         randomize=TRUE,
         seed=10373,
         nlevels=c(length(seq(0,9)),3,2,2),
         factor.names=list(
              size=seq(0,9),
              temp=c("n","t","e"),
			  mem=c("wb","wc"),
			  shuff=c("seq","shuffle")
         )) ;

export.design(scenario,
              path=".",
              filename="doe",
              type="csv",
              replace=TRUE,
              );
