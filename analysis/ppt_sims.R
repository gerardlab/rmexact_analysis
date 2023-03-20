#QQ plots for PowerPoint
library(tidyverse)

paramdf0 <- readRDS("./output/alt/sims_alt.RDS")
paramdf <- readRDS("./output/null/sims_out.RDS")


paramdf0$chisqr_pval
#For the PowerPoint Presentation
paramdf0 %>%
  dplyr::select(p, chisqr_pval, n) %>%
  dplyr::filter(p == "c(0.1, 0.1, 0.2, 0.3, 0.3)") %>%
  dplyr::mutate(p2 = as.character(p)) %>%
  mutate(p2 = str_remove(p2, "^c")) %>%
  ggplot2::ggplot(mapping = aes(sample = chisqr_pval)) +
  ggplot2::geom_qq(distribution = stats::qunif) +
  ggplot2::facet_grid(p2 ~ n) +
  ggplot2::geom_abline() +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  theme(text = element_text(size = 17)) + 
  coord_cartesian(xlim = c(0.001, 1), ylim = c(0.001, 1)) +
  ggtitle("Alternative Sims, Chi-squared Test") +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") -> PPTchisqralt

paramdf0 %>%
  dplyr::select(p, exact_pval, n) %>%
  dplyr::filter(p == "c(0.1, 0.1, 0.2, 0.3, 0.3)") %>%
  dplyr::mutate(p2 = as.character(p)) %>%
  mutate(p2 = str_remove(p2, "^c")) %>%
  ggplot2::ggplot(mapping = aes(sample = exact_pval))+
  ggplot2::geom_qq(distribution = stats::qunif) +
  ggplot2::facet_grid(p2 ~ n) +
  ggplot2::geom_abline() +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  theme(text = element_text(size = 17)) + 
  coord_cartesian(xlim = c(0.001, 1), ylim = c(0.001, 1)) +
  ggtitle("Alternative Sims, Exact Test") +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") -> PPTexactalt

paramdf0 %>%
  dplyr::select(p, like_pval, n) %>%
  dplyr::filter(p == "c(0.1, 0.1, 0.2, 0.3, 0.3)") %>%
  dplyr::mutate(p2 = as.character(p)) %>%
  mutate(p2 = str_remove(p2, "^c")) %>%
  ggplot2::ggplot(mapping = aes(sample = like_pval))+
  ggplot2::geom_qq(distribution = stats::qunif) +
  ggplot2::facet_grid(p2 ~ n) +
  ggplot2::geom_abline() +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  theme(text = element_text(size = 17)) + 
  coord_cartesian(xlim = c(0.001, 1), ylim = c(0.001, 1)) +
  ggtitle("Alternative Sims, Likelihood Ratio Test") +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") -> PPTlikealt

paramdf0 %>%
  select(p, splitlrt_pval, n) %>%
  dplyr::filter(p == "c(0.1, 0.1, 0.2, 0.3, 0.3)") %>%
  dplyr::mutate(p2 = as.character(p)) %>%
  mutate(p2 = str_remove(p2, "^c")) %>%
  ggplot2::ggplot(mapping = aes(sample = splitlrt_pval))+
  ggplot2::geom_qq(distribution = stats::qunif) +
  ggplot2::facet_grid(p2 ~ n) +
  ggplot2::geom_abline() +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  theme(text = element_text(size = 17)) + 
  coord_cartesian(xlim = c(0.001, 1), ylim = c(0.001, 1)) +
  ggtitle("Alternative Sims, Split Likelihood Ratio Test") +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") -> PPTsplitlrtalt

#Null plots
paramdf %>%
  select(p, chisqr_pval, n) %>%
  dplyr::filter(p == "c(0.1, 0.1, 0.2, 0.3, 0.3)") %>%
  dplyr::mutate(p2 = as.character(p)) %>%
  mutate(p2 = str_remove(p2, "^c")) %>%
  ggplot2::ggplot(mapping = aes(sample = chisqr_pval))+
  ggplot2::geom_qq(distribution = stats::qunif) +
  ggplot2::facet_grid(p2 ~ n) +
  ggplot2::geom_abline() +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  theme(text = element_text(size = 17)) + 
  coord_cartesian(xlim = c(0.1, 1), ylim = c(0.1, 1)) +
  ggtitle("Null Sims, Chi-squared Test") +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") -> PPTchisqrnull

paramdf %>%
  select(p, exact_pval, n) %>%
  dplyr::filter(p == "c(0.1, 0.3, 0.6)") %>%
  dplyr::mutate(p2 = as.character(p)) %>%
  mutate(p2 = str_remove(p2, "^c")) %>%
  ggplot2::ggplot(mapping = aes(sample = exact_pval))+
  ggplot2::geom_qq(distribution = stats::qunif) +
  ggplot2::facet_grid(p2 ~ n) +
  ggplot2::geom_abline() +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  theme(text = element_text(size = 17)) + 
  coord_cartesian(xlim = c(0.1, 1), ylim = c(0.1, 1)) +
  ggtitle("Null Sims, Exact Test") +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") -> PPTexactnull

paramdf %>%
  select(p, like_pval, n) %>%
  dplyr::filter(p == "c(0.1, 0.3, 0.6)") %>%
  dplyr::mutate(p2 = as.character(p)) %>%
  mutate(p2 = str_remove(p2, "^c")) %>%
  ggplot2::ggplot(mapping = aes(sample = like_pval))+
  ggplot2::geom_qq(distribution = stats::qunif) +
  ggplot2::facet_grid(p2 ~ n) +
  ggplot2::geom_abline() +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  theme(text = element_text(size = 17)) + 
  coord_cartesian(xlim = c(0.1, 1), ylim = c(0.1, 1)) +
  ggtitle("Null Sims, Likelihood Ratio Test") +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") -> PPTlikenull

paramdf %>%
  select(p, splitlrt_pval, n) %>%
  dplyr::filter(p == "c(0.1, 0.3, 0.6)") %>%
  dplyr::mutate(p2 = as.character(p)) %>%
  mutate(p2 = str_remove(p2, "^c")) %>%
  ggplot2::ggplot(mapping = aes(sample = splitlrt_pval))+
  ggplot2::geom_qq(distribution = stats::qunif) +
  ggplot2::facet_grid(p2 ~ n) +
  ggplot2::geom_abline() +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  theme(text = element_text(size = 17)) + 
  coord_cartesian(xlim = c(0.1, 1), ylim = c(0.1, 1)) +
  ggtitle("Null Sims, Split Likelihood Ratio Test") +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values") -> PPTsplitlrtnull


ggsave(filename = "./output/alt/exact_alt.pdf", plot = PPTexact, height = 6, width = 6, family = "Times")
ggsave(filename = "./output/alt/exact_alt.pdf", plot = PPTchisqr, height = 6, width = 6, family = "Times")