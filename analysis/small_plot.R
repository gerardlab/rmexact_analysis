#QQ plots from Small Sample Simulation study
library(tidyverse)
library(rmexact)

sims_samp1 <- readRDS("./output/small/sims_samp1.RDS")
sims_samp2 <- readRDS("./output/small/sims_samp2.RDS")

sims_samp1 %>%
  rename(y0 = V1, y1 = V2, y2 = V3, y3 = V4, y4 = V5) %>%
  mutate(n = 5) ->
  sims_samp1

sims_samp2 %>%
  rename(y0 = V1, y1 = V2, y2 = V3, y3 = V4, y4 = V5) %>%
  mutate(n = 10) ->
  sims_samp2

pardf <- bind_rows(sims_samp1, sims_samp2)

pardf %>%
  select(Exact = exact_pval,
         LRT = like_pval,
         `Chi-squared` = chisqr_pval,
         SLRT = splitlrt_pval,
         n) %>%
  pivot_longer(cols = c("Exact", "LRT", "Chi-squared", "SLRT"),
               names_to = "Method",
               values_to = "P-value") %>%
  mutate(n = str_c("n = ", n),
         n = parse_factor(n, levels = c("n = 5", "n = 10")),
         Method = parse_factor(Method, levels = c("LRT", "Chi-squared", "SLRT", "Exact"))) %>%
  ggplot(aes(x = `P-value`)) +
  geom_histogram(color = "black", fill = "grey", bins = 20) +
  facet_wrap(Method ~ n, scales = "free", ncol = 2) +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white")) ->
  pl

ggsave(filename = "./output/small/small_hist.pdf", plot = pl, height = 6, width = 5)

