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
  ggtitle("Exact P-value under the Null") +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") -> exactplot

ggsave(filename = "./output/null/exact_null.pdf", plot = exactplot, height = 6, width = 6, family = "Times")

#Likelihood P-values
paramdf %>%
  dplyr::mutate(p2 = as.character(p)) %>%
  mutate(p2 = str_remove(p2, "^c")) %>%
  ggplot(mapping = aes(sample = like_pval))+
  geom_qq(distribution = stats::qunif) +
  facet_grid(p2 ~ n) +
  geom_abline() +
  ggtitle("Likelihood P-value under the Null") +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  scale_x_log10(limits = c(0.001, 1)) +
  scale_y_log10(limits = c(0.001, 1)) +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") -> lrtplot
ggsave(filename = "./output/null/likelihood_null.pdf", plot = lrtplot, height = 6, width = 6, family = "Times")

#Chi-squared P-values
paramdf %>%
  dplyr::mutate(p2 = as.character(p)) %>%
  mutate(p2 = str_remove(p2, "^c")) %>%
  ggplot(mapping = aes(sample = chisqr_pval))+
  geom_qq(distribution = stats::qunif) +
  facet_grid(p2 ~ n) +
  geom_abline() +
  ggtitle("Chi-squared P-value under the Null") +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  scale_x_log10(limits = c(0.001, 1)) +
  scale_y_log10(limits = c(0.001, 1)) +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") -> chisqrplot

ggsave(filename = "./output/null/chi_null.pdf", plot = chisqrplot, height = 6, width = 6, family = "Times")


#Split Likelihood Ratio Test
paramdf %>%
  dplyr::mutate(p2 = as.character(p)) %>%
  mutate(p2 = str_remove(p2, "^c")) %>%
  ggplot(mapping = aes(sample = splitlrt_pval))+
  geom_qq(distribution = stats::qunif) +
  facet_grid(p2 ~ n) +
  geom_abline() +
  ggtitle("Split Likelihood Ratio under the Null") +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") -> splitplot

ggsave(filename = "./output/null/slrt_null.pdf", plot = splitplot, height = 6, width = 6, family = "Times")
