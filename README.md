### Arch-Installation-Scripts
    (For personal use)

1. If needed, load your keymap
2. Connect to the internet
    `iwctl`
    `station wlan0 connect namewifi password`

3. Refresh the servers with pacman -Syy
4. Partition the disk
    - Create disk partitions
      `gdisk /dev/nvme0n1`
        > efi_system_partition: +300Mount
        > swap_partition: +1G 
        > root_partition: 
    - Format boot, swap and file system partitions 
      `mkfs.fat -F32 /dev/nvme0n1p1`
      `mkswap /dev/nvme0n1p2`
      `swapon /dev/nvme0n1p2`
      `mkfs.etx4 /dev/nvme0n1p3`
    - Mount system disk partition
      `mount /dev/nvme0n1p3 /mnt`
    - Create boot directory and mount *
      `mkdir -p /mnt/boot/efi`
      `mount /dev/nvme0n1p1 /mnt/boot/efi`
5. Clone Arch Installation Script 
    `git clone https://github.com/baamboohulk/arch-scripts.git`
6. Install the base packages into /mnt (pacstrap /mnt base linux linux-firmware git vim amd-ucode (or intel-ucode)) and Generate fstab
    `cd arch-scripts`
    `chmod +x pre-chroot-base-install.sh`
    Run with `./pre-chroot-base-install.sh`
7. Switch to arch chroot 
    `arch-chroot /mnt`
8. 
    `chmod +x post-chroot-base-install.sh`
    Run with `./post-chroot-base-install.sh`



