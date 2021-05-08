#!/bin/bash

set -e

echo Welcome to ReadySet! Let\s get you setup!
read -p 'Clone readyset git repo to: ' gitrepo

#####################################
##    General Work Dependencies    ##
#####################################

## Start with repo update & pkg upgrade
sudo pacman -Syu

# Install tailscale for work vpn
sudo pacman -S --needed --noconfirm tailscale

# enable and start tailscale
sudo systemctl enable --now tailscaled.service
sleep 1
sudo systemctl start tailscaled.service
sleep 1

# Bring tailscale up - note, this will require you clicking a link and
# authenticating with SSO login
sudo tailscale up

#####################################
## ReadySet (Product) Dependencies ##
#####################################

# Install rust
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env

# Install nightly rust
rustup install nightly

# Install RLS
rustup component add rls rust-analysis rust-src

# Install mdbook
cargo install mdbook

# Install all basic deps
## OpenSSL is already installed by default on Arch systems.
sudo pacman -S --needed --noconfirm base-devel clang lz4 docker

# Enable and start docker service
sudo systemctl enable docker.service
sudo systemctl start docker.service

# Add current user to the docker group
sudo gpasswd -a $(whoami) docker

# Install MariaDB clients
sudo pacman -S mariadb-clients

# Clone readyset repo
eval cd "${gitrepo}"
git clone git@github.com:readysettech/readyset.git
cd readyset

# Build release
cargo build --release

# Install UI deps
sudo pacman -S --noconfirm --needed python-pip
pip3 install pystache

# Install graphviz package for creating useful graphs
sudo pacman -S --noconfirm --needed graphviz

echo 'All finished! Please add $HOME/.cargo/bin to your PATH permanentely.'
