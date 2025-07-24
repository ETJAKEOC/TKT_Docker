FROM gentoo/stage3:latest

# Modern Gentoo wants /etc/portage/package.use as a dir, not a file
RUN mkdir -p /etc/portage/package.use /etc/portage/package.accept_keywords && \
    echo 'sys-apps/openrc' >> /etc/portage/package.use/tkt && \
    echo "dev-libs/openssl ~amd64" >> /etc/portage/package.accept_keywords/tkt

# Enable binpkg fetch, ccache
ENV ACCEPT_KEYWORDS="~amd64"
ENV FEATURES="ccache getbinpkg"

# Binhost
ENV PORTAGE_BINHOST="https://distfiles.gentoo.org/releases/amd64/binpackages/23.0/x86-64"
RUN getuto

# Enable X USE flag to satisfy qt dependencies
RUN mkdir -p /etc/portage/package.use && \
    echo "media-libs/libglvnd X" > /etc/portage/package.use/libglvnd && \
    echo "x11-libs/libxkbcommon X" >> /etc/portage/package.use/libxkbcommon

# Update package database and apply new USE flags
RUN emaint sync --allrepos
RUN emerge --update --newuse --deep @world
# Sync tree, set profile and update portage first
RUN emerge-webrsync && \
    eselect profile set 1 && \
    emerge --verbose --oneshot portage

# Install packages: prefer binpkgs, fallback to build
RUN emerge --verbose --getbinpkg --usepkg --buildpkg --binpkg-respect-use=y --autounmask=y --autounmask-continue \
      sys-kernel/gentoo-sources \
      sys-apps/openrc \
      llvm-core/llvm \
      llvm-core/clang \
      llvm-core/lld \
      dev-util/ccache \
      sys-devel/binutils \
      sys-devel/gcc \
      dev-build/make \
      dev-build/cmake \
      dev-vcs/git \
      dev-libs/elfutils \
      sys-apps/kmod \
      app-arch/lz4 \
      app-arch/zstd \
      app-shells/bash \
      sys-devel/bison \
      sys-devel/flex \
      dev-lang/perl \
      dev-lang/python \
      dev-python/pip \
      net-misc/curl \
      net-misc/rsync \
      app-arch/tar \
      sys-process/time \
      app-admin/sudo \
      sys-apps/util-linux \
      dev-util/patchutils \
      dev-qt/qtcore \
      dev-qt/qtgui \
      dev-qt/qtwidgets \
      sys-libs/ncurses \
      dev-libs/openssl \
      dev-build/ninja

CMD ["/bin/bash"]
