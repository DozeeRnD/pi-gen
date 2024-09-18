# pi-gen for PUP

We use [pi-gen](pi-gen_README.md)

## Build image

`./build-docker.sh`

## Install image to a microSD card

```bash
dd bs=1M if=raspbian-lite-PUP.img of=/dev/sda status=progress
```

Replace `/dev/sda` with the correct device. Use `lsblk` to find the right device.

After installation, copy `PUP-connection-variables` file to the boot partition in microSD

## Docker cleanup

Delete all containers including its volumes:
```bash
docker rm -vf $(docker ps -a -q)
```

Delete all images:
```bash
docker rmi -f $(docker images -a -q)
```