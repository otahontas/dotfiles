# (Windows 10 installation if dual-booting) 
- Create Win10 bootable media
- Boot from Arch bootable media and format disk with `gdisk` (or your favourite tool)
    - Empty disk and create new partition gtp partition tabl
    - create partitions for EFI (partiontype ef00) and Arch. Leave rest for Win
- Boot from Win10 bootable media
- Install Windows 10 with custom installation steps and let it only use unallocated space
- Check that everything installed correctly.
- Go through necessary steps in <https://wiki.archlinux.org/index.php/Dual_boot_with_Windows>
    - at least disable Fast Startup and configure Windows to use UTC

# Arch installation
- Mainly follow: https://wiki.archlinux.org/index.php/Installation_guide
- Notable customisations during installation:
    - Partitioning with LUKS + LVM:
        - (If you didn't install windows 10, you also need to create boot partition at this point)
        - Check out: <https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS>
        - Give label for root `cryptsetup config --label="arch_os" /dev/diskname`, so label can be used with bootloader later. Do this before opening created luks.
        - Create suitable swap and let root fill up rest of the space
        - mount root, mount boot, make swap
        - congigure mkinitcpio.conf (check [etc/mkinitcpio.conf](https://github.com/otahontas/dotfiles/blob/master/etc/mkinitcpio.conf)] and add necessary hooks
    - install git and etckeeper. Initialize etckeeper. 
        - Skip this part if you want to use previosly used etckeeper repo.
    - Install iwd, nvim, zsh and sudo.
    - Configure bootloader:
        - install lvm and intel-ucode
        - install bootctl
        - configure loader.conf and arch entry (check [/boot/loader/entries/arch.conf](https://github.com/otahontas/dotfiles/blob/master/boot/loader/entries/arch.conf)] and add necessary hooks
    - set zsh as default shell for root chsh -s /bin/zsh
    - create new user 
    ```
    useradd -m -g users -G wheel,input,video,docker -s /bin/zsh USERNAME
    passwd USERNAME
    EDITOR=nvim visudo (uncomment sudo access for wheel)

    ```
    - exit, umount -R /mnt and reboot
- After install stuff
    - login with created account
    - Connect to wifi (with iwd and systemd-resolved on this setup)
    - Clone this repo 
    - Rename dotfiles-folder to ~/.config
    - Symlink .pam_environment to $HOME/.pam_environment
    - Install packages with `pacman -S --needed - < packages/pkglist.txt`
        - Act upon alerts while installing
    - Clone aur packages with installation_scripts/check_aur_packages.sh
        - This runs git clone for each package in package list and checks if they're already installed
        - Install packages with makepkg `srci` or pacman -U package if package is part of package group
    - Reboot
    - Run installation_scripts/finalize.sh
        - This creates some directories and symlinks stuff from ~/.config to other directories
    - Check what has changed in .config with `git diff`, fix if necessary
    - Check that files in boot and etc (like bootloader and systemd services) listed in this repo are in place in system /boot and /etc too
        - fix if necessary
    - Delete root password and lock root `passwd -dl root`
