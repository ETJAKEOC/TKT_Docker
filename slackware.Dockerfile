FROM aclemons/slackware:current

# Set the mirror
ENV SLACK_MIRROR="http://mirrors.unixsol.org/slackware/slackware64-current/"

# Fix ca-certificates the Slackware way
RUN mkdir -p /etc/slackpkg && \
    echo "${SLACK_MIRROR}" > /etc/slackpkg/mirrors && \
    wget --no-check-certificate "${SLACK_MIRROR}slackware64/n/ca-certificates-$(date +%Y%m%d).txz" -O /tmp/ca-certificates.txz || true && \
    installpkg /tmp/ca-certificates.txz || true && \
    slackpkg update gpg && \
    slackpkg update

# Install build deps
RUN yes | slackpkg -batch=on -default_answer=y install \
    bash bc binutils bison brotli ccache clang cmake cpio curl cyrus-sasl diffutils dwarves elfutils fakeroot fakeroot-ng file flex gc gcc \
    gcc-g++ gcc-gcobol gcc-gdc gcc-gfortran gcc-gm2 gcc-gnat gcc-go gcc-objc gcc-rust git glibc guile gzip kernel-headers kmod libedit libelf \
    libxml2 lld llvm lz4 lzop m4 make ncurses nghttp2 nghttp3 openssl patchutils perl python3 python3-pip rsync schedtool spirv-llvm-translator \
    sudo tar time wget xxHash xz zstd

# Clean up cache
RUN rm -rf /var/cache/*

CMD ["/usr/bin/bash"]
