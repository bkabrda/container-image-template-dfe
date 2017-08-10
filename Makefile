.PHONY: dfe doc build run test

CONFIGURATION = fedora-26-version-2.4
TAG = $(shell dfe config-value ${CONFIGURATION} "tag")
VERSION = $(shell dfe config-value ${CONFIGURATION} "vars.software_version")

dfe:
	dfe render ${CONFIGURATION}

doc: dfe
	mkdir -p ./root/
	go-md2man -in=help/help.md.${CONFIGURATION} -out=./root/help.1

build: doc dfe
	docker build --tag=${TAG} -f Dockerfile.${CONFIGURATION} .

run: build
	docker run -p 9000:9000 -d ${TAG}

test: build
	cd tests; VERSION=${VERSION} DOCKERFILE="../Dockerfile.${CONFIGURATION}" MODULE=docker URL="docker=${TAG}" make all

clean:
	rm -f Dockerfile.*
	rm -f help/help.md.*
	rm -rf root
