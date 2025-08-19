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

dnf5 install -y --refresh brave-browser zed
dnf5 install @xfce-desktop-environment

dnf5 install -y @virtualization virt-manager qemu-kvm libvirt virt-viewer bridge-utils distrobox ptyxis
dnf5 install -y rocminfo rocm-opencl rocm-clinfo rocm-hip rocm-hip-devel rocm-runtime-devel hipcc rocminfo rocm-smi

systemctl enable libvirtd
systemctl enable podman.socket
