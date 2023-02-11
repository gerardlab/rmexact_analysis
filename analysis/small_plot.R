#QQ plots from Small Sample Simulation study
library(tidyverse)
library(rmexact)

sims_samp1 <- readRDS("./output/small/sims_samp1.RDS")
sims_samp2 <- readRDS("./output/small/sims_samp2.RDS")

#Exact pval
ggplot(sims_samp1) +
  geom_histogram(aes(x = exact_pval), breaks = seq(0, 1, 0.05),
                 color = "black", fill = "grey") +
  scale_y_continuous(expand = expansion(c(0, 0.05))) +
  ggtitle("Exact P-value for small samples") +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  xlab("P-values") +
  ylab("Count") -> smallexacthist1

ggplot(sims_samp2) +
  geom_histogram(aes(x = exact_pval), breaks = seq(0, 1, 0.05),
                 color = "black", fill = "grey") +
  scale_y_continuous(expand = expansion(c(0, 0.05))) +
  ggtitle("Exact P-value for small samples") +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  xlab("P-values") +
  ylab("Count") -> smallexacthist2

#Like Pval
ggplot(sims_samp1) +
  geom_histogram(aes(x = like_pval), breaks = seq(0, 1, 0.05),
                 color = "black", fill = "grey") +
  scale_y_continuous(expand = expansion(c(0, 0.05))) +
  ggtitle("Likelihood P-value for small samples") +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  xlab("P-values") +
  ylab("Count") -> smalllikehist1

ggplot(sims_samp2) +
  geom_histogram(aes(x = like_pval), breaks = seq(0, 1, 0.05),
                 color = "black", fill = "grey") +
  scale_y_continuous(expand = expansion(c(0, 0.05))) +
  ggtitle("Likelihood P-value for small samples") +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  xlab("P-values") +
  ylab("Count") -> smalllikehist2

#Chisqr
ggplot(sims_samp1) +
  geom_histogram(aes(x = chisqr_pval), breaks = seq(0, 1, 0.05),
                 color = "black", fill = "grey") +
  scale_y_continuous(expand = expansion(c(0, 0.05))) +
  ggtitle("Chi-squared P-value for small samples") +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  xlab("P-values") +
  ylab("Count") -> smallchisqrhist1

ggplot(sims_samp2) +
  geom_histogram(aes(x = chisqr_pval), breaks = seq(0, 1, 0.05),
                 color = "black", fill = "grey") +
  scale_y_continuous(expand = expansion(c(0, 0.05))) +
  ggtitle("Chi-Squared P-value for small samples") +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  xlab("P-values") +
  ylab("Count") -> smallchisqrhist2


#Split
ggplot(sims_samp1) +
  geom_histogram(aes(x = splitlrt_pval), breaks = seq(0, 1, 0.05),
                 color = "black", fill = "grey") +
  scale_y_continuous(expand = expansion(c(0, 0.05))) +
  ggtitle("Split Likelihood P-value for small samples") +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  xlab("P-values") +
  ylab("Count") -> smallsplitlrthist1

ggplot(sims_samp2) +
  geom_histogram(aes(x = splitlrt_pval), breaks = seq(0, 1, 0.05),
                 color = "black", fill = "grey") +
  scale_y_continuous(expand = expansion(c(0, 0.05))) +
  ggtitle("Split Likelihood P-value for small samples") +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) +
  xlab("P-values") +
  ylab("Count") -> smallsplitlrthist2

#PDF
ggsave(filename = "./output/small/smallexact1.pdf", plot = smallexacthist1, height = 6, width = 6, family = "Times")
ggsave(filename = "./output/small/smallexact2.pdf", plot = smallexacthist2, height = 6, width = 6, family = "Times")
ggsave(filename = "./output/small/smalllike1.pdf", plot = smalllikehist1, height = 6, width = 6, family = "Times")
ggsave(filename = "./output/small/smalllike2.pdf", plot = smalllikehist2, height = 6, width = 6, family = "Times")
ggsave(filename = "./output/small/smallchisqr1.pdf", plot = smallchisqrhist1, height = 6, width = 6, family = "Times")
ggsave(filename = "./output/small/smallchisqr2.pdf", plot = smallchisqrhist2, height = 6, width = 6, family = "Times")
ggsave(filename = "./output/small/smallsplitlrt1.pdf", plot = smallsplitlrthist1, height = 6, width = 6, family = "Times")
ggsave(filename = "./output/small/smallsplitlrt2.pdf", plot = smallsplitlrthist2, height = 8, width = 6, family = "Times")
