FROM gentoo/stage3:systemd

# Modern Gentoo wants /etc/portage/package.use as a dir, not a file
RUN mkdir -p /etc/portage/package.use /etc/portage/package.accept_keywords

# Set USE flags
RUN echo 'sys-kernel/installkernel dracut' >> /etc/portage/package.use/installkernel
RUN echo 'dev-libs/openssl ~amd64' >> /etc/portage/package.accept_keywords/tkt
RUN echo "media-libs/libglvnd X" > /etc/portage/package.use/libglvnd
RUN echo "x11-libs/libxkbcommon X" >> /etc/portage/package.use/libxkbcommon

# Enable binpkg fetch, ccache
ENV ACCEPT_KEYWORDS="~amd64"
ENV FEATURES="ccache getbinpkg"

# Binhost
ENV PORTAGE_BINHOST="https://distfiles.gentoo.org/releases/amd64/binpackages/23.0/x86-64"
RUN getuto

# Sync tree and set profile
RUN emerge-webrsync
RUN eselect profile set 2

# Update portage, do a systemwide update and emerge packages 
RUN emerge --oneshot portage
RUN emerge --update --deep --newuse @world
RUN emerge --verbose --getbinpkg --usepkg --buildpkg --binpkg-respect-use=y --autounmask=y --autounmask-continue \
      sys-kernel/gentoo-kernel-bin \
      llvm-core/llvm \
      llvm-core/clang \
      llvm-core/lld \
      dev-util/ccache \
      dev-build/cmake \
      dev-vcs/git \
      app-arch/lz4 \
      dev-python/pip \
      net-misc/curl \
      sys-process/time \
      app-admin/sudo \
      dev-util/patchutils

CMD ["/bin/bash"]
