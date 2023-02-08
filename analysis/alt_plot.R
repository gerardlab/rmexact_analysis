#QQ plots from Alternative simulation 
library(tidyverse)
library(ggplot2)
library(tidyr)

paramdf0 <- readRDS("../output/sims_alt.RDS")

#Exact pvalue
paramdf0 %>%
  dplyr::mutate(p2 = as.character(p)) %>%
  ggplot2::ggplot(mapping = aes(sample = exact_pval))+
  ggplot2::geom_qq(distribution = stats::qunif) +
  ggplot2::facet_grid(p2 ~ n) +
  ggplot2::geom_abline() +
  ggplot2::ggtitle("Exact P-value under Alternative Hypothesis") +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  coord_cartesian(xlim = c(0.0001, 1), ylim = c(0.0001, 1)) +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") -> exactplot2

ggsave(filename = "exact_alt.pdf", plot = exactplot2, height = 6, width = 6, family = "Times")

#Likelihood Pvalue
paramdf0 %>%
  dplyr::mutate(p2 = as.character(p)) %>%
  ggplot2::ggplot(mapping = aes(sample = like_pval))+
  ggplot2::geom_qq(distribution = stats::qunif) +
  ggplot2::facet_grid(p2 ~ n) +
  ggplot2::geom_abline() +
  ggplot2::ggtitle("Likelihood P-value under Alternative Hypothesis") +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  coord_cartesian(xlim = c(0.0001, 1), ylim = c(0.0001, 1)) +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") -> lrtplot2

ggsave(filename = "likelihood_alt.pdf", plot = lrtplot2, height = 6, width = 6, family = "Times")

#Chi-squared P-values
paramdf0 %>%
  dplyr::mutate(p2 = as.character(p)) %>%
  ggplot(mapping = aes(sample = chisqr_pval))+
  geom_qq(distribution = stats::qunif) +
  facet_grid(p2 ~ n) +
  geom_abline() +
  ggtitle("Chi-squared P-value under Alternative Hypothesis ") +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  coord_cartesian(xlim = c(0.0001, 1), ylim = c(0.0001, 1)) +
  labs(x = "Theoretical Quantiles", y = "Observed P-values") -> chisqrplot2

ggsave(filename = "chisqr_alt.pdf", plot = chisqrplot2, height = 6, width = 6, family = "Times")

#Split P-values
paramdf0 %>%
  dplyr::mutate(p2 = as.character(p)) %>%
  ggplot(mapping = aes(sample = splitlrt_pval))+
  geom_qq(distribution = stats::qunif) +
  facet_grid(p2 ~ n) +
  geom_abline() +
  ggtitle("Split Likelihood under Alternative Hypothesis") +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") -> splitplot2

ggsave(filename = "split_alt.pdf", plot = splitplot2, height = 6, width = 6, family = "Times")

