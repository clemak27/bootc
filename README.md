# `kinokite`

## About

This repo contains a customized image of Fedora Kinoite.
This is for my personal use and a bit opinionated,
but feel free to use it.

It installs some basic packages and sets up all
Plasma Extensions I typically use.

Dotfiles and setup for user-specific changes are in my
[linux_setup repo](https://github.com/clemak27/linux_setup).

## Usage

In a fresh Fedora Kinoite installation, change the base image:

```sh
rpm-ostree rebase ostree-unverified-registry:ghcr.io/clemak27/kinokite:latest
```
