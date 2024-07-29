FROM scratch

COPY ./bin/proxmox-csi-controller /bin/proxmox-csi-controller
COPY --from=gcr.io/distroless/static-debian12:nonroot . .

ENTRYPOINT ["/bin/proxmox-csi-controller"]
