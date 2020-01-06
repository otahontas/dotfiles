# (Windows 10 installation)
- I'm suggesting to go through this first, since it makes efi-boot -configuration easier
- Boot from Windows 10 bootable media
- Install Windows 10 normally, but resize boot partition during installation. If this is not done, the default boot partition is quite likely to be too small for Win 10 and Arch boot images.
    - Check out this guide: <https://www.ctrl.blog/entry/how-to-esp-windows-setup.html>
- Check that everything installed correctly.

# Arch installation
- Mainly follow: https://wiki.archlinux.org/index.php/Installation_guide
- Notable customisations during installation:
    - Partitioning with LUKS + LVM:
        - (If you didn't install windows 10, create boot partition at this point)
        - Check out: <https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS>
            - Create suitable swap and let root fill up rest of the space
        - Give label for root `cryptsetup config --label="arch_os" /dev/diskname`, so label can be used with bootloader later
        - mount root, mount boot, make swap
        - congigure mkinitcpio.conf (check [etc/mkinitcpio.conf](https://github.com/otahontas/dotfiles/blob/master/etc/mkinitcpio.conf)] and add necessary hooks
    - install git and iwd (to clone and install this repo later)
    - Configure bootloader:
        - install lvm and intel-microcodes
        - install bootctl
        - configure loader.conf and arch entry (check [/boot/loader/entries/arch.conf](https://github.com/otahontas/dotfiles/blob/master/boot/loader/entries/arch.conf)] and add necessary hooks
    - set zsh as default shell for root chsh -s /bin/zsh
    - create new user 
    ```
    useradd -m -g users -G wheel,input,video,docker -s /bin/zsh USERNAME
    passwd USERNAME
    EDITOR=vi visudo (uncomment sudo access for wheel)

    ```
    - exit, umount -R /mnt and reboot
- After install stuff
    - login with created account
    - Enable and start systemd-resolved and iwd, connect to wifi
    - (install firefox if needed)
    - Clone this repo
    - Install packages with `pacman -S --needed - < packages/pkglist.txt`
    - Install aur packages
    - Symlink .pam_environment with installation_scripts/create_pam_symlink.sh
    - Reboot
    - Check that files in boot and etc (like bootloader and systemd services) listed in this repo are in place in system /boot and /etc too
    - Run installation_scripts/install_dotfiles.sh
    - Unmute alsa
    - Delete root password and lock root `passwd -dl root`
