#!/bin/bash

printf "Installing Base Packages..."
pacstrap -i /mnt base base-devel linux linux-firmware linux-headers bash-completion vim amd-ucode

printf "Generating the fstab file..."
genstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab 

printf "Switch to chroot and copy the scripts into /mnt"

