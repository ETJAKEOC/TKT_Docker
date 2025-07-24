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
    bash bc bison ccache cmake cpio curl flex gcc git kmod lz4 make patchutils perl python3 python3-pip rsync \
    sudo tar time wget zstd clang llvm lld dwarves

# Clean up cache
RUN rm -rf /var/cache/*

CMD ["/usr/bin/bash"]
