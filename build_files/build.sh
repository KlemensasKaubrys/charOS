#!/bin/bash

set -ouex pipefail

dnf5 install -y rocminfo rocm-opencl rocm-clinfo rocm-hip

ls -ld /opt || true
ls -ld /var/opt || true
namei -l /opt || true
if [ -e /opt ] && [ ! -L /opt ]; then
  rm -rf /opt
fi
[ -L /opt ] || ln -s ../var/opt /opt
mkdir -p /var/opt

rpm --import https://repos.fyralabs.com/keys/terra.gpg 
dnf5 -y install https://repos.fyralabs.com/terra-release-latest.fc$(rpm -E %fedora).noarch.rpm zed ghostty starship


dnf5 install -y brave-browser

systemctl enable podman.socket
