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
sudo systemctl enable tailscaled.service
sudo systemctl start tailscaled.service

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

# Install all basic deps
## OpenSSL is already installed by default on Arch systems.
sudo pacman -S --needed --noconfirm base-devel clang lz4 docker

# Enable and start docker service
sudo systemctl enable docker.service
sudo systemctl start docker.service

# Add current user to the docker group
sudo gpasswd -a ${whoami} docker

# Clone readyset repo
eval cd "${gitrepo}"
git clone git@github.com:readysettech/readyset.git
cd readyset

# Build release
cargo build --release
