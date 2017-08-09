.PHONY: dfe doc build run test

CONFIGURATION = fedora-26-version-2.4

dfe:
	dfe -r ${CONFIGURATION}

doc: dfe
	mkdir -p ./root/
	go-md2man -in=help/help.md.${CONFIGURATION} -out=./root/help.1

build: doc dfe
	docker build --tag=`dfe -v ${CONFIGURATION} "tag"` -f Dockerfile.${CONFIGURATION} .

run: build
	docker run -p 9000:9000 -d `dfe -v ${CONFIGURATION} "tag"`
