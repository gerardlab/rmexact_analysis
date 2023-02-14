nc = 4
rexec = R CMD BATCH --no-save --no-restore

sturg_plots = ./output/sturg/exactdata.pdf \
              ./output/sturg/likedata.pdf \
              ./output/sturg/chisqrdata.pdf \
              ./output/sturg/realdataplots.pdf\
              ./output/sturg/splitlrtdata.pdf

null_plots = ./output/null/exact_null.pdf \
             ./output/null/likelihood_null.pdf \
             ./output/null/chi_null.pdf \
             ./output/null/slrt_null.pdf

alt_plots = ./output/alt/exact_alt.pdf \
            ./output/alt/likelihood_alt.pdf \
            ./output/alt/chisqr_alt.pdf \
            ./output/alt/split_alt.pdf

small_plots = ./output/small/smallexact1.pdf \
              ./output/small/smallexact2.pdf \
              ./output/small/smalllike1.pdf \
              ./output/small/smalllike2.pdf \
              ./output/small/smallchisqr1.pdf \
              ./output/small/smallchisqr2.pdf \
              ./output/small/smallsplitlrt1.pdf \
              ./output/small/smallsplitlrt2.pdf

.PHONY : all
all : sturg alt_sims null_sims small

## Real Data Analysis ----------------------------------------------

.PHONY : sturg
sturg : $(sturg_plots)

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

$(sturg_plots) : ./analysis/real_plot.R ./output/sturg/sims_realdata.RDS
	mkdir -p ./output/rout
	mkdir -p ./output/sturg
	$(rexec) $< ./output/rout/$(basename $(notdir $<)).Rout

## Null Sims Analysis ----------------------------------------------

.PHONY : null_sims
null_sims : $(null_plots)

./output/null/sims_out.RDS ./output/null/sims_outtype1.RDS : ./analysis/null_sims.R
	mkdir -p ./output/rout
	mkdir -p ./output/null
	$(rexec) $< ./output/rout/$(basename $(notdir $<)).Rout

$(null_plots) : ./analysis/null_plot.R ./output/null/sims_out.RDS
	mkdir -p ./output/rout
	mkdir -p ./output/null
	$(rexec) $< ./output/rout/$(basename $(notdir $<)).Rout

## Alt Sims Analysis ----------------------------------------------

.PHONY: alt_sims
alt_sims : $(alt_plots)

./output/alt/sims_alt.RDS : ./analysis/alt_sims.R
	mkdir -p ./output/rout
	mkdir -p ./output/alt
	$(rexec) $< ./output/rout/$(basename $(notdir $<)).Rout

$(alt_plots) : ./analysis/alt_plot.R ./output/alt/sims_alt.RDS
	mkdir -p ./output/rout
	mkdir -p ./output/alt
	$(rexec) $< ./output/rout/$(basename $(notdir $<)).Rout

## Small Sample Size Data Analysis --------------------------------

.PHONY: small
small : $(small_plots)

./output/small/sims_samp1.RDS ./output/small/sims_samp2.RDS : ./analysis/small_sims.R
	mkdir -p ./output/rout
	mkdir -p ./output/small
	$(rexec) $< ./output/rout/$(basename $(notdir $<)).Rout

$(small_plots) : ./analysis/small_plot.R ./output/small/sims_samp1.RDS ./output/small/sims_samp2.RDS
	mkdir -p ./output/rout
	mkdir -p ./output/small
	$(rexec) $< ./output/rout/$(basename $(notdir $<)).Rout
