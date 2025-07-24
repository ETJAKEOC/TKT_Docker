FROM ubuntu:latest

# Linux Mint's base repos match Ubuntu's version, so 22.04 = Mint 21.x
# We'll fake it by adding Mint's repo + key

# Add Mint repo + keyring
RUN apt-get update && \
    apt-get install -y wget gnupg lsb-release

RUN echo "DISTRIB_ID=LinuxMint" > /etc/lsb-release && \
    echo "DISTRIB_RELEASE=22" >> /etc/lsb-release && \
    echo "DISTRIB_CODENAME=zara" >> /etc/lsb-release && \
    echo "DISTRIB_DESCRIPTION=\"Linux Mint 22 Zara\"" >> /etc/lsb-release

RUN echo "NAME=\"Linux Mint\"" > /etc/os-release && \
    echo "VERSION=\"22 (Zara)\"" >> /etc/os-release && \
    echo "ID=linuxmint" >> /etc/os-release && \
    echo "ID_LIKE=ubuntu" >> /etc/os-release && \
    echo "PRETTY_NAME=\"Linux Mint 22\"" >> /etc/os-release && \
    echo "VERSION_ID=\"22\"" >> /etc/os-release && \
    echo "UBUNTU_CODENAME=jammy" >> /etc/os-release

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A6616109451BBBF2 \
 && echo "deb http://packages.linuxmint.com zara main upstream import backport" > /etc/apt/sources.list.d/mint.list \
 && apt-get update

# Install Mint base bits + build tools
RUN apt-get install -y \
    build-essential bc bison flex libssl-dev libelf-dev dwarves \
    git curl wget clang lld python3 perl \
    bash ccache cmake cpio curl git kmod lz4 make patchutils perl python3 python3-pip rsync sudo tar time wget zstd \
    clang lld llvm clang-format clang-tidy clang-tools \
    liblz4-dev libxxhash-dev software-properties-common

RUN ln -s /usr/bin/clang /usr/bin/clang-cpp

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
