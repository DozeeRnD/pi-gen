#!/bin/bash -e

set -x

on_chroot << EOF
    chsh -s /usr/bin/fish ${FIRST_USER_NAME}
    su -c "fish -c \"fish_add_path /home/${FIRST_USER_NAME}/.local/bin -m\"" ${FIRST_USER_NAME}
EOF