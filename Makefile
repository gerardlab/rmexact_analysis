nc = 4
rexec = R CMD BATCH --no-save --no-restore

## Raw data from Delomas et al (2021)
sturg_dat = ./data/sturg/2n_3n_Chinook_readCounts.rda \
            ./data/sturg/8n_12n_sturgeon_readCounts.rda \
            ./data/sturg/10n_sturgeon_readCounts.rda \
            ./data/sturg/white_sturgeon_genos.zip

## Get nmat for sturgeon data
sturg_n = ./output/sturg/nmat_updog.RDS \
          ./output/sturg/nmat_delo.RDS \
          ./output/sturg/sturg_updog.RDS


.PHONY : all
all : sturg

.PHONY : sturg
sturg : $(sturg_n)

$(sturg_dat) :
	mkdir -p ./data/sturg
	wget --directory-prefix=data/sturg --no-clobber https://datadryad.org/stash/downloads/file_stream/711274
	mv ./data/sturg/711274 ./data/sturg/10n_sturgeon_readCounts.rda
	wget --directory-prefix=data/sturg --no-clobber https://datadryad.org/stash/downloads/file_stream/711272
	mv ./data/sturg/711272 ./data/sturg/2n_3n_Chinook_readCounts.rda
	wget --directory-prefix=data/sturg --no-clobber https://datadryad.org/stash/downloads/file_stream/711273
	mv ./data/sturg/711273 ./data/sturg/8n_12n_sturgeon_readCounts.rda
	wget --directory-prefix=data/sturg --no-clobber https://datadryad.org/stash/downloads/file_stream/711275
	mv ./data/sturg/711275 ./data/sturg/white_sturgeon_genos.zip
	mkdir -p ./data/sturg/gt_genos
	7z e ./data/sturg/white_sturgeon_genos.zip -o./data/sturg/gt_genos

$(sturg_n) : ./analysis/real_nmat.R $(sturg_dat)
	mkdir -p ./output/rout
	mkdir -p ./output/sturg
	$(rexec) '--args nc=$(nc)' $< ./output/rout/$(basename $(notdir $<)).Rout
