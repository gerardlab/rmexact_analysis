#QQ plots from Null Simulation study with Sturg Data
library(tidyverse)
library(ggplot2)
library(tidyr)

realdata <- readRDS("./output/sturg/sims_realdata.RDS")

realdata %>%
  select(Exact = exact_pval, LRT = like_pval, `Chi-squared` = chisqr_pval, SLRT = splitlrt_pval) %>%
  pivot_longer(cols = everything(), names_to = "Method", values_to = "P-value") %>%
  mutate(Method = parse_factor(Method, levels = c("Chi-squared", "LRT", "Exact", "SLRT"))) %>%
  ggplot(aes(sample = `P-value`)) +
  geom_qq(distribution = stats::qunif) +
  geom_abline(slope = 1, intercept = 0) +
  facet_wrap(.~Method) +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  theme(text = element_text(size = 17)) + 
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") -> pl

ggsave(filename = "./output/sturg/real_qq.pdf", plot = pl, height = 5, width = 5)
