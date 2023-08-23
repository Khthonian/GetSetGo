#!/bin/bash

# Function to update and upgrade system
update_system() {
    sudo apt update && sudo apt upgrade -y || {
        echo "Update failed"
        exit 1
    }
}

# Function to install common tools
install_common_tools() {
    sudo apt install -y curl wget build-essential || {
        echo "Common tools installation failed"
        exit 1
    }
}

# Function to install Git
install_git() {
    sudo add-apt-repository -y ppa:git-core/ppa
    sudo apt update
    sudo apt install -y git || {
        echo "Git installation failed"
        exit 1
    }
}

# Function to install Zsh
install_zsh() {
    sudo apt install -y zsh || {
        echo "Zsh installation failed"
        exit 1
    }
    if [ ! -z "$SUDO_USER" ]; then
        user="$SUDO_USER"
    else
        user="$(whoami)"
    fi
    user_shell=$(getent passwd $user | cut -d: -f7)
    chsh -s $(which zsh) $user || {
        echo "Changing default shell to Zsh failed"
        exit 1
    }
    echo "Default shell for $user changed from $user_shell to $(which zsh)"
}

# Function to install Kitty Terminal
install_kitty() {
    sudo apt install -y kitty || {
        echo "Kitty installation failed"
        exit 1
    }
}

# Function to install Python
install_python() {
    sudo apt install -y python3 python3-pip || {
        echo "Python installation failed"
        exit 1
    }
}

# Function to install Lua
install_lua() {
    sudo apt install -y lua5.3 || {
        echo "Lua installation failed"
        exit 1
    }
}

# Function to install Go
install_go() {
    sudo apt install -y golang-go || {
        echo "Go installation failed"
        exit 1
    }
}

# Function to install Rust
install_rust() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh || {
        echo "Rust installation failed"
        exit 1
    }
}

# Function to install GCC
install_gcc() {
    sudo apt install -y gcc || {
        echo "GCC installation failed"
        exit 1
    }
}

# Function to install Anaconda
install_anaconda() {
    wget https://repo.anaconda.com/archive/Anaconda3-2023.07-2-Linux-x86_64.sh
    bash Anaconda3-2023.07-2-Linux-x86_64.sh
    rm Anaconda3-2023.07-2-Linux-x86_64.sh || {
        echo "Anaconda installation failed"
        exit 1
    }
    source ~/anaconda3/bin/activate
    conda update -y --all || {
        echo "Anaconda update failed"
        exit 1
    }
}

# Function to ask the user for Git configurations
configure_git() {
    read -p "Enter your name for Git user.name: " git_username
    read -p "Enter your email for Git user.email: " git_email

    if [[ -z "$git_username" || -z "$git_email" ]]; then
        echo "Git username or email cannot be empty."
        exit 1
    fi

    git config --global user.name "$git_username"
    git config --global user.email "$git_email"
    git config --global init.defaultBranch main
    git config --global color.ui auto
    git config --global pull.rebase false || {
        echo "Git configuration failed"
        exit 1
    }
}

# Function to install Edge
install_edge() {
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >microsoft.gpg
    sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
    sudo rm microsoft.gpg
    sudo apt update
    sudo apt install -y microsoft-edge-stable || {
        echo "Microsoft Edge installation failed"
        exit 1
    }
}

# Function to install Discord
install_discord() {
    wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
    sudo dpkg -i discord.deb
    sudo apt install -fy
    rm discord.deb || {
        echo "Discord installation failed"
        exit 1
    }
}

# Function to install Bitwarden
install_bitwarden() {
    wget -O bitwarden.deb "https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=deb"
    sudo dpkg -i bitwarden.deb
    sudo apt install -fy
    rm bitwarden.deb || {
        echo "Bitwarden installation failed"
        exit 1
    }
}

# Function to install Spotify
install_spotify() {
    curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt update
    sudo apt install -y spotify-client || {
        echo "Spotify installation failed"
        exit 1
    }
}

# Function to install VS Code
install_vscode() {
    sudo apt install -y software-properties-common apt-transport-https curl
    curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
    sudo add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt update
    sudo apt install -y code || {
        echo "VS Code installation failed"
        exit 1
    }
}

# Function to install Vim
install_vim() {
  sudo apt install -y vim || { echo "Vim installation failed"; exit 1; }
}

# Function to install Neovim
install_neovim() {
  sudo apt install -y neovim || { echo "NeoVim installation failed"; exit 1; }
}

# Function to install Firefox
install_firefox() {
  sudo apt install -y firefox || { echo "Firefox installation failed"; exit 1; }
}

# Function to install Google Chrome
install_chrome() {
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i google-chrome-stable_current_amd64.deb
  sudo apt install -fy
  rm google-chrome-stable_current_amd64.deb || { echo "Google Chrome installation failed"; exit 1; }
}

# Function to install tmux
install_tmux() {
  sudo apt install -y tmux || { echo "tmux installation failed"; exit 1; }
}

# Function to install htop
install_htop() {
  sudo apt install -y htop || { echo "htop installation failed"; exit 1; }
}

# Function to install nvm and Node
install_node() {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm install --lts
    nvm use --lts || {
        echo "Node installation failed"
        exit 1
    }
}

# Main function to call all the other functions
main() {
    update_system
    install_common_tools
    install_git
    install_zsh
    install_kitty
    install_python
    install_lua
    install_go
    install_rust
    install_gcc
    install_anaconda
    configure_git
    install_edge
    install_discord
    install_bitwarden
    install_spotify
    install_vscode
    install_node

    echo "Installation complete!"
}

# Execute the main function
main
