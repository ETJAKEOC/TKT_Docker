FROM opensuse/tumbleweed:latest

RUN zypper --non-interactive ref && \
    zypper --non-interactive dup && \
    zypper --non-interactive install --no-recommends \
      git gcc make bc bison flex ncurses-devel openssl-devel \
      libelf-devel dwarves patchutils perl python3 wget curl clang lld
