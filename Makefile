VERSION=$(shell git describe --tags --always)
COMMIT=$(shell git rev-parse HEAD)
GITDIRTY=$(shell git diff --quiet || echo 'dirty')
GIT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
REPOSITORY?="joaoh82"
IMAGE="super-simple-load-balancer"

# COLORS
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

all: help

.PHONY: build-docker
## Build application with docker, on linux environment
build-docker:
	@echo 'building ${YELLOW}super-simple-load-balancer ${RESET} ${GREEN}$(VERSION)${RESET} application for Docker'
	@docker build -t ${IMAGE}:latest .
	@echo ${GREEN} Done!

.PHONY: build-linux
## Build application for Linux OS environment
build-linux:
	@echo 'building ${YELLOW}${IMAGE} ${RESET} ${GREEN}$(VERSION)${RESET} application for Linux OS'
	@CGO_ENABLED=0 GOOS=linux GOPROXY=https://proxy.golang.org go build -o build/sslb .
	@echo 'updating ${YELLOW}${IMAGE} on PATH'
	@mv -f build/sslb /usr/local/bin
	@echo ${GREEN} Done!

.PHONY: build-mac
## Build application for Mac OS environment
build-mac:
	@echo 'building ${YELLOW}${IMAGE} ${RESET} ${GREEN}$(VERSION)${RESET} application for Mac OS'
	@CGO_ENABLED=0 GOOS=darwin GOPROXY=https://proxy.golang.org go build -o build/sslb .
	@echo 'updating ${YELLOW}${IMAGE} on PATH'
	@mv -f build/sslb /usr/local/bin
	@echo ${GREEN} Done!

TARGET_MAX_CHAR_NUM=25
## Show help
help:
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)