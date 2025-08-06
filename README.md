# Custom bazzite-dx image

This repository is for building a custom bazzite-dx image.

It is based on the ublue-os image template found at [https://github.com/ublue-os/image-template](https://github.com/ublue-os/image-template). The original readme for that repo at the time _this_ repo was created is [ORIGINAL-TEMPLATE-README.md](./ORIGINAL-TEMPLATE-README.md)

# Purpose of this image

This image is meant to be bazzite-dx plus:
- gparted

That's it for now.

# Rebasing to this template from another Fedora atomic image (with KDE Plasma)

See [Bazzite's rebase guide](https://docs.bazzite.gg/Installing_and_Managing_Software/Updates_Rollbacks_and_Rebasing/rebase_guide/) for instructions and warnings about rebasing.

Pay special attention to the warning that says "Rebasing between different desktop environments (e.g. KDE Plasma to GNOME) may cause issues and is unsupported.".

This image is using KDE Plasma, so only rebase from/to other Fedora atomic images that also use KDE Plasma as their desktop environment.

To rebase to this image:

```bash
rpm-ostree rebase  ostree-image-signed:docker://ghcr.io/yapakipe/bazzite-dx-yapakipe:latest
```

To rebase back to bazzite-dx:
```bash
rpm-ostree rebase ostree-unverified-registry:ghcr.io/ublue-os/bazzite-dx:stable
```
