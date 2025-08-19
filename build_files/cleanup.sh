set -euo pipefail

rm -rf /usr/etc || true

dnf5 clean all || true

rm -rf /tmp/* /tmp/.[!.]* /tmp/..?* 2>/dev/null || true
mkdir -p /tmp && chmod 1777 /tmp
rm -rf /var/tmp/* /var/tmp/.[!.]* /var/tmp/..?* 2>/dev/null || true
mkdir -p /var/tmp && chmod 1777 /var/tmp

find /var/cache -mindepth 1 -maxdepth 1 \
  ! -name libdnf5 \
  ! -name rpm-ostree \
  -exec rm -rf {} + 2>/dev/null || true

rm -rf /var/lib/dnf /var/lib/xkb /var/lib/plocate 2>/dev/null || true
rm -f /var/lib/unbound/root.key 2>/dev/null || true
find /var/log -type f -exec truncate -s 0 {} + 2>/dev/null || true
find /var -type f -name '*.lock' -delete 2>/dev/null || true
