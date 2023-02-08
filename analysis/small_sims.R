#Small samples simulation
library(rmexact)

data <- as.data.frame(hwep:::all_multinom(n = 5, k = 5))
data$exact_pval <- NA 
data$like_pval <- NA
data$chisqr_pval <- NA
data$splitlrt_pval <- NA

for(i in seq_len(nrow(data))) {
  result <- c(data$V1[[i]], data$V2[[i]], data$V3[[i]], data$V4[[i]], data$V5[[i]])
  data$chisqr_pval[[i]] <- rmexact::rmchisq(nvec = as.vector(result))
  data$exact_pval[[i]] <- rmexact::tetexact(y = result, log_p = FALSE)
  data$like_pval[[i]] <- hwep::rmlike(nvec = as.vector(result))$p_rm
  data$splitlrt_pval[[i]] <- rmexact::rmslrt(nvec = result, sprop = 0.5)$pval
}

saveRDS(object = data, file = "../hwe_karene/output/sims_samp1.RDS")

data1 <- as.data.frame(hwep:::all_multinom(n = 10, k = 5))
data1$exact_pval <- NA 
data1$like_pval <- NA
data1$chisqr_pval <- NA
data1$splitlrt_pval <- NA

for(i in seq_len(nrow(data1))) {
  result <- c(data1$V1[[i]], data1$V2[[i]], data1$V3[[i]], data1$V4[[i]], data1$V5[[i]])
  data1$chisqr_pval[[i]] <- rmexact::rmchisq(nvec = as.vector(result))
  data1$exact_pval[[i]] <- rmexact::tetexact(y = result, log_p = FALSE)
  data1$like_pval[[i]] <- hwep::rmlike(nvec = as.vector(result))$p_rm
  data1$splitlrt_pval[[i]] <- rmexact::rmslrt(nvec = result, sprop = 0.5)$pval
}

saveRDS(object = data1, file = "../hwe_karene/output/sims_samp2.RDS")

