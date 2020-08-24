# (Windows 10 installation if dual-booting) 
- Create Win10 bootable media
  - if using linux distro, check out <https://techbit.ca/2019/02/creating-a-bootable-windows-10-uefi-usb-drive-using-linux/>
- Boot from Arch bootable media and format disk with `gdisk` (or your favourite tool)
    - Empty disk and create new partition gtp partition tabl
    - create partitions for EFI (partiontype ef00) and Arch. Leave rest for Win
- Boot from Win10 bootable media
- Install Windows 10 with custom installation steps and let it only use unallocated space
- Note: Win10 will try to force you into creating Microsoft account, avoid this by disconnecting from wifi / lan ([more info here](https://www.howtogeek.com/442609/confirmed-windows-10-setup-now-prevents-local-account-creation/))
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
        - congigure mkinitcpio.conf and add encrypt, lvm2 and resume hooks
    - install git and etckeeper. Initialize etckeeper. 
        - Skip etckeeper if you want to use previosly used etckeeper repo.
    - Install iwd, vim, zsh and sudo.
    - Configure bootloader:
        - install lvm and intel-ucode
        - run bootctl install
        - configure loader.conf and arch entry ([check examples](boot)] and add necessary hooks
    - set zsh as default shell for root chsh -s /bin/zsh
    - create new user 
    ```
    useradd -m -g users -G wheel,input,video -s /bin/zsh USERNAME
    passwd USERNAME
    EDITOR=vim visudo (uncomment sudo access for wheel)

    ```
    - exit, umount -R /mnt and reboot
- Post-install stuff:
    - login with created account
    - Connect to wifi 
    - Setup env variables, packages, dotfiles:
      - env variables are in [.pam_environment](../dot_pam_environment)
      - [arch_pgklist](../packages/arch_pkglist.txt) includes pacman packages
      - [arch_foreignpkglist](../packages/arch_foreignpkglist.txt) includes aur packages
        - You can run clone script for aur packages
        - Follow warnings during package installs
      - Install dotfiles from this repo with chezmoi
    - Delete root password and lock root `passwd -dl root`
    - Reboot
    - Finalize by running [create_symlinks_and_folders -script](create_symlinks_and_folders.sh)
