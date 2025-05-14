#!/bin/bash

TAG=v0.0.3
MANIFEST=quay.io/podman-ai-lab/distribution-podman-ai-lab

set -e

podman manifest rm -i ${MANIFEST}:${TAG}
podman manifest create ${MANIFEST}:${TAG}

for platform in linux/arm64 linux/amd64
do
  BUILD_PLATFORM=${platform} \
    CONTAINER_BINARY=podman \
    CONTAINER_OPTS="--manifest ${MANIFEST}:${TAG}" \
    USE_COPY_NOT_MOUNT=true \
    LLAMA_STACK_DIR=. \
    python -m llama_stack.cli.llama stack build \
      --template podman-ai-lab \
      --image-type container \
      --image-name dummy
done

podman manifest push ${MANIFEST}:${TAG}
