FROM ubuntu:latest

# Add System76 repo + key
RUN apt-get update && \
    apt-get install -y wget gnupg curl

# Add Pop!_OS APT repo & key
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 63C46DF0140D738961429F4E204DD8AEC33A7AFF && \
    apt-get update

# Install Pop!_OS branding + base packages + dev tools
RUN apt-get install -y \
    build-essential bc bison flex libssl-dev libelf-dev dwarves \
    clang lld llvm git curl wget python3 perl

# Clean up APT
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Fake /etc/os-release to flex Pop!_OS flavor
RUN echo "NAME=\"Pop!_OS\"" > /etc/os-release && \
    echo "VERSION=\"24.04 LTS\"" >> /etc/os-release && \
    echo "ID=pop" >> /etc/os-release && \
    echo "ID_LIKE=ubuntu" >> /etc/os-release && \
    echo "PRETTY_NAME=\"Pop!_OS 24.04 LTS\"" >> /etc/os-release && \
    echo "VERSION_ID=\"24.04\"" >> /etc/os-release && \
    echo "UBUNTU_CODENAME=jammy" >> /etc/os-release

RUN ln -s /usr/bin/clang /usr/bin/clang-cpp

CMD ["/bin/bash"]
