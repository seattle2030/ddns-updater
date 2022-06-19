SHELL=/bin/bash
PUBLISHER=seattle2030
PROJECT_NAME=ddns-updater
ifeq ($(PUBLISHER),)
    TAG=$(PUBLISHER)/$(PROJECT_NAME)
else
	TAG=$(PUBLISHER)/$(PROJECT_NAME)
endif

COMMIT_ID:=$(shell git rev-parse --short HEAD)
DUMMY_SECRET:="Pe6qs93YTXiXbu2AVX4Qo5"
DUMMY_KEY:="eoWr51QvUCtx_WtywVr1meeDrD6Q52kjkg1"

.PHONY:

build:
	docker build -t $(TAG):$(COMMIT_ID) .

build-M1:
	docker buildx build --push -t $(TAG):$(COMMIT_ID) -o type=image --platform=linux/arm64,linux/amd64 .

example-run :
	docker run --rm -e DOMAIN=seattle2030.net -e TYPE=A -e NAME=dev -e SECRET=$(DUMMY_SECRET) -e KEY=$(DUMMY_KEY) -e TTL=600 --name $(PROJECT_NAME) $(TAG):$(COMMIT_ID)

run:
	docker run --rm -e DOMAIN=$(DOMAIN) -e DOMAIN=$(DOMAIN) -e TYPE=$(TYPE)A -e NAME=$(NAME) -e KEY=$(KEY) -e TTL=$(TTL) --name $(PROJECT_NAME) $(TAG):$(COMMIT_ID)

stop:
	docker stop $(PROJECT_NAME)

rm:
	docker rm $(PROJECT_NAME)

background-run:
	docker run -d --restart always -e DOMAIN=$(DOMAIN) -e DOMAIN=$(DOMAIN) -e TYPE=$(TYPE)A -e NAME=$(NAME) -e KEY=$(KEY) -e TTL=$(TTL) --name $(PROJECT_NAME) $(TAG):$(COMMIT_ID)