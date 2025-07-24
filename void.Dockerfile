FROM voidlinux/voidlinux:latest

# Point to official Void repo
RUN rm -rf /etc/xbps.d/* && \
    echo "repository=https://repo-default.voidlinux.org/current" > /etc/xbps.d/00-repository-main.conf

# Sync base system and certs
RUN xbps-install -Suy xbps && \
    xbps-install -Sy ca-certificates

# Install core + compiler + packaging tools
RUN xbps-install -y \
  bash bc bison ccache clang clang-tools-extra cmake cpio curl flex git kmod lz4 make patchutils perl \
  python3 python3-pip rsync sudo tar time wget zstd \
  base-devel docbook-xsl elfutils-devel fakeroot gcc gnupg graphviz liblz4-devel lz4 lzop m4 \
  ncurses openssl-devel pahole patch pkg-config schedtool xtools xmlto xz

# Clean up
RUN xbps-remove -O && rm -rf /var/cache/xbps

CMD ["/bin/bash"]
