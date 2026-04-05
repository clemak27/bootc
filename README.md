# `bootc`

## About

This repo contains customized image of Fedora I use on my PCs.
This is for my personal use and a bit opinionated,
but feel free to use it as inspiration.

Dotfiles and setup for user-specific changes are in my
[linux_setup repo](https://github.com/clemak27/linux_setup).

It currently builds 2 Images:

| name       | description                                                                                                                 |
| ---------- | --------------------------------------------------------------------------------------------------------------------------- |
| dankfedora | custom Fedora image with [DMS](https://github.com/AvengeMedia/DankMaterialShell) and [niri](https://github.com/YaLTeR/niri) |
| dankydeck  | custom bazzite image with [karousel](https://github.com/peterfajdiga/karousel) and other plugins                            |

## Usage

In a fresh Fedora Atomic installation (e.g. Silverblue or Kinoite), change the
base image:

```sh
rpm-ostree rebase ostree-unverified-registry:ghcr.io/clemak27/dankfedora:latest
```

After a reboot, you can change to a signed image:

```sh
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/clemak27/dankfedora:latest
```
