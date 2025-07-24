FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential bc bison flex libssl-dev libelf-dev dwarves \
    git curl wget python3 clang lld
