#!/bin/sh

DOCKER_HUB_PROJECT=snowdreamtech/adminerevo

GITHUB_PROJECT=ghcr.io/snowdreamtech/adminerevo

docker buildx build --platform=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/riscv64,linux/s390x \
-t ${DOCKER_HUB_PROJECT}:latest \
-t ${DOCKER_HUB_PROJECT}:4.8.3 \
-t ${DOCKER_HUB_PROJECT}:4.8 \
-t ${DOCKER_HUB_PROJECT}:4 \
-t ${GITHUB_PROJECT}:latest \
-t ${GITHUB_PROJECT}:4.8.3 \
-t ${GITHUB_PROJECT}:4.8 \
-t ${GITHUB_PROJECT}:4 \
. \
--push
