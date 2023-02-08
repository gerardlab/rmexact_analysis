#Null Simulation study with Sturg Data
library(rmexact)

realdata <- readRDS("../sturg/nmat_updog.RDS")
realdata <- as.data.frame.matrix(realdata)
colnames(realdata) <- c('V1','V2','V3','V4', 'V5')
realdata$exact_pval <- NA 
realdata$like_pval <- NA
realdata$chisqr_pval <- NA
realdata$splitlrt_pval <- NA


for(i in seq_len(nrow(realdata))) {
  result <- c(realdata$V1[[i]], realdata$V2[[i]], realdata$V3[[i]], realdata$V4[[i]], realdata$V5[[i]])
  realdata$chisqr_pval[[i]] <- rmexact::rmchisq(nvec = as.vector(result))
  realdata$exact_pval[[i]] <- rmexact::tetexact(y = result, log_p = FALSE)
  realdata$like_pval[[i]] <- hwep::rmlike(nvec = as.vector(result))$p_rm
  realdata$splitlrt_pval[[i]] <- rmexact::rmslrt(nvec = result, sprop = 0.5)$pval
}
saveRDS(object = realdata, file = "../sims_realdata.RDS")

