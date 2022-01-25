BINARYNAME=firmwaremanager

PLUGINS = $(shell find plugins/ -type f -name '*.go')
OUTPUT_PLUGINS = $(add_prefix build/,$(addsuffix .o,$(basename $(notdir $(PLUGINS)))))

build_modules: $(OUTPUT_PLUGINS)

build/%.o: plugins/

build:
	go build -o build/${BINARYNAME} firmware-manager.go

run:
	./build/${BINARYNAME}

build_and_run: build run

clean:
	go clean
	rm -r build/*

test:
	go test ./...

test_coverage:
	go test ./... -coverprofile=coverage.out

dep:
	go mod download

vet:
	go vet

lint:
	golangci-lint run --enable-all

.PHONY: build test clean
