FROM debian:12.5 AS tools

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    mount \
    udev \
    e2fsprogs \
    xfsprogs \
    util-linux \
    cryptsetup \
    rsync

COPY tools /tools
RUN /tools/deps.sh

FROM scratch

COPY ./bin/proxmox-csi-node /bin/proxmox-csi-node

COPY --from=gcr.io/distroless/base-debian12 . .
COPY --from=tools /dest /

ENTRYPOINT ["/bin/proxmox-csi-node"]