# GetSetGo

This BASH script automates the setup process for a fresh Ubuntu Linux system. It installs essential packages and configures various tools to streamline your development environment.

## Features

- Updates package lists and upgrades the system.
- Installs essential software:
  - curl
  - git
  - Microsoft Edge browser
  - Discord
  - Bitwarden password manager
  - Spotify
  - Visual Studio Code
  - Node.js and npm using nvm (Node Version Manager)
- Configures Git with your name and email.

## Usage

1. Clone this repository to your local machine or download the [script](system_setup_script.sh) directly.
2. Make the script executable:
   ```bash
   chmod +x system_setup_script.sh```
3. Run the script with superuser privileges:
   ```bash
   sudo ./system_setup_script.sh```

## Git Configuration
During the script execution, you will be prompted to provide your name and email for Git configuration. These values are used to set up your identity for Git commits.

## Disclaimer
- Use this script at your own risk. Although it has been designed to be safe and non-destructive, there might be unforeseen issues depending on your system's configuration.
- Before running the script, ensure you have a backup of your important data.

## License
This project is licensed under the [MIT License](LICENSE.md).

## Contributions
Contributions are welcome! If you find any issues or want to add new features, feel free to open an issue or submit a pull request.
