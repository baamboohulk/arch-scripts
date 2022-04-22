#!/bin/bash

# Set local time (ls /usr/share/zoneinfo)
ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime
hwclock --systohc
timedatectl set-timezone Europe/Riga
timedatectl set-ntp true

# Uncomment US and LV UTF-8 language 
sed -i '177s/.//' /etc/locale.gen
sed -i '332/.//' /etc/locale.gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

locale-gen

echo "archlinux" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 archlinux.localdomain archlinux" >> /etc/hosts

# Change root password to archlinux (default password: archlinux) - CHANGE IT LATER!
echo root:password | chpasswd

# Install packages. Default AMD CPU
# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or virt-manager
pacman -S --noconfirm grub efibootmgr networkmanager network-manager-applet wpa_supplicant wireless_tools netctl dialog mtools dosfstools base-devel linux-headers git reflector bluez bluez-utils cups hplip xdg-utils xdg-user-dirs inetutils dnsutils bash-completion tlp powertop alsa-utils pulseaudio pulseaudio-bluetooth acpi acpi_call rsync nfs-utils gvfs gvfs-smb openssh xf86-video-amdgpu nvidia nvidia-utils nvidia-settings avahi pipewire pipewire-alsa pipewire-pulse pipewire-jack tlp virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB         #change the directory to /boot/efi is you mounted the EFI partition at /boot/efi
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth 
systemctl enable cups
systemctl enable sshd 
systemctl enable tlp    # You can comment this command out if you didn't install tlp, see above
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable avahi-daemon
systemctl enable acpid


# Add user and set password (default password user: arch, password: arch)
useradd -m user
echo user:password | chpasswd
usermod -aG libvirt arch
echo "user ALL=(ALL) ALL" >> /etc/sudoers.d/user


/bin/echo -e "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
