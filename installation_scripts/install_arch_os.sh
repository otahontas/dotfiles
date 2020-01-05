#!/bin/sh

### HELPER FUNCTIONS

confirm()
{
read -p "Press y to continue or any other key to quit " choice
case "$choice" in 
  y|Y ) ;;
  * ) exit 1
esac
}


### MAIN SCRIPT

echo "=== ARCH INSTALLATION ==="
echo "This script will go through arch installation phases according to ArchWiki installation guide. Modify if needed."

echo "// PARTITIONING: Script will install LVM with root and swap volumes inside a LUKS-encrypted container."

confirm
#
#esac
#
#read -p "// Give name for disk where arch should be installed (e.g. /dev/nvme0n1p2)") diskname
#
#echo ("// Creating encrypted container")
#cryptsetup luksFormat $diskname
#
#echo ("// Opening container")
#cryptsetup open $diskname cryptlvm
#
#echo ("// "
#
#
#
## Open
#
#
#
## Label device as "arch_os" so it can be used later with bootloader
#cryptsetup config --label="arch_os" $diskname
#
#
#
#- crypto
#- what to install
#- mkinitcpio
#- packages
#- download aur packages
#- audio
#- what else
#- check that guys install script
#- install wifi stuff
