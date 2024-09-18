#!/bin/bash

usage() {
    echo "Usage: $0 <PUP.img> <PUP-connection-variables file> <device>"
    echo "Example: $0 PUP.img PUP-connection-variables /dev/sdX"
    exit 1
}

if [ "$#" -ne 3 ]; then
    usage
fi

if [ ! -f "$1" ]; then
    echo "File not found: $1"
    usage
fi

if [ ! -f "$2" ]; then
    echo "File not found: $2"
    usage
fi

if [ ! -b "$3" ]; then
    echo "Device not found: $3"
    usage
fi

set -euxo pipefail

dd bs=1M if=$1 of=$3 status=progress
mkdir -p /tmp/pup-boot
mount ${3}1 /tmp/pup-boot
cp "$2" /tmp/pup-boot/
umount /tmp/pup-boot
sync