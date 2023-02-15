################
## Table of Type I error under null
################

library(tidyverse)
library(xtable)
paramdf <- readRDS("./output/null/sims_out.RDS")

alpha <- 0.01
paramdf %>%
  select(-seed) %>%
  rename(Exact = exact_pval,
         LRT = like_pval,
         `Chi-squared` = chisqr_pval,
         SLRT = splitlrt_pval) %>%
  mutate(p = as.character(p),
         p = str_remove(p, "^c")) %>%
  pivot_longer(cols = c("Chi-squared", "LRT", "Exact", "SLRT"),
               names_to = "Method",
               values_to = "pval") %>%
  group_by(p, n, Method) %>%
  summarize(t1e = mean(pval < alpha)) %>%
  ungroup() %>%
  pivot_wider(names_from = Method, values_from = t1e) %>%
  xtable(digits = c(0, 0, 0, rep(2, 4)),
         label = "tab:t1e",
         caption = "Type I error at significance level $\\alpha = 0.01$ for four tests considered in this thesis for different gamete frequencies and different sample sizes. Since the null is satisfied, all values should be at or below 0.01.") %>%
  print(include.rownames = FALSE) %>%
  writeLines(con = "./output/null/null_tab.txt")
