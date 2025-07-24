FROM fedora:latest

# Update dnf and get tools
RUN dnf upgrade --assumeyes
RUN dnf install -y --skip-unavailable \
      bash bc bison ccache cmake cpio curl flex git kmod lz4 make patchutils perl python3 python3-pip rsync \
      sudo tar time wget zstd clang clang-tools-extra lld llvm dwarves gcc-c++ gawk hostname ncurses-devel libdw-devel libelf-devel \
      libnuma-devel libopenssl-devel libudev-devel openssl openssl-devel python3-devel rpm-build rpmdevtools xz zstd \
      elfutils-devel fedora-packager fedpkg pesign numactl-devel openssl-devel-engine perl-devel perl-generators \
      qt5-qtbase-devel

# Clean up
RUN dnf clean all

CMD ["/bin/bash"]
