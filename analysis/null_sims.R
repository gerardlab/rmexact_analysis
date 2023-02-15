library(rmexact)
plist <- list(c(0.333, 0.333, 0.333),
              c(0, 1, 0),
              c(1/2, 0, 1/2),
              c(0.1, 0.3, 0.6))

nvec <- c(10, 100, 1000)
seedvec <- seq_len(1000)
paramdf <- expand.grid(p = plist,
                       n = nvec,
                       seed = seedvec)
paramdf$exact_pval <- NA
paramdf$like_pval <- NA
paramdf$chisqr_pval <- NA
paramdf$splitlrt_pval <- NA

for(i in seq_len(nrow(paramdf))) {
  set.seed(paramdf$seed[[i]])
  p <- paramdf$p[[i]]
  n <- paramdf$n[[i]]
  freq <- rmexact::gfreq(pvec = p)
  result <- c(rmultinom(n = 1, size = n, prob = freq))
  paramdf$exact_pval[[i]] <- rmexact::tetexact(y = result, log_p = FALSE)
  paramdf$like_pval[[i]] <- hwep::rmlike(nvec = as.vector(result))$p_rm
  paramdf$chisqr_pval[[i]] <- rmexact::rmchisq(nvec = as.vector(result))
  paramdf$splitlrt_pval[[i]] <- rmexact::rmslrt(nvec = result, sprop = 0.5)$pval
}

saveRDS(object = paramdf, file = "./output/null/sims_out.RDS")

#Save this table since it has all the type I error
library(tidyr)
paramdf %>%
  dplyr::select(-seed) %>%
  dplyr::mutate(p = purrr::map_chr(p, ~paste0(., collapse = ","))) %>%
  tidyr::gather(-p, -n, key = "method", value = "pval") %>%
  dplyr::group_by(p, n, method) %>%
  dplyr::summarize(t1e = mean(pval < 0.05, na.rm = TRUE)) %>%
  print(n = 60) -> paramdftype1

saveRDS(object = paramdftype1, file = "./output/null/sims_outtype1.RDS")

