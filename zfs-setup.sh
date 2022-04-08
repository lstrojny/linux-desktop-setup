#!/bin/sh

set -x

if [ -z "$1" ]; then
    echo "Specify disk"
    exit 1
fi

DISK=$1

parted $DISK -- mklabel gpt

sgdisk -n3:1M:+512M -t3:EF00 $DISK
sgdisk -n2:512M:8G -t2:BF01 $DISK
sgdisk -n1:0:0 -t1:BF01 $DISK

zpool create \
    -O mountpoint=none \
    -O atime=off \
    -o ashift=12 \
    -O acltype=posixacl \
    -O xattr=sa \
    -O compression=lz4
    zroot $DISK-part1

zfs create -o mountpoint=legacy zroot/root
zfs create -o mountpoint=legacy zroot/root/nix
zfs create -o mountpoint=legacy -o devices=off -o setuid=off -o sync=disabled zroot/root/tmp
zfs create -o mountpoint=legacy -o devices=off -o setuid=off zroot/root/var
zfs create -o mountpoint=legacy -O encryption=aes-256-gcm -O keyformat=passphrase zroot/root/home

mkswap $DISK-part2
mkfs.vfat $DISK-part3
