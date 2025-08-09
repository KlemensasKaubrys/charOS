#!/bin/bash
set -ouex pipefail
ls -ld /opt || true
ls -ld /var/opt || true
namei -l /opt || true
if [ -e /opt ] && [ ! -L /opt ]; then
  rm -rf /opt
fi
[ -L /opt ] || ln -s ../var/opt /opt
mkdir -p /var/opt

rpm --import "https://repos.fyralabs.com/terra$(rpm -E %fedora)/key.asc"

dnf5 -y install \
  --repofrompath=terra-bootstrap,"https://repos.fyralabs.com/terra$(rpm -E %fedora)/" \
  terra-release

sed -i -e 's/^enabled=.*/enabled=1/' \
       -e "s|^baseurl=.*|baseurl=https://repos.fyralabs.com/terra$(rpm -E %fedora)/\$basearch/|" \
       /etc/yum.repos.d/terra.repo || true

# General
dnf5 -y --refresh install \ 
	brave-browser \
	zed rocminfo rocm-opencl rocm-clinfo rocm-hip distrobox

# Virtualisation
dnf5 install -y \
	@virtualization \
	virt-manager \
	qemu-kvm \
	libvirt \
	virt-viewer \
	bridge-utils

systemctl enable libvirtd
systemctl enable podman.socket