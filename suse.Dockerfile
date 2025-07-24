FROM opensuse/tumbleweed:latest

# Refresh + dist-upgrade for latest packages
RUN zypper --non-interactive refresh && \
    zypper --non-interactive dup

# Install build + kernel dev toolchain
RUN zypper --non-interactive install --no-recommends \
    bash bc bison ccache clang clang-tools cmake cpio curl dwarves flex gawk gcc-c++ git \
    hostname kernel-source kernel-syms kmod libdw-devel libelf-devel libnuma-devel \
    libopenssl-devel libqt5-qtbase-devel libudev-devel lld llvm lz4 make ncurses-devel \
    openssl-devel patchutils perl perl-ExtUtils-MakeMaker python311 python311-devel \
    python311-pip rpm-build rpmdevtools rsync sudo tar time wget xz zstd awk
RUN zypper --non-interactive addrepo --refresh https://download.opensuse.org/repositories/devel:languages:python/openSUSE_Tumbleweed/devel:languages:python.repo
RUN rpm --import https://download.opensuse.org/repositories/devel:/languages:/python/openSUSE_Tumbleweed/repodata/repomd.xml.key
RUN zypper --gpg-auto-import-keys refresh

# Clean up cache to reduce layers
RUN zypper clean -a

CMD ["/usr/bin/bash"]
