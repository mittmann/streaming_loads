require(DoE.base);
scenario <- fac.design (
         nfactors=3,
         replications=20,
         repeat.only=FALSE,
         blocks=1,
         randomize=TRUE,
         seed=10373,
         nlevels=c(length(seq(1,15)),4,2),
         factor.names=list(
              size=seq(1,15),
              overhead=c(0,5,10,50),
              temp=c("n","t")
         ));

export.design(scenario,
              path=".",
              filename="doe",
              type="csv",
              replace=TRUE,
              );
