#!/bin/bash

set -ouex pipefail

dnf5 install -y rocminfo rocm-opencl rocm-clinfo rocm-hip

dnf5 install -y brave-browser

systemctl enable podman.socket
