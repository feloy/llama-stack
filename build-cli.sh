#!/bin/bash

TAG=v0.0.3
MANIFEST=quay.io/podman-ai-lab/llama-stack-playground

set -e 

podman manifest rm -i ${MANIFEST}:${TAG}
podman manifest create ${MANIFEST}:${TAG}
podman build --platform linux/amd64,linux/arm64 llama_stack/distribution/ui --manifest ${MANIFEST}:${TAG}
podman manifest push ${MANIFEST}:${TAG}
