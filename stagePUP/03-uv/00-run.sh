#!/bin/bash -e

set -x

on_chroot << EOF
    su -c "curl -LsSf https://astral.sh/uv/install.sh | sh" ${FIRST_USER_NAME}
EOF
