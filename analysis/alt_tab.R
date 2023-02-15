###############
## Power plot for alt sims
###############

library(tidyverse)
library(xtable)
paramdf <- readRDS("./output/alt/sims_alt.RDS")

alpha <- 0.01
paramdf %>%
  select(-seed) %>%
  rename(Exact = exact_pval,
         LRT = like_pval,
         `Chi-squared` = chisqr_pval,
         SLRT = splitlrt_pval,
         q = p) %>%
  mutate(q = as.character(q),
         q = str_remove(q, "^c")) %>%
  pivot_longer(cols = c("Chi-squared", "LRT", "Exact", "SLRT"),
               names_to = "Method",
               values_to = "pval") %>%
  mutate(Method = parse_factor(Method, levels = c("Chi-squared", "LRT", "Exact", "SLRT"))) %>%
  group_by(q, n, Method) %>%
  summarize(t1e = mean(pval < alpha)) %>%
  ungroup() %>%
  pivot_wider(names_from = Method, values_from = t1e) %>%
  xtable(digits = c(0, 0, 0, rep(2, 4)),
         label = "tab:power",
         caption = "Power for the four tests considered in this thesis at significance level $\\alpha = 0.01$. Higher values are better since the alternative is true.") %>%
  print(include.rownames = FALSE) %>%
  writeLines(con = "./output/alt/alt_tab.txt")
