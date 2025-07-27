#!/bin/bash

echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y

echo "📦 Installing base tools..."
sudo apt install -y curl wget unzip git build-essential zsh neofetch ca-certificates gnupg lsb-release apt-transport-https software-properties-common

echo "🟢 Installing Node.js LTS..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

echo "📦 Installing pnpm and yarn..."
npm install -g pnpm yarn

echo "⚡ Installing Bun..."
curl -fsSL https://bun.sh/install | bash
echo 'export PATH="$HOME/.bun/bin:$PATH"' >> ~/.bashrc

echo "🦕 Installing Deno..."
curl -fsSL https://deno.land/install.sh | sh
echo 'export PATH="$HOME/.deno/bin:$PATH"' >> ~/.bashrc

echo "🚀 Installing Volta..."
curl https://get.volta.sh | bash
echo 'export VOLTA_HOME="$HOME/.volta"' >> ~/.bashrc
echo 'export PATH="$VOLTA_HOME/bin:$PATH"' >> ~/.bashrc

echo "🐳 Installing Docker..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg |
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "✅ Adding current user to Docker group..."
sudo usermod -aG docker $USER

echo "🧠 Installing Zed Editor..."
ZED_DEB="zed.deb"
wget https://zed.dev/api/releases/zed-latest.deb -O "$ZED_DEB"
sudo apt install -y ./$ZED_DEB
rm "$ZED_DEB"

echo "🧠 Installing VS Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/
sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/packages.microsoft.gpg] \
  https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code
rm packages.microsoft.gpg

echo "🌐 Installing Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

echo "💡 Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "✅ All tools installed successfully!"
echo "🔁 Run 'source ~/.bashrc' or restart your terminal."
echo "🚀 Chrome can be launched with: google-chrome"
