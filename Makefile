.PHONY: dfe doc build run test

CONFIGURATION = fedora-26-version-2.4

dfe:
	dfe render ${CONFIGURATION}

doc: dfe
	mkdir -p ./root/
	go-md2man -in=help/help.md.${CONFIGURATION} -out=./root/help.1

build: doc dfe
	docker build --tag=`dfe expanded-value ${CONFIGURATION} "tag"` -f Dockerfile.${CONFIGURATION} .

run: build
	docker run -p 9000:9000 -d `dfe expanded-value ${CONFIGURATION} "tag"`

clean:
	rm -f Dockerfile.*
	rm -f help/help.md.*
	rm -rf root
