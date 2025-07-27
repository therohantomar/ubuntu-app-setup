#!/bin/bash

echo "🔄 Updating APT packages..."
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y
sudo apt clean

echo "📦 Updating global npm packages..."
sudo npm install -g npm yarn pnpm

echo "⚡ Updating Bun..."
bun upgrade

echo "🦕 Updating Deno..."
deno upgrade

echo "🚀 Updating Volta-managed tools..."
volta install node
volta install npm
volta install yarn
volta install pnpm

echo "🧠 Updating VS Code..."
sudo apt install --only-upgrade code -y

echo "🧠 Updating Zed Editor..."
ZED_DEB="zed-latest.deb"
wget https://zed.dev/api/releases/zed-latest.deb -O "$ZED_DEB"
sudo apt install -y ./$ZED_DEB
rm "$ZED_DEB"

echo "🌐 Updating Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

echo "🐳 Updating Docker..."
sudo apt install --only-upgrade docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

echo "✅ All updates complete!"
