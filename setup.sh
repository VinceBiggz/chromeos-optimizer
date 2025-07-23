#!/bin/bash

# Title: ChromeOS Linux Dev Setup Script
# Author: Vincent Wachira
# Description: Automates Linux setup on ASUS Chromebook for productivity & security

# Load config from .env
source "$(dirname "$0")/.env"

# Helper: echo and log each step
log() {
  echo -e "\n==> $1"
}

# --- Step 1: APT Update & Upgrade ---
if [ "$PERFORM_APT_UPDATE" = true ]; then
  log "Updating APT repositories..."
  sudo apt update
fi

if [ "$PERFORM_APT_UPGRADE" = true ]; then
  log "Upgrading packages..."
  sudo apt upgrade -y
fi

# --- Step 2: Install APT Tools ---
log "Installing selected APT tools..."
sudo apt install -y $APT_TOOLS

# --- Step 3: Swap Configuration ---
if [ ! -f "$SWAP_FILE_PATH" ]; then
  log "Creating swap file at $SWAP_FILE_PATH (${SWAP_SIZE_MB}MB)..."
  sudo fallocate -l ${SWAP_SIZE_MB}M $SWAP_FILE_PATH
  sudo chmod 600 $SWAP_FILE_PATH
  sudo mkswap $SWAP_FILE_PATH
  sudo swapon $SWAP_FILE_PATH
  echo "$SWAP_FILE_PATH none swap sw 0 0" | sudo tee -a /etc/fstab
else
  log "Swap file already exists at $SWAP_FILE_PATH"
fi

log "Setting swappiness to $SWAPPINESS"
echo "vm.swappiness=$SWAPPINESS" | sudo tee /etc/sysctl.d/99-swappiness.conf
sudo sysctl -p /etc/sysctl.d/99-swappiness.conf

# --- Step 4: UFW Firewall Configuration ---
if [ "$CONFIGURE_UFW" = true ]; then
  log "Configuring UFW firewall..."
  sudo apt install -y ufw
  if [ "$UFW_DEFAULT_DENY_INCOMING" = true ]; then sudo ufw default deny incoming; fi
  if [ "$UFW_ALLOW_OUTGOING" = true ]; then sudo ufw default allow outgoing; fi
  if [ "$UFW_ALLOW_SSH" = true ]; then sudo ufw allow ssh; fi
  sudo ufw --force enable
fi

# --- Step 5: Security - Unattended Upgrades ---
if [ "$ENABLE_UNATTENDED_UPGRADES" = true ]; then
  log "Enabling unattended-upgrades..."
  sudo apt install -y unattended-upgrades
  sudo dpkg-reconfigure --priority=low unattended-upgrades
fi

# --- Step 6: Optional Tools ---
if [ "$ENABLE_FLATPAK" = true ]; then
  log "Installing Flatpak..."
  sudo apt install -y flatpak
fi

if [ "$ENABLE_SNAPD" = true ]; then
  log "Installing Snapd..."
  sudo apt install -y snapd
fi

# --- Step 7: Cleanup ---
if [ "$CLEAN_UP" = true ]; then
  log "Cleaning up unused packages..."
  sudo apt autoremove -y
  sudo apt autoclean -y
fi

log "✅ System setup complete!"
