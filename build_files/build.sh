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

rpm --import https://repos.fyralabs.com/terra$(rpm -E %fedora)/key.asc
dnf5 -y install --repofrompath=terra,https://repos.fyralabs.com/terra$(rpm -E %fedora)/ terra-release zed


dnf5 install -y brave-browser

systemctl enable podman.socket
