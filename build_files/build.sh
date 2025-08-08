#!/bin/bash

set -ouex pipefail

dnf5 install -y rocminfo rocm-opencl rocm-clinfo rocm-hip


systemctl enable podman.socket
