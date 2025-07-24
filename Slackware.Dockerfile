FROM scratch AS slackware-amd64

ARG VERSION
ADD slackware64-$VERSION.tar /

ARG TARGETARCH
# hadolint ignore=DL3006
FROM slackware-$TARGETARCH
CMD ["bash"]
