FROM scratch

LABEL maintainer="Clement Verna <cverna@fedoraproject.org>"

ENV DISTTAG=f43container FGC=f43 FBR=f43

ADD fedora-20250720.tar /

CMD ["/bin/bash"]