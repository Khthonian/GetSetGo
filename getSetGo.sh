#!/bin/bash

# Update package lists and upgrade the system
sudo apt update && sudo apt upgrade -y

# Install common tools
sudo apt install -y curl wget build-essential

# Install git
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt update
sudo apt install -y git

# Install Zsh
sudo apt install -y zsh
chsh -s $(which zsh)

# Install Kitty Terminal
sudo apt install -y kitty

# Install Python
sudo apt install -y python3 python3-pip

# Install Lua
sudo apt install -y lua5.3

# Install Go
sudo apt install -y golang-go

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install GCC
sudo apt install -y gcc

# Install Anaconda
wget https://repo.anaconda.com/archive/Anaconda3-2023.07-2-Linux-x86_64.sh
bash Anaconda3-2023.07-2-Linux-x86_64.sh
rm Anaconda3-2023.07-2-Linux-x86_64.sh

# Ask the user for Git configurations
read -p "Enter your name for Git user.name: " git_username
read -p "Enter your email for Git user.email: " git_email

# Install Edge
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
sudo rm microsoft.gpg
sudo apt update
sudo apt install -y microsoft-edge-stable

# Install Discord
wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
sudo dpkg -i discord.deb
sudo apt install -fy

# Install Bitwarden
wget -O bitwarden.deb "https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=deb"
sudo dpkg -i bitwarden.deb
sudo apt install -fy

# Install Spotify
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install -y spotify-client

# Install VS Code
sudo apt install -y software-properties-common apt-transport-https curl
curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt install -y code

# Configure git
git config --global user.name "$git_username"
git config --global user.email "$git_email"
git config --global init.defaultBranch main
git config --global color.ui auto
git config --global pull.rebase false

# Clean up downloaded .deb files
rm discord.deb bitwarden.deb

# Install nvm
sudo apt update
sudo apt upgrade
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install node
nvm install --lts
nvm use --lts

echo "Installation complete!"
