require(DoE.base);
scenario <- fac.design (
         nfactors=3,
         replications=50,
         repeat.only=FALSE,
         blocks=1,
         randomize=TRUE,
         seed=10373,
         nlevels=c(length(seq(1,14)),7,2),
         factor.names=list(
              size=seq(1,14),
              overhead=c(0,1,2,4,8,16,32),
              temp=c("n","t")
         ));

export.design(scenario,
              path=".",
              filename="doe",
              type="csv",
              replace=TRUE,
              );
