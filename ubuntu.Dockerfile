FROM ubuntu:latest

# Update + install all build deps at build time
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository main
RUN add-apt-repository universe
RUN add-apt-repository multiverse
RUN add-apt-repository restricted
RUN echo "deb [trusted=yes] http://mirror.mit.edu/ubuntu plucky main universe multiverse restricted" | tee /etc/apt/sources.list.d/plucky.list
RUN apt-get install -y --no-install-recommends \
      build-essential bc bison flex libssl-dev libelf-dev dwarves \
      git curl wget clang lld llvm clang-tools clang-format clang-tidy \
      bash ccache cmake cpio kmod lz4 make patchutils python3 python3-pip \
      rsync sudo tar time zstd liblz4-dev libxxhash-dev

# Ensure clang-cpp is resolved (redundant but safe fallback)
RUN ln -sf /usr/bin/clang /usr/bin/clang-cpp || true

# Clean cache for smaller image
RUN rm -rf /var/lib/apt/lists/*

CMD ["/usr/bin/bash"]
