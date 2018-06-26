#!/usr/bin/bash
set -euo pipefail

# Create a workspace, and schedule it for deletion.
cleanup() { if [ -n "${workspace:-}" ]; then rm -rf "${workspace}"; fi }
trap cleanup EXIT  # bash pseudo signal
trap 'cleanup ; trap - SIGINT ; kill -s SIGINT $$' SIGINT
trap 'cleanup ; trap - SIGTERM ; kill -s SIGTERM $$' SIGTERM
workspace="$(mktemp --directory)"

# Alad Wenter (https://aur.archlinux.org/account/Alad)
gpg --recv-keys DBE7D3DD8C81D58D0A13D0E76BC26A17B9B7018A

# Get, build and install aurutils and its deps.
cd "${workspace}"
curl -O 'https://aur.archlinux.org/cgit/aur.git/snapshot/aurutils.tar.gz'
tar xzf aurutils.tar.gz
cd aurutils
makepkg --noconfirm --syncdeps
sudo pacman -U --noconfirm aurutils-*.pkg.tar.xz
