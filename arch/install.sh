#!/usr/bin/env bash

# === Global settings ===
set -Eeuo pipefail
trap 'cleanup $? $LINENO' SIGINT SIGTERM ERR EXIT
BACKTITLE="Arch Linux installation"
repo_url=https://raw.githubusercontent.com/otahontas/dotfiles/main
hostname=archis
user=otahontas

# === Helper functions ===
cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  err=$1
  line=$2
  if [ "$err" -eq 0 ]; then
    msg "${GREEN}\nInstallation script completed succesfully${NOFORMAT}\nYou can now log in and execute post-install -script present in users home folder."
  else
    msg "${RED}\nError happened while running installation script on line $line.${NOFORMAT}"
  fi
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' PURPLE='\033[0;35m'
  else
    NOFORMAT='' RED='' GREEN='' PURPLE=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}


get_input() {
    title="$1"
    description="$2"

    input=$(dialog --clear --stdout --backtitle "$BACKTITLE" --title "$title" --inputbox "$description" 0 0)
    echo "$input"
}

get_password() {
    title="$1"
    description="$2"

    init_pass=$(dialog --clear --stdout --backtitle "$BACKTITLE" --title "$title" --passwordbox "$description" 0 0)
    : "${init_pass:?"password cannot be empty"}"

    test_pass=$(dialog --clear --stdout --backtitle "$BACKTITLE" --title "$title" --passwordbox "$description again" 0 0)
    if [[ "$init_pass" != "$test_pass" ]]; then
        echo "Passwords did not match" >&2
        exit 1
    fi
    echo "$init_pass"
}

get_choice() {
    title="$1"
    description="$2"
    shift 2
    options=("$@")
    dialog --clear --stdout --backtitle "$BACKTITLE" --title "$title" --menu "$description" 0 0 0 "${options[@]}"
}

setup_colors

# === Installation === 

msg "${PURPLE}\n=== Checking UEFI boot mode ===${NOFORMAT}"

if [ ! -f /sys/firmware/efi/fw_platform_size ]; then
  msg "${RED}\nCannot run if UEFI mode not enabled"
  exit 2
fi

msg "${PURPLE}\n=== Setting up clock and terminal font ===${NOFORMAT}"

timedatectl set-ntp true
hwclock --systohc --utc
font="ter-716n"
setfont "$font"

password=$(get_password "User" "Enter password") || exit 1
clear
: "${password:?"password cannot be empty"}"

msg "${PURPLE}\n=== Setting up columes and partitions ===${NOFORMAT}"
sleep 1

devicelist=$(lsblk -dplnx size -o name,size | grep -Ev "boot|rpmb|loop" | tac | tr '\n' ' ')
read -r -a devicelist <<< "$devicelist"

device=$(get_choice "Installation" "Select installation disk" "${devicelist[@]}") || exit 1
clear

luks_header_device=$(get_choice "Installation" "Select disk to write LUKS header to" "${devicelist[@]}") || exit 1
clear

umount -R /mnt 2> /dev/null || true
cryptsetup luksClose luks 2> /dev/null || true

lsblk -plnx size -o name "${device}" | xargs -n1 wipefs --all
sgdisk --clear "${device}" --new 1::-551MiB "${device}" --new 2::0 --typecode 2:ef00 "${device}"
sgdisk --change-name=1:primary --change-name=2:ESP "${device}"

part_root="$(ls ${device}* | grep -E "^${device}p?1$")"
part_boot="$(ls ${device}* | grep -E "^${device}p?2$")"

if [ "$device" != "$luks_header_device" ]; then
    cryptargs="--header $luks_header_device"
else
    cryptargs=""
    luks_header_device="$part_root"
fi

msg "${PURPLE}\n=== Formatting partitions ===${NOFORMAT}"

mkfs.vfat -n "EFI" -F32 "${part_boot}"
echo -n ${password} | cryptsetup luksFormat --type luks2 --pbkdf argon2id --label luks $cryptargs "${part_root}"
echo -n ${password} | cryptsetup luksOpen $cryptargs "${part_root}" luks
mkfs.btrfs -L btrfs /dev/mapper/luks

msg "${PURPLE}\n=== Setting up BTRFS subvolumes ===${NOFORMAT}"

mount /dev/mapper/luks /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/pkgs
btrfs subvolume create /mnt/docker
btrfs subvolume create /mnt/logs
btrfs subvolume create /mnt/temp
btrfs subvolume create /mnt/swap
btrfs subvolume create /mnt/snapshots
umount /mnt

mount -o noatime,nodiratime,compress=zstd,subvol=root /dev/mapper/luks /mnt
mkdir -p /mnt/{mnt/btrfs-root,efi,home,var/{cache/pacman,log,tmp,lib/docker},swap,.snapshots}
mount "${part_boot}" /mnt/efi
mount -o noatime,nodiratime,compress=zstd,subvol=/         /dev/mapper/luks /mnt/mnt/btrfs-root
mount -o noatime,nodiratime,compress=zstd,subvol=home      /dev/mapper/luks /mnt/home
mount -o noatime,nodiratime,compress=zstd,subvol=pkgs      /dev/mapper/luks /mnt/var/cache/pacman
mount -o noatime,nodiratime,compress=zstd,subvol=docker    /dev/mapper/luks /mnt/var/lib/docker
mount -o noatime,nodiratime,compress=zstd,subvol=logs      /dev/mapper/luks /mnt/var/log
mount -o noatime,nodiratime,compress=zstd,subvol=temp      /dev/mapper/luks /mnt/var/tmp
mount -o noatime,nodiratime,compress=zstd,subvol=swap      /dev/mapper/luks /mnt/swap
mount -o noatime,nodiratime,compress=zstd,subvol=snapshots /dev/mapper/luks /mnt/.snapshots

msg "${PURPLE}\n=== Installing all pacman packages from dotfiles list ===${NOFORMAT}"

pacstrap /mnt $(curl -sL $repo_url/arch/packages/pacman.txt)

msg "${PURPLE}\n=== Building crucial AUR packages with temporary user, then installing with root ===${NOFORMAT}"

aur_prgs="paru-bin mkinitcpio-encrypt-detached-header arch-secure-boot"

arch-chroot /mnt /bin/bash <<EOF
useradd -m build && passwd -d build && groupadd -rf wheel && gpasswd -a build wheel
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/override

chgrp build /home/build && chmod g+ws /home/build
setfacl -m u::rwx,g::rwx /home/build && \
setfacl -d --set u::rwx,g::rwx,o::- /home/build
cd /home/build

[[ -d /home/build ]] || exit 1

for program in $aur_prgs; do
  git clone https://aur.archlinux.org/'$program'.git && \
  cd '$program' && \
  sudo -u build makepkg -s --noconfirm --skippgpcheck && \
  pacman -U --noconfirm '$program'*pkg* && cd ..
done

userdel -r build && groupdel wheel && rm -rf /home/build
EOF

msg "${PURPLE}\n=== Generating and adding configuration files and images ===${NOFORMAT}"

cryptsetup luksHeaderBackup "${luks_header_device}" --header-backup-file /tmp/header.img
luks_header_size="$(stat -c '%s' /tmp/header.img)"
rm -f /tmp/header.img

echo "cryptdevice=PARTLABEL=primary:luks:allow-discards cryptheader=LABEL=luks:0:$luks_header_size root=LABEL=btrfs rw rootflags=subvol=root quiet mem_sleep_default=deep" > /mnt/etc/kernel/cmdline

echo "FONT=$font" > /mnt/etc/vconsole.conf
genfstab -L /mnt >> /mnt/etc/fstab
echo "${hostname}" > /mnt/etc/hostname
echo "en_US.UTF-8 UTF-8" >> /mnt/etc/locale.gen
ln -sf /usr/share/zoneinfo/Europe/Helsinki /mnt/etc/localtime
arch-chroot /mnt locale-gen
cat << EOF > /mnt/etc/mkinitcpio.conf
MODULES=()
BINARIES=()
FILES=()
HOOKS=(base consolefont udev autodetect modconf block encrypt-dh filesystems keyboard)
EOF
arch-chroot /mnt mkinitcpio -p linux
arch-chroot /mnt arch-secure-boot initial-setup
# Note: If system doesn't boot up after installing, make sure:
# a) you have the permissions to write to /sys/firmware/efi/efivars
# b) the files in efivars folder aren't immutable (confirm with running lsattr)
# c) you really cleared all the previous keys in bios

msg "${PURPLE}\n=== Configuring swap file ===${NOFORMAT}"

truncate -s 0 /mnt/swap/swapfile
chattr +C /mnt/swap/swapfile
btrfs property set /mnt/swap/swapfile compression none
dd if=/dev/zero of=/mnt/swap/swapfile bs=1M count=4096
chmod 600 /mnt/swap/swapfile
mkswap /mnt/swap/swapfile
echo "/swap/swapfile none swap defaults 0 0" >> /mnt/etc/fstab

msg "${PURPLE}\n=== Creating user ===${NOFORMAT}"

arch-chroot /mnt useradd -m -s /usr/bin/zsh "$user"
for group in wheel network nzbget video; do
    arch-chroot /mnt groupadd -rf "$group"
    arch-chroot /mnt gpasswd -a "$user" "$group"
done
arch-chroot /mnt chsh -s /usr/bin/zsh
echo "$user:$password" | arch-chroot /mnt chpasswd
arch-chroot /mnt passwd -dl root

msg "${PURPLE}\n=== Finalizing ===${NOFORMAT}"
arch-chroot /mnt curl -sL $(repo_url/arch/post-install.sh) -o "/home/$user/post-install.sh"
