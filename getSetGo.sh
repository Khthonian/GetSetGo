#!/bin/bash

# Check if yay is installed
if command -v yay >/dev/null 2>&1; then
    yay_installed=true
else
    yay_installed=false
    echo "Warning: yay is not currently installed. Some functions will be limited."
fi

# Define a function to update and upgrade system
update_system() {
    # Don't use --noconfirm for safety
    sudo pacman -Syu || {
        echo "Update failed."
        exit 1
    }
}

# Define a function to install curl
install_curl() {
    sudo pacman -S curl --noconfirm || {
        echo "curl installation failed."
        exit 1
    }
}

# Define a function to install wget
install_wget() {
    sudo pacman -S wget --noconfirm || {
        echo "wget installation failed."
        exit 1
    }
}

# Define a function to install base-devel
install_base_devel() {
    sudo pacman -S base-devel --noconfirm || {
        echo "base-devel installation failed."
        exit 1
    }
}

# Define a function to install yay
install_yay() {
    git clone https://aur.archlinux.org/yay.git || {
        echo "Failed to clone yay repository."
        exit 1
    }
    cd yay
    makepkg -si --noconfirm || {
        echo "yay installation failed."
        exit 1
    }
    cd ..
    rm -rf yay
    yay_installed=true
}

# Define a function to install Git
install_git() {
    sudo pacman -S git --noconfirm
    if [ $? -eq 0 ]; then
        echo "Git installation successful."
        configure_git
    else
        echo "Git installation failed."
        exit 1
    fi
}

# Define a function to install zsh and switch the default shell for the user who initiates the script
install_zsh() {
    sudo pacman -S zsh --noconfirm || {
        echo "zsh installation failed."
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
    # Switch the default user shell to zsh
    chsh -s $(which zsh) $user || {
        echo "Changing default shell to zsh failed."
        exit 1
    }
    echo "Default shell for $user changed from $user_shell to $(which zsh)."
}

# Define a function to install fish and switch the default shell for the user who initiates the script
install_fish() {
    sudo pacman -S fish --noconfirm || {
        echo "fish installation failed."
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
    # Switch the default user shell to fish
    chsh -s $(which fish) $user || {
        echo "Changing default shell to fish failed."
        exit 1
    }
    echo "Default shell for $user changed from $user_shell to $(which fish)."
}

# Define a function to install kitty terminal
install_kitty() {
    sudo pacman -S kitty --noconfirm || {
        echo "kitty installation failed."
        exit 1
    }
}

# Define a function to install Python 3 with pip
install_python() {
    sudo pacman -S python python-pip --noconfirm || {
        echo "Python installation failed."
        exit 1
    }
}

# Define a function to install Lua
install_lua() {
    sudo pacman -S lua || {
        echo "Lua installation failed."
        exit 1
    }
}

# Define a function to install Go
install_go() {
    sudo pacman -S go --noconfirm || {
        echo "Go installation failed."
        exit 1
    }
}

# Define a function to install Rust
install_rust() {
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh || {
        echo "Rust installation failed."
        exit 1
    }
}

# Define a function to install GCC compiler
install_gcc() {
    sudo pacman -S gcc --noconfirm || {
        echo "gcc installation failed."
        exit 1
    }
}

# Define a function to install Anaconda
install_anaconda() {
    # TODO: Update the version when necessary
    wget https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh
    bash Anaconda3-2023.09-0-Linux-x86_64.sh
    rm Anaconda3-2023.09-0-Linux-x86_64.sh || {
        echo "Anaconda installation failed."
        exit 1
    }
    # Update Anaconda
    source ~/anaconda3/bin/activate
    conda update -y --all || {
        echo "Anaconda update failed."
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
    git config --global pull.rebase true || {
        echo "Git configuration failed."
        exit 1
    }
}

# Define a function to install Microsoft Edge browser
install_edge() {
    if [ "$yay_installed" = true ]; then
        yay -S microsoft-edge-stable --noconfirm || {
            echo "Microsoft Edge installation failed."
            exit 1
        }
    else
        echo "Microsoft Edge unavailable without yay."
    fi
}

# Define a function to install Discord
install_discord() {
    sudo pacman -S discord --noconfirm || {
        echo "Discord installation failed."
        exit 1
    }
}

# Define a function to install Bitwarden
install_bitwarden() {
    sudo pacman -S bitwarden --noconfirm || {
        echo "Bitwarden installation failed."
        exit 1
    }
}

# Define a function to install Spotify
install_spotify() {
    if [ "$yay_installed" = true ]; then
        yay -S spotify --noconfirm || {
            echo "Spotify installation failed."
            exit 1
        }
    else
        echo "Spotify unavailable without yay."
    fi
}

# Define a function to install Visual Studio Code
install_vscode() {
    if [ "$yay_installed" = true ]; then
        yay -S visual-studio-code-bin --noconfirm || {
            echo "Visual Studio Code installation failed."
            exit 1
        }
    else
        echo "Visual Studio Code unavailable without yay."
    fi
}

install_code() {
    sudo pacman -S code --noconfirm || {
        echo "Code installation failed."
        exit 1
    }
}

# Define a function to install Vim
install_vim() {
    sudo pacman -S vim --noconfirm || {
        echo "Vim installation failed."
        exit 1
    }
}

# Define a function to install Neovim
install_neovim() {
    sudo pacman -S neovim --noconfirm || {
        echo "Neovim installation failed."
        exit 1
    }
}

# Define a function to install Mozilla Firefox browser
install_firefox() {
    sudo pacman -S firefox --noconfirm || {
        echo "Firefox installation failed."
        exit 1
    }
}

# Define a function to install Google Chrome browser
install_chrome() {
    if [ "$yay_installed" = true ]; then
        yay -S google-chrome --noconfirm || {
            echo "Google Chrome installation failed."
            exit 1
        }
    else
        echo "Google Chrome unavailable without yay."
    fi
}

install_chromium() {
    sudo pacman -S chromium --noconfirm || {
        echo "Chromium installation failed."
        exit 1
    }
}

# Define a function to install tmux multiplexer
install_tmux() {
    sudo pacman -S tmux --noconfirm || {
        echo "tmux installation failed."
        exit 1
    }
}

# Define a function to install htop process viewer
install_htop() {
    sudo pacman -S htop --noconfirm || {
        echo "htop installation failed."
        exit 1
    }
}

# Define a function to install btop process viewer
install_btop() {
    sudo pacman -S btop --noconfirm || {
        echo "btop installation failed."
        exit 1
    }
}

# Define a function to install nvm and Node
install_node() {
    # TODO: Implement check for pacman wrapper to install nvm from AUR
    sudo pacman -S nodejs --noconfirm || {
        echo "Node installation failed."
        exit 1
    }
}

# Define a function to install Steam
install_steam(){
    sudo pacman -S steam --noconfirm || {
        echo "Steam installation failed."
        exit 1
    }
}

# Define a function to install the Heroic launcher
install_heroic(){
    if [ "$yay_installed" = true ]; then
        yay -S heroic-games-launcher-bin || {
            echo "Heroic Games Launcher installation failed."
            exit 1
        }
    else
        echo "Heroic Games Launcher unavailable without yay."
    fi

}

# Define a function to install lutris
install_lutris(){
    sudo pacman -S lutris --noconfirm || {
        echo "Lutris installation failed."
        exit 1
    }
}

# Define a function to prompt user for selection within a category
select_from_category() {
    local category_name="$1"
    declare -n options="$2"
    local selections=()

    # Print the options
    echo -e "\\nSelect from the $category_name category:"
    local i=1
    local keys=("${!options[@]}")
    for key in "${keys[@]}"; do
        echo "$i) $key"
        i=$((i + 1))
    done

    # Prompt for user input and validate
    local valid_input=false
    while [ "$valid_input" == "false" ]; do
        read -p "Enter your choices (comma-separated, e.g., 1,2,3) or press Enter to skip: " user_choices
        if [ -z "$user_choices" ]; then
            echo "Skipping $category_name category."
            return
        fi

        IFS=',' read -ra selections <<<"$user_choices"
        valid_input=true
        for selection in "${selections[@]}"; do
            if ! [[ "$selection" =~ ^[0-9]+$ ]] || [[ "$selection" -lt 1 || "$selection" -gt "${#options[@]}" ]]; then
                echo "Invalid option in $category_name category. Please choose numbers between 1 and ${#options[@]} or press Enter to skip."
                valid_input=false
                break
            fi
        done
    done

    # Execute and install the selected options
    for selection in "${selections[@]}"; do
        index=$((selection - 1))
        func_name="${options[${keys[$index]}]}"
        if [ -n "$func_name" ]; then
            eval "$func_name"
        fi
    done
}

# Main function to guide user through category selections
main() {
    update_system

    declare -A common_tools=(
        ["curl"]="install_curl"
        ["wget"]="install_wget"
        ["base-devel"]="install_base_devel"
        ["yay"]="install_yay"
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
        ["gcc"]="install_gcc"
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
        ["Code"]="install_code"
        ["Vim"]="install_vim"
        ["Neovim"]="install_neovim"
    )
    select_from_category "Text Editors" text_editors

    declare -A browsers=(
        ["Microsoft Edge"]="install_edge"
        ["Mozilla Firefox"]="install_firefox"
        ["Google Chrome"]="install_chrome"
        ["Chromium"]="install_chromium"
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
        ["btop"]="install_btop"
        ["Bitwarden"]="install_bitwarden"
    )
    select_from_category "Utilities" utilities

    declare -A gaming=(
        ["Steam"]="install_steam"
        ["Heroic"]="install_heroic"
        ["Lutris"]="install_lutris"
    )
    select_from_category "Gaming" gaming

    echo "Installation complete!"
}

# Execute the main function
main
