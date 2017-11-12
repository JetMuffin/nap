.PHONY: all build test clean

VERSION=$(shell git describe --always --tags --abbre=0)
BUILD_DATE=$(shell date -u +%Y-%m-%d)
gitCommit=$(shell git describe --tags --long)
PKG="github.com/jetmuffin/nap/pkg"

GO_LDFLAGS=-X $(PKG)/version.version=$(VERSION) -X $(PKG)/version.gitCommit=$(GIT_COMMIT) -X $(PKG)/version.buildDate=$(BUILD_DATE) -w -s

default: build

build: clean
	go build -v -a -ldflags "${GO_LDFLAGS}" -o bin/nap pkg/main.go

docker:
	docker build --tag nap:$(shell git rev-parse --short HEAD) .

test:
	go test -v -cover ./pkg/...

clean:
	rm -rfv ./bin/*
