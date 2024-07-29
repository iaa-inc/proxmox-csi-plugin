FROM scratch AS proxmox-csi-controller

COPY --from=gcr.io/distroless/static-debian12:nonroot . .
COPY bin/proxmox-csi-controller /bin/proxmox-csi-controller

ENTRYPOINT ["/bin/proxmox-csi-controller"]

FROM scratch AS proxmox-csi-node

COPY --from=gcr.io/distroless/base-debian12 . .
COPY --from=tools /dest /

COPY bin/proxmox-csi-node /bin/proxmox-csi-node

ENTRYPOINT ["/bin/proxmox-csi-node"]