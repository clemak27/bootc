# `bootc`

## About

This repo contains customized image of Fedora I use on my PCs.
This is for my personal use and a bit opinionated,
but feel free to use it as inspiration.

Dotfiles and setup for user-specific changes are in my
[linux_setup repo](https://github.com/clemak27/linux_setup).

It currently builds 2 Images:

### `dankfedora`

A `bootc` image with [DMS](https://github.com/AvengeMedia/DankMaterialShell)
and [niri](https://github.com/YaLTeR/niri).

### `dankydeck`

An image based on `bazzite-deck`.

It installs some basic packages and sets up some
Plasma extensions.
A significant one is [karousel](https://github.com/peterfajdiga/karousel),
which gives plasma a niri-style scrolling/tiling workflow.

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
