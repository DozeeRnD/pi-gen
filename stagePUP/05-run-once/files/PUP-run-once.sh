#!/bin/bash

HOSTNAME=PUP-$(cat /proc/cpuinfo | grep Serial | grep -o '..........$')

source /boot/firmware/PUP-connection-variables

set -euxo pipefail

echo "country=IN" > /etc/wpa_supplicant/wpa_supplicant.conf
echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "update_config=1" >> /etc/wpa_supplicant/wpa_supplicant.conf
if [[ -v WIFI_SSID && -v WIFI_PASSWORD ]]; then
      nmcli connection add type wifi con-name "${WIFI_SSID}" ssid "${WIFI_SSID}" ifname wlan0 autoconnect yes save yes
      nmcli connection modify "${WIFI_SSID}" wifi-sec.key-mgmt wpa-psk wifi-sec.psk "${WIFI_PASSWORD}"
      nmcli connection modify "${WIFI_SSID}" connection.autoconnect-priority 999
fi
if [[ -v WIFI2_SSID && -v WIFI2_PASSWORD ]]; then
      nmcli connection add type wifi con-name "${WIFI2_SSID}" ssid "${WIFI2_SSID}" ifname wlan0 autoconnect yes save yes
      nmcli connection modify "${WIFI2_SSID}" wifi-sec.key-mgmt wpa-psk wifi-sec.psk "${WIFI2_PASSWORD}"
      nmcli connection modify "${WIFI2_SSID}" connection.autoconnect-priority 99
fi

hostnamectl hostname ${HOSTNAME}
sed -i "s/PUP-tobeset/${HOSTNAME}/" /etc/hosts

teleport node configure \
      --silent \
      --token ${TELEPORT_TOKEN} \
      --ca-pin sha256:a0d153e93ee8d68af8c2282bfb10a45e32ff2c5448027ca109a742ca61db68b4 \
      --proxy teleport.tstrnd.com:443 \
      --labels "device=RPiZero2W,project=PUP" \
      --output /etc/teleport.yaml

systemctl enable teleport.service

systemctl disable PUP-run-once

reboot
