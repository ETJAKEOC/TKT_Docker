FROM debian:sid

# Replace sources.list with full Sid repos: main + contrib + non-free + non-free-firmware
RUN rm -rf /etc/apt/sources.list /etc/apt/sources.list.d
RUN echo "deb http://deb.debian.org/debian sid main contrib non-free non-free-firmware" > /etc/apt/sources.list

# Base system & dev tools
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
      bash bc bison binutils binutils-dev binutils-gold \
      build-essential ccache clang clang-format clang-tidy clang-tools \
      cmake cpio curl debhelper device-tree-compiler dpkg-dev \
      dwarves fakeroot flex g++ g++-multilib gcc gcc-multilib \
      git gnupg kmod libc6-dev libc6-dev-i386 libdw-dev libelf-dev \
      libncurses-dev libnuma-dev libperl-dev libssl-dev libstdc++-14-dev \
      libudev-dev lld llvm lz4 make ninja-build patchutils \
      perl python3 python3-pip python3-setuptools qtbase5-dev \
      rsync schedtool sudo tar time wget xz-utils zstd

# Symlink clang-cpp if needed (older LLVM versions sometimes miss this)
RUN ln -s /usr/bin/clang /usr/bin/clang-cpp || true

# Clean APT
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["/usr/bin/bash"]
