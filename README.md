# container-image-template

This is a template of a git repository which is a source for building container images.

It uses [dfe](https://github.com/bkabrda/dfe) to render the `Dockerfile` template for specific base image/software version/etc.

## Description

* `configurations.yml` - a configuration file for [dfe](https://github.com/bkabrda/dfe)
* `Dockerfile` - template of `Dockerfile`
* `help/` - a directory containing `help.md` file. This serves as a base for container help page. Similarly to `Dockerfile`, it's also templated and rendered prior to image build.
* `LICENSE` — pick the right license
* `Makefile` — so it's easy to build, run, test
* `README.md` — global documentation for the whole service
  * what is it, how to build, how to use
* `script.sh` - an example script that gets put inside built image
* `tests/` — these tests should verify that the image works

## Usage

* `make [CONFIGURATION=<name>] doc` - build docs (help file and a generated manpage) for a certain configuration listed in `configurations.yml`
* `make [CONFIGURATION=<name>] build` - build image with a certain configuration listed in `configurations.yml`
* `make [CONFIGURATION=<name>] run` - build and run container with a certain configuration listed in `configurations.yml`
* `make [CONFIGURATION=<name>] test` - build and test a container with certain configuration listed in `configurations.yml`
