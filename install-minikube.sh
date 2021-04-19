# Install packages for KVM
sudo pacman -S --noconfirm --needed qemu qemu-arch-extra libvirt bridge-utils virt-manager ebtables dnsmasq

# Add user to necessary groups
sudo usermod -a -G libvirt $(whoami)
newgrp libvirt

# Enable libvirtd
sudo systemctl start libvirtd.service
sudo systemctl enable libvirtd.service
sudo systemctl start virtlogd.service
sudo systemctl enable virtlogd.service

# Install docker-machine and kvm2 driver
sudo pacman -S --noconfirm --needed docker-machine
paru -S docker-machine-driver-kvm2

# Install minikube
paru -S minikube-bin

# Restart libvirtd for good measure. Shouldn't have to but seems to help
sudo systemctl restart libvirtd.service
