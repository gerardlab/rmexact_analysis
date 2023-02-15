plist <- list(rep(0.2, 5),
              c(0.5, 0, 0, 0, 0.5),
              c(0.1, 0.2, 0.4, 0.2, 0.1),
              c(0.1, 0.1, 0.2, 0.3, 0.3))


nvec <- c(10, 100, 1000)
seedvec <- seq_len(1000)
paramdf0 <- expand.grid(p = plist,
                       n = nvec,
                       seed = seedvec)
paramdf0$exact_pval <- NA
paramdf0$like_pval <- NA
paramdf0$chisqr_pval <- NA
paramdf0$splitlrt_pval <- NA

##Simulation Study using rmexact::tetexact(general case):
for(i in seq_len(nrow(paramdf0))) {
  set.seed(paramdf0$seed[[i]])
  p <- paramdf0$p[[i]]
  n <- paramdf0$n[[i]]
  result <- c(rmultinom(n = 1, size = n, prob = p))
  paramdf0$exact_pval[[i]] <- rmexact::tetexact(y = result, log_p = FALSE)
  paramdf0$like_pval[[i]] <- hwep::rmlike(nvec = as.vector(result))$p_rm
  paramdf0$chisqr_pval[[i]] <- rmexact::rmchisq(nvec = as.vector(result))
  paramdf0$splitlrt_pval[[i]] <- rmexact::rmslrt(nvec = result, sprop = 0.5)$pval
}

saveRDS(object = paramdf0, file = "./output/alt/sims_alt.RDS")

