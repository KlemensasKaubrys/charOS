#!/bin/bash
set -ouex pipefail
[ -L /opt ] && rm -f /opt
mkdir -p /opt

rpm --import "https://repos.fyralabs.com/terra$(rpm -E %fedora)/key.asc"

dnf5 -y install \
  --repofrompath=terra-bootstrap,"https://repos.fyralabs.com/terra$(rpm -E %fedora)/" \
  terra-release

sed -i -e 's/^enabled=.*/enabled=1/' \
       -e "s|^baseurl=.*|baseurl=https://repos.fyralabs.com/terra$(rpm -E %fedora)/\$basearch/|" \
       /etc/yum.repos.d/terra.repo || true

dnf5 -y --refresh install brave-browser zed rocminfo rocm-opencl rocm-clinfo rocm-hip

dnf5 install -y @virtualization virt-manager qemu-kvm libvirt virt-viewer bridge-utils distrobox ptyxis
systemctl enable libvirtd
systemctl enable podman.socket