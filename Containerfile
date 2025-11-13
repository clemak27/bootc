FROM scratch AS ctx
COPY /system /sys_files
COPY /build /
COPY cosign.pub /cosign.pub

FROM quay.io/fedora/fedora-kinoite:43

ARG IMAGE_NAME="kinokite"
ARG IMAGE_VENDOR="clemak27"

RUN mkdir -p /var/lib/alternatives

RUN --mount=type=bind,from=ctx,src=/,dst=/ctx \
  --mount=type=cache,target=/var/cache \
  --mount=type=cache,target=/var/log \
  --mount=type=tmpfs,target=/tmp \
  /ctx/0_base.sh && \
  /ctx/1_plasma.sh && \
  /ctx/9_cleanup.sh && \
  ostree container commit && \
  bootc container lint
