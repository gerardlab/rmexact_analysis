nc = 4
rexec = R CMD BATCH --no-save --no-restore

.PHONY : all
all : sturg

.PHONY : sturg
sturg : ./output/sturg/nmat_updog.RDS

./data/sturg/8n_12n_sturgeon_readCounts.rda :
	mkdir -p ./data/sturg
	wget --directory-prefix=data/sturg --no-clobber https://datadryad.org/stash/downloads/file_stream/711273
	mv ./data/sturg/711273 ./data/sturg/8n_12n_sturgeon_readCounts.rda

./output/sturg/nmat_updog.RDS : ./analysis/real_nmat.R ./data/sturg/8n_12n_sturgeon_readCounts.rda
	mkdir -p ./output/rout
	mkdir -p ./output/sturg
	$(rexec) '--args nc=$(nc)' $< ./output/rout/$(basename $(notdir $<)).Rout
