FROM quay.io/fedora/fedora-kinoite:43

ARG IMAGE_NAME="kinokite"
ARG IMAGE_VENDOR="clemak27"

COPY build.sh /tmp/build.sh
COPY plasma.sh /tmp/plasma.sh
COPY cosign.pub /tmp/cosign.pub

ARG RELEASE_VERSION

RUN mkdir -p /var/lib/alternatives

RUN /tmp/build.sh && \
  /tmp/plasma.sh && \
  ostree container commit
