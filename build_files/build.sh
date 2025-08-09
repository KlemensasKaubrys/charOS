#!/bin/bash

set -ouex pipefail

dnf5 install -y rocminfo rocm-opencl rocm-clinfo rocm-hip

echo "== Inspect /opt state =="
ls -ld /opt || true
ls -ld /var/opt || true
namei -l /opt || true
namei -l /opt/brave.com || true

echo "== Fix /opt symlink (ostree default is /opt -> ../var/opt) =="
if [ -e /opt ] && [ ! -L /opt ]; then
  rm -rf /opt
fi
[ -L /opt ] || ln -s ../var/opt /opt
mkdir -p /var/opt

echo "== Remove conflicting paths if they are not directories =="
if [ -e /opt/brave.com ] && [ ! -d /opt/brave.com ]; then rm -f /opt/brave.com; fi
if [ -e /var/opt/brave.com ] && [ ! -d /var/opt/brave.com ]; then rm -f /var/opt/brave.com; fi

echo "== Check for tmpfiles entries that create symlinks =="
grep -R --line-number -E 'brave\.com|/var/opt|/opt' /usr/lib/tmpfiles.d /etc/tmpfiles.d || true


dnf5 install -y brave-browser

systemctl enable podman.socket
