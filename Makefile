#
# /flutter_experiment/Makefile
#

VERSION := $(shell cat VERSION)
LOCAL_MAJOR_VERSION := $(word 1,$(subst ., ,$(VERSION)))
LOCAL_MINOR_VERSION := $(word 2,$(subst ., ,$(VERSION)))
LOCAL_PATCH_VERSION := $(word 3,$(subst ., ,$(VERSION)))
SHELL := /usr/bin/env bash
.SHELLFLAGS := -eu -o pipefail -c

MYPATH = $(shell pwd)
COMMIT := $(shell git describe --always)
DATE := $(shell date -u +"%Y-%m-%d-%H:%M")

TIMESTAMP := date +"%Y-%m-%d %H:%M:%S.%3N"

.PHONY: all \
	build_flutter_experiment_cache \
	build_flutter_experiment_no_cache \
	build_debug \
	deploy_flutter_experiment \
	down_flutter_experiment \
	docker_logs \
	docker_exec

all: build_flutter_experiment_cache \
	deploy_flutter_experiment

build_flutter_experiment_cache:
	@_start_time_ns=$$(date +%s%N); \
	echo "[$($(TIMESTAMP))] Starting $@..."; \
	echo "================================"; \
	echo "Make build_flutter_experiment randomizedcoder/flutter_experiment:${VERSION}"; \
	docker build \
		--progress=plain \
		--network=host \
		--build-arg MYPATH=${MYPATH} \
		--build-arg COMMIT=${COMMIT} \
		--build-arg DATE=${DATE} \
		--build-arg VERSION=${VERSION} \
		--file build/containers/flutter_experiment/Containerfile_cache \
		--tag randomizedcoder/flutter_experiment:${VERSION} \
		--tag randomizedcoder/flutter_experiment:latest \
		${MYPATH}; \
	_end_time_ns=$$(date +%s%N); \
	_duration_ms=$$(( (_end_time_ns - _start_time_ns) / 1000000 )); \
	echo "[$($(TIMESTAMP))] Finished $@. Duration: $$_duration_ms ms."

build_flutter_experiment_no_cache:
	@_start_time_ns=$$(date +%s%N); \
	echo "[$($(TIMESTAMP))] Starting $@..."; \
	echo "================================"; \
	echo "Make build_flutter_experiment randomizedcoder/flutter_experiment:${VERSION}"; \
	docker build \
		--progress=plain \
		--network=host \
		--build-arg MYPATH=${MYPATH} \
		--build-arg COMMIT=${COMMIT} \
		--build-arg DATE=${DATE} \
		--build-arg VERSION=${VERSION} \
		--file build/containers/flutter_experiment/Containerfile_no_cache \
		--tag randomizedcoder/flutter_experiment:${VERSION} \
		--tag randomizedcoder/flutter_experiment:latest \
		${MYPATH}; \
	_end_time_ns=$$(date +%s%N); \
	_duration_ms=$$(( (_end_time_ns - _start_time_ns) / 1000000 )); \
	echo "[$($(TIMESTAMP))] Finished $@. Duration: $$_duration_ms ms."

build_debug:
	@_start_time_ns=$$(date +%s%N); \
	echo "[$($(TIMESTAMP))] Starting $@..."; \
	echo "================================"; \
	echo "Make build_debug randomizedcoder/flutter_experiment:${VERSION}"; \
	docker build \
		--progress=plain \
		--network=host \
		--build-arg MYPATH=${MYPATH} \
		--build-arg COMMIT=${COMMIT} \
		--build-arg DATE=${DATE} \
		--build-arg VERSION=${VERSION} \
		--file build/containers/flutter_experiment/Containerfile \
		--tag randomizedcoder/flutter_experiment:${VERSION} \
		--tag randomizedcoder/flutter_experiment:latest \
		${MYPATH}> ./temp/flutter_compile_errors.log 2>&1; \
	_end_time_ns=$$(date +%s%N); \
	_duration_ms=$$(( (_end_time_ns - _start_time_ns) / 1000000 )); \
	echo "[$($(TIMESTAMP))] Finished $@. Duration: $$_duration_ms ms."

deploy_flutter_experiment:
	@echo "================================"
	@echo "Make deploy_flutter_experiment"
	docker compose \
		--file build/containers/flutter_experiment/docker-compose.yml \
		up -d --remove-orphans

down_flutter_experiment:
	@echo "================================"
	@echo "Make down_flutter_experiment"
	docker compose \
		--file build/containers/flutter_experiment/docker-compose.yml \
		down

docker_logs:
		docker logs --follow flutter_experiment

docker_exec:
		docker exec -ti flutter_experiment /bin/sh

# end