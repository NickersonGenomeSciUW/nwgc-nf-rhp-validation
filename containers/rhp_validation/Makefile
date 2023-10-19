IMAGE_NAME = rhp_validation
VERSION = 1.5.15

TAG1 = nwgc/$(IMAGE_NAME):$(VERSION)
TAG2 = nwgc/$(IMAGE_NAME):latest

build:
	singularity build --force $(IMAGE_NAME).$(VERSION).sif rhp_validation.def

install:
	mkdir -p /net/nwgc/vol1/software/containers/nf-nwgc-rhp-validation/
	mv $(IMAGE_NAME).$(VERSION).sif /net/nwgc/vol1/software/containers/nf-nwgc-rhp-validation/

deploy: build install