nc = 4
rexec = R CMD BATCH --no-save --no-restore

null_plots = ./output/null/exact_null.pdf \
             ./output/null/likelihood_null.pdf \
             ./output/null/chi_null.pdf \
             ./output/null/slrt_null.pdf

alt_plots = ./output/alt/exact_alt.pdf \
            ./output/alt/likelihood_alt.pdf \
            ./output/alt/chisqr_alt.pdf \
            ./output/alt/split_alt.pdf

.PHONY : all
all : sturg alt_sims null_sims small

## Real Data Analysis ----------------------------------------------

.PHONY : sturg
sturg : ./output/sturg/real_qq.pdf

./data/sturg/8n_12n_sturgeon_readCounts.rda :
	mkdir -p ./data/sturg
	wget --directory-prefix=data/sturg --no-clobber https://datadryad.org/stash/downloads/file_stream/711273
	mv ./data/sturg/711273 ./data/sturg/8n_12n_sturgeon_readCounts.rda

./output/sturg/nmat_updog.RDS : ./analysis/real_nmat.R ./data/sturg/8n_12n_sturgeon_readCounts.rda
	mkdir -p ./output/rout
	mkdir -p ./output/sturg
	$(rexec) '--args nc=$(nc)' $< ./output/rout/$(basename $(notdir $<)).Rout

./output/sturg/sims_realdata.RDS : ./analysis/real_fit.R ./output/sturg/nmat_updog.RDS
	mkdir -p ./output/rout
	mkdir -p ./output/sturg
	$(rexec) $< ./output/rout/$(basename $(notdir $<)).Rout

./output/sturg/real_qq.pdf : ./analysis/real_plot.R ./output/sturg/sims_realdata.RDS
	mkdir -p ./output/rout
	mkdir -p ./output/sturg
	$(rexec) $< ./output/rout/$(basename $(notdir $<)).Rout

## Null Sims Analysis ----------------------------------------------

.PHONY : null_sims
null_sims : $(null_plots) ./output/null/null_tab.txt

./output/null/sims_out.RDS ./output/null/sims_outtype1.RDS : ./analysis/null_sims.R
	mkdir -p ./output/rout
	mkdir -p ./output/null
	$(rexec) $< ./output/rout/$(basename $(notdir $<)).Rout

$(null_plots) : ./analysis/null_plot.R ./output/null/sims_out.RDS
	mkdir -p ./output/rout
	mkdir -p ./output/null
	$(rexec) $< ./output/rout/$(basename $(notdir $<)).Rout

./output/null/null_tab.txt : ./analysis/null_tab.R ./output/null/sims_out.RDS
	mkdir -p ./output/rout
	mkdir -p ./output/null
	$(rexec) $< ./output/rout/$(basename $(notdir $<)).Rout

## Alt Sims Analysis ----------------------------------------------

.PHONY: alt_sims
alt_sims : $(alt_plots) ./output/alt/alt_tab.txt

./output/alt/sims_alt.RDS : ./analysis/alt_sims.R
	mkdir -p ./output/rout
	mkdir -p ./output/alt
	$(rexec) $< ./output/rout/$(basename $(notdir $<)).Rout

$(alt_plots) : ./analysis/alt_plot.R ./output/alt/sims_alt.RDS
	mkdir -p ./output/rout
	mkdir -p ./output/alt
	$(rexec) $< ./output/rout/$(basename $(notdir $<)).Rout

./output/alt/alt_tab.txt : ./analysis/alt_tab.R ./output/alt/sims_alt.RDS
	mkdir -p ./output/rout
	mkdir -p ./output/alt
	$(rexec) $< ./output/rout/$(basename $(notdir $<)).Rout

## Small Sample Size Data Analysis --------------------------------

.PHONY: small
small : ./output/small/small_hist.pdf

./output/small/sims_samp1.RDS ./output/small/sims_samp2.RDS : ./analysis/small_sims.R
	mkdir -p ./output/rout
	mkdir -p ./output/small
	$(rexec) $< ./output/rout/$(basename $(notdir $<)).Rout

./output/small/small_hist.pdf : ./analysis/small_plot.R ./output/small/sims_samp1.RDS ./output/small/sims_samp2.RDS
	mkdir -p ./output/rout
	mkdir -p ./output/small
	$(rexec) $< ./output/rout/$(basename $(notdir $<)).Rout
