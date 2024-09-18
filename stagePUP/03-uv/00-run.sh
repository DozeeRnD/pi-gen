#!/bin/bash -e

set -x

install -v -m 0755 -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.local"
install -v -m 0755 -o 1000 -g 1000 -d "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.local/bin"
install -v -m 755 -o 1000 -g 1000  files/uv "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.local/bin"
