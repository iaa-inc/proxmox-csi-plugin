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

FROM scratch AS proxmox-csi-controller

COPY --from=gcr.io/distroless/static-debian12:nonroot . .
COPY ./bin/proxmox-csi-controller /proxmox-csi-controller

ENTRYPOINT ["/proxmox-csi-controller"]

FROM scratch AS proxmox-csi-node

COPY --from=gcr.io/distroless/base-debian12 . .
COPY --from=tools /dest /
COPY ./bin/proxmox-csi-node /proxmox-csi-node

ENTRYPOINT ["/proxmorx-csi-node"]
