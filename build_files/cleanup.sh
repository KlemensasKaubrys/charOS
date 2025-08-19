#!/usr/bin/env bash
set -euo pipefail

rm -rf /usr/etc || true
rm -rf /boot || true
mkdir -p /boot

rm -rf /tmp/* || true
find /var/* -maxdepth 0 -type d ! -name cache ! -name log -exec rm -rf {} \; || true
find /var/cache/* -maxdepth 0 -type d ! -name libdnf5 -exec rm -rf {} \; || true
dnf5 clean all || true

mkdir -p /tmp /var/tmp
chmod 1777 /tmp /var/tmp

find /var/log -type f -exec truncate -s 0 {} + 2>/dev/null || true
find /var -type f -name '*.lock' -delete 2>/dev/null || true

ln -snf "/usr/share/fonts/google-noto-sans-cjk-fonts" "/usr/share/fonts/noto-cjk" || true
sed -Ei "s/secure_path = (.*)/secure_path = \1:\/home\/linuxbrew\/.linuxbrew\/bin/" /etc/sudoers || true

systemctl enable rpm-ostreed-automatic.timer || true
systemctl enable flatpak-system-update.timer || true
systemctl --global enable flatpak-user-update.timer || true
