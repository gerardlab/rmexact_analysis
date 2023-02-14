#QQ plots from Null Simulation study with Sturg Data
library(tidyverse)
library(ggplot2)
library(tidyr)

realdata <- readRDS("./output/sturg/sims_realdata.RDS")


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
ggsave(filename = "./output/sturg/exactdata.pdf", plot = exactplotrealdata, height = 6, width = 6, family = "Times")

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
ggsave(filename = "./output/sturg/likedata.pdf", plot = likeplotrealdata, height = 6, width = 6, family = "Times")

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
ggsave(filename = "./output/sturg/chisqrdata.pdf", plot = chisqrplotrealdata, height = 6, width = 6, family = "Times")

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

realdata %>%
  ggplot(mapping = aes(sample = splitlrt_pval)) +
  geom_qq(distribution = stats::qunif) +
  facet_grid()
  geom_abline() +
  ggtitle("Split Likelihood P-value") +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  xlab("Theoretical Quantiles") +
  ylab("Observed P-values")
  

##All QQplots 
extractedexactpval <- realdata$exact_pval 
extractedchisqrpval <- realdata$chisqr_pval
extractedlikelihoodpval <- realdata$like_pval
extractedsplitlrtpval <- realdata$splitlrt_pval

newtab <- expand.grid(tests = "exactpvalue",
                        values = extractedexactpval)
newtab2 <- expand.grid(tests = "chisqrpvalue",
                       values = extractedchisqrpval)
newtab3 <- expand.grid(tests = "likelihoodpvalue",
                       values = extractedlikelihoodpval)
newtab4 <- expand.grid(tests = "splitlrtpvalue",
                       values = extractedsplitlrtpval)
combinedtab <- rbind(newtab, newtab2, newtab3, newtab4)

combinedtab %>%
   ggplot(mapping = aes(sample = values)) +
   geom_qq(distribution = stats::qunif) +
   facet_wrap(~ tests) +
   geom_abline() +
   ggtitle("P-values") +
   theme_bw() +
   theme(strip.background = element_rect(fill = "white")) +
   xlab("Theoretical Quantiles") +
   ylab("Observed P-values") -> realdataplots

ggsave(filename = "./output/sturg/realdataplots.pdf", plot = realdataplots, height = 6, width = 6, family = "Times")

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

ggsave(filename = "./output/sturg/splitlrtdata.pdf", plot = splitlrtplotrealdata, height = 6, width = 6, family = "Times")
