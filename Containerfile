FROM quay.io/fedora/fedora-kinoite:43

LABEL org.opencontainers.image.title="Fedora Kinokite"
LABEL org.opencontainers.image.description="Customized image of Fedora Kinoite"
LABEL org.opencontainers.image.source="https://github.com/clemak27/kinokite"
LABEL org.opencontainers.image.licenses="MIT"

ARG IMAGE_NAME="kinokite"
ARG IMAGE_VENDOR="clemak27"

COPY build.sh /tmp/build.sh
COPY plasma.sh /tmp/plasma.sh

COPY kwinrc /etc/xdg/kwinrc

ARG RELEASE_VERSION

RUN mkdir -p /var/lib/alternatives

RUN /tmp/build.sh && \
  /tmp/plasma.sh && \
  ostree container commit
