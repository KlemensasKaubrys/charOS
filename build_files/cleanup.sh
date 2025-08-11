#!/usr/bin/env bash
set -euo pipefail

dnf5 clean all

rm -rf /tmp/* /tmp/.[!.]* /tmp/..?* 2>/dev/null || true
mkdir -p /tmp
chmod 1777 /tmp

rm -rf /var/tmp/* /var/tmp/.[!.]* /var/tmp/..?* 2>/dev/null || true
mkdir -p /var/tmp
chmod 1777 /var/tmp

find /var/cache -mindepth 1 -maxdepth 1 \
  ! -name libdnf5 \
  ! -name rpm-ostree \
  -exec rm -rf {} +

find /var/log -type f -exec truncate -s 0 {} \;

find /var -type f -name '*.lock' -delete
