#!/bin/bash

# Define a function to update and upgrade system
update_system() {
    #
    sudo apt update && sudo apt upgrade -y || {
        echo "Update failed"
        exit 1
    }
}

# Define a function to install curl
install_curl() {
    sudo apt install -y curl || {
        echo "Curl installation failed"
        exit 1
    }
}

# Define a function to install wget
install_wget() {
    sudo apt install -y wget || {
        echo "Wget installation failed"
        exit 1
    }
}

# Define a function to install build-essentials
install_build_essentials() {
    sudo apt install -y build-essential || {
        echo "Build-essentials installation failed"
        exit 1
    }
}

# Define a function to install Git fro the Git-core PPA
install_git() {
    sudo add-apt-repository -y ppa:git-core/ppa
    sudo apt update
    sudo apt install -y git
    if [ $? -eq 0 ]; then
        echo "Git installation successful"
        configure_git
    else
        echo "Git installation failed"
        exit 1
    fi
}

# Define a function to install Zsh and switch the default shell for the user who initiates the script
install_zsh() {
    sudo apt install -y zsh || {
        echo "Zsh installation failed"
        exit 1
    }
    # Determine the user who ran the script
    if [ ! -z "$SUDO_USER" ]; then
        user="$SUDO_USER"
    else
        user="$(whoami)"
    fi
    # Get the current shell for the user
    user_shell=$(getent passwd $user | cut -d: -f7)
    # Switch the default user shell to Zsh
    chsh -s $(which zsh) $user || {
        echo "Changing default shell to Zsh failed"
        exit 1
    }
    echo "Default shell for $user changed from $user_shell to $(which zsh)"
}

# Define a function to install Fish and switch the default shell for the user who initiates the script
install_fish() {
    sudo apt-add-repository ppa:fish-shell/release-3
    sudo apt update
    sudo apt install -y fish || {
        echo "Fish installation failed"
        exit 1
    }
    # Determine the user who ran the script
    if [ ! -z "$SUDO_USER" ]; then
        user="$SUDO_USER"
    else
        user="$(whoami)"
    fi
    # Get the current shell for the user
    user_shell=$(getent passwd $user | cut -d: -f7)
    # Switch the default user shell to Fish
    chsh -s $(which fish) $user || {
        echo "Changing default shell to Fish failed"
        exit 1
    }
    echo "Default shell for $user changed from $user_shell to $(which fish)"
}

# Define a function to install Kitty terminal
install_kitty() {
    sudo apt install -y kitty || {
        echo "Kitty installation failed"
        exit 1
    }
}

# Define a function to install Python 3 with pip
install_python() {
    sudo apt install -y python3 python3-pip || {
        echo "Python installation failed"
        exit 1
    }
}

# Define a function to install Lua
install_lua() {
    # TODO: Update the version when necessary
    sudo apt install -y lua5.3 || {
        echo "Lua installation failed"
        exit 1
    }
}

# Define a function to install Go
install_go() {
    sudo apt install -y golang-go || {
        echo "Go installation failed"
        exit 1
    }
}

# Define a function to install Rust
install_rust() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh || {
        echo "Rust installation failed"
        exit 1
    }
}

# Define a function to install GCC compiler
install_gcc() {
    sudo apt install -y gcc || {
        echo "GCC installation failed"
        exit 1
    }
}

# Define a function to install Anaconda
install_anaconda() {
    # TODO: Update the version when necessary
    wget https://repo.anaconda.com/archive/Anaconda3-2023.07-2-Linux-x86_64.sh
    bash Anaconda3-2023.07-2-Linux-x86_64.sh
    rm Anaconda3-2023.07-2-Linux-x86_64.sh || {
        echo "Anaconda installation failed"
        exit 1
    }
    # Update Anaconda
    source ~/anaconda3/bin/activate
    conda update -y --all || {
        echo "Anaconda update failed"
        exit 1
    }
}

# Define a function to ask the user for Git configurations
configure_git() {
    read -p "Enter your name for Git user.name: " git_username
    read -p "Enter your email for Git user.email: " git_email

    # Validate the configuration inputs
    if [[ -z "$git_username" || -z "$git_email" ]]; then
        echo "Git username or email cannot be empty."
        exit 1
    fi

    # Configure Git with user inputs
    git config --global user.name "$git_username"
    git config --global user.email "$git_email"
    git config --global init.defaultBranch main
    git config --global color.ui auto
    git config --global pull.rebase false || {
        echo "Git configuration failed"
        exit 1
    }
}

# Define a function to install Microsoft Edge browser
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

# Define a function to install Discord
install_discord() {
    wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
    sudo dpkg -i discord.deb
    sudo apt install -fy
    rm discord.deb || {
        echo "Discord installation failed"
        exit 1
    }
}

# Define a function to install Bitwarden
install_bitwarden() {
    wget -O bitwarden.deb "https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=deb"
    sudo dpkg -i bitwarden.deb
    sudo apt install -fy
    rm bitwarden.deb || {
        echo "Bitwarden installation failed"
        exit 1
    }
}

# Define a function to install Spotify
install_spotify() {
    curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt update
    sudo apt install -y spotify-client || {
        echo "Spotify installation failed"
        exit 1
    }
}

# Define a function to install Visual Studio Code
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

# Define a function to install Vim
install_vim() {
    sudo apt install -y vim || {
        echo "Vim installation failed"
        exit 1
    }
}

# Define a function to install Neovim
install_neovim() {
    sudo apt install -y neovim || {
        echo "NeoVim installation failed"
        exit 1
    }
}

# Define a function to install Mozilla Firefox browser
install_firefox() {
    sudo apt install -y firefox || {
        echo "Firefox installation failed"
        exit 1
    }
}

# Define a function to install Google Chrome browser
install_chrome() {
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    sudo apt install -fy
    rm google-chrome-stable_current_amd64.deb || {
        echo "Google Chrome installation failed"
        exit 1
    }
}

# Define a function to install tmux multiplexer
install_tmux() {
    sudo apt install -y tmux || {
        echo "tmux installation failed"
        exit 1
    }
}

# Define a function to install htop process viewer
install_htop() {
    sudo apt install -y htop || {
        echo "htop installation failed"
        exit 1
    }
}

# Define a function to install nvm and Node
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

# Define a function to prompt user for selection within a category
select_from_category() {
    local category_name="$1"
    declare -n options="$2"
    local selections=()

    # Print the options + the "Skip category" option
    echo -e "\nSelect from the $category_name category:"
    local i=1
    for key in "${!options[@]}"; do
        echo "$i) $key"
        i=$((i + 1))
    done
    echo "$i) Skip category"

    local valid_input=false
    while [ "$valid_input" == "false" ]; do
        read -p "Enter your choices (comma-separated, e.g., 1,2,3): " user_choices
        IFS=',' read -ra selections <<<"$user_choices"

        # Validate user input
        valid_input=true
        for selection in "${selections[@]}"; do
            if [[ "$selection" -lt 1 || "$selection" -gt "$i" ]]; then
                echo "Invalid option in $category_name category. Please choose numbers between 1 and $i."
                valid_input=false
                break
            fi
        done
    done

    # Check for the "Skip category" option
    if [[ " ${selections[*]} " == *" $i "* ]]; then
        echo "Skipping $category_name category."
        return
    fi

    # Execute and install the selected options
    for selection in "${selections[@]}"; do
        index=$((selection - 1))
        if [ "$index" -ge 0 ] && [ "$index" -lt "${#options[@]}" ]; then
            eval "${options[$index]}"
        fi
    done
}

# Main function to guide user through category selections
main() {
    update_system

    declare -A common_tools=(
        ["Curl"]="install_curl"
        ["Wget"]="install_wget"
        ["Build-essentials"]="install_build_essentials"
    )
    select_from_category "Common Tools" common_tools

    declare -A terminal_tools=(
        ["Kitty"]="install_kitty"
        ["Zsh"]="install_zsh"
        ["Fish"]="install_fish"
    )
    select_from_category "Terminal" terminal_tools

    declare -A dev_tools=(
        ["Git"]="install_git"
        ["GCC"]="install_gcc"
        ["Anaconda"]="install_anaconda"
        ["Node.js"]="install_node"
    )
    select_from_category "Development Tools" dev_tools

    declare -A languages=(
        ["Python"]="install_python"
        ["Lua"]="install_lua"
        ["Go"]="install_go"
        ["Rust"]="install_rust"
    )
    select_from_category "Languages" languages

    declare -A text_editors=(
        ["VS Code"]="install_vscode"
        ["Vim"]="install_vim"
        ["NeoVim"]="install_neovim"
    )
    select_from_category "Text Editors" text_editors

    declare -A browsers=(
        ["Microsoft Edge"]="install_edge"
        ["Mozilla Firefox"]="install_firefox"
        ["Google Chrome"]="install_chrome"
    )
    select_from_category "Web Browsers" browsers

    declare -A media=(
        ["Discord"]="install_discord"
        ["Spotify"]="install_spotify"
    )
    select_from_category "Media" media

    declare -A utilities=(
        ["tmux"]="install_tmux"
        ["htop"]="install_htop"
        ["Bitwarden"]="install_bitwarden"
    )
    select_from_category "Utilities" utilities

    configure_git
    echo "Installation complete!"
}

# Execute the main function
main
