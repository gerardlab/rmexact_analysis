#QQ plots from Null Simulation study
library(tidyverse)
library(rmexact)

paramdf <- readRDS("./output/null/sims_out.RDS")

#Exact pval
paramdf %>%
  dplyr::mutate(p2 = as.character(p)) %>%
  mutate(p2 = str_remove(p2, "^c")) %>%
  ggplot(mapping = aes(sample = exact_pval))+
  geom_qq(distribution = stats::qunif) +
  facet_grid(p2 ~ n) +
  geom_abline() +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") +
  scale_x_log10() +
  scale_y_log10() ->
  exactplot

ggsave(filename = "./output/null/exact_null.pdf", plot = exactplot, height = 6, width = 6, family = "Times")

#Likelihood P-values
paramdf %>%
  dplyr::mutate(p2 = as.character(p)) %>%
  mutate(p2 = str_remove(p2, "^c")) %>%
  ggplot(mapping = aes(sample = like_pval))+
  geom_qq(distribution = stats::qunif) +
  facet_grid(p2 ~ n) +
  geom_abline() +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") +
  scale_x_log10() +
  scale_y_log10() ->
  lrtplot


ggsave(filename = "./output/null/likelihood_null.pdf", plot = lrtplot, height = 6, width = 6, family = "Times")

#Chi-squared P-values
paramdf %>%
  dplyr::mutate(p2 = as.character(p)) %>%
  mutate(p2 = str_remove(p2, "^c")) %>%
  ggplot(mapping = aes(sample = chisqr_pval))+
  geom_qq(distribution = stats::qunif) +
  facet_grid(p2 ~ n) +
  geom_abline() +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") +
  scale_x_log10() +
  scale_y_log10() ->
  chisqrplot

ggsave(filename = "./output/null/chi_null.pdf", plot = chisqrplot, height = 6, width = 6, family = "Times")

#Split Likelihood Ratio Test
paramdf %>%
  dplyr::mutate(p2 = as.character(p)) %>%
  mutate(p2 = str_remove(p2, "^c")) %>%
  ggplot(mapping = aes(sample = splitlrt_pval))+
  geom_qq(distribution = stats::qunif) +
  facet_grid(p2 ~ n) +
  geom_abline() +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") +
  scale_x_log10() +
  scale_y_log10() ->
  splitplot

ggsave(filename = "./output/null/slrt_null.pdf", plot = splitplot, height = 6, width = 6, family = "Times")
