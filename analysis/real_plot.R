#QQ plots from Null Simulation study with Sturg Data
library(tidyverse)
require(qqplotr)
library(ggplot2)
library(tidyr)

realdata <- readRDS("../output/sims_realdata.RDS")

#Exact P-values
realdata %>%
  ggplot(mapping = aes(sample = exact_pval)) +
  geom_qq(distribution = stats::qunif) +
  geom_abline() +
  ggtitle("Exact P-value") +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") -> exactplotrealdata
ggsave(filename = "exactdata.pdf", plot = exactplotrealdata, height = 6, width = 6, family = "Times")

#Likelihood P-values
realdata %>%
  ggplot(mapping = aes(sample = like_pval)) +
  geom_qq(distribution = stats::qunif) +
  geom_abline() +
  ggtitle("Likelihood P-value") +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") -> likeplotrealdata
ggsave(filename = "likedata.pdf", plot = likeplotrealdata, height = 6, width = 6, family = "Times")

#Chi-squared P-values
realdata %>%
  ggplot(mapping = aes(sample = chisqr_pval)) +
  geom_qq(distribution = stats::qunif) +
  geom_abline() +
  ggtitle("Chi-squared P-value") +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") -> chisqrplotrealdata
ggsave(filename = "chisqrdata.pdf", plot = chisqrplotrealdata, height = 6, width = 6, family = "Times")

#splitlrt Pval 
realdata %>%
  ggplot(mapping = aes(sample = splitlrt_pval)) +
  geom_qq(distribution = stats::qunif) +
  geom_abline() +
  ggtitle("Split Likelihood P-value") +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") -> splitlrtplotrealdata

ggsave(filename = "splitlrtdata.pdf", plot = splitlrtplotrealdata, height = 6, width = 6, family = "Times")
