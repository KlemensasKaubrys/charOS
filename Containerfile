FROM scratch AS ctx
COPY build_files /

FROM ghcr.io/ublue-os/bazzite:stable as charOS

COPY system_files /

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
	/ctx/fix-opt.sh && \
    /ctx/build.sh && \
	/ctx/cleanup.sh
    
RUN bootc container lint