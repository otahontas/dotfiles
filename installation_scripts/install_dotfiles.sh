#!/bin/sh

echo "=== DOTFILES INSTALLATION ==="
echo "This script will install dotfiles by setting necessary enviromental variables and doing some symlinkings. Sudo is needed and asked when necessary.\n"
echo "NOTE: This scripts backups your previours ~/.config folder to ~/.config.back!"
echo "NOTE: Script assumes you've installed all necessary applications first. If this is not the case, please quit and install applications"

read -p "Press y to continue or any other key to quit " choice
case "$choice" in 
  y|Y ) ;;
  * ) exit 1 ;;
esac

echo "Backing up old ~/.config folder"
config_folder=~/.config
dotfiles_folder=$PWD
mv $config_folder $config_folder.back
cp -r $dotfiles_folder $config_folder/

echo "Making sure all config scripts are executable by chmodding them"
find $config_folder -name "*.sh" -exec sudo chmod u+x {} \;

echo "Creating enviromental variables and symlinks"
/bin/sh $config_folder/installation_scripts/create_symlinks.sh

echo "// Everythign installed, check your ~/.config folder and reboot"
exit 0
