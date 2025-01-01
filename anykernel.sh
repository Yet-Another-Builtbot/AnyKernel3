### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers

### AnyKernel setup
# global properties
properties() { '
kernel.string=asahi
do.devicecheck=0
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=0
device.name1=a37
supported.versions=
supported.patchlevels=
supported.vendorpatchlevels=
'; } # end properties

### AnyKernel install
## boot files attributes
boot_attributes() {
  set_perm_recursive 0 0 755 644 $RAMDISK/*
  set_perm_recursive 0 0 750 750 $RAMDISK/init* $RAMDISK/sbin
} # end attributes

# boot shell variables
BLOCK=/dev/block/bootdevice/by-name/boot
IS_SLOT_DEVICE=0
RAMDISK_COMPRESSION=auto
PATCH_VBMETA_FLAG=auto

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh

chmod -R 750 $RAMDISK/*
chown -R root:root $RAMDISK/*

# boot install
dump_boot # use split_boot to skip ramdisk unpack, e.g. for devices with init_boot ramdisk

ui_print "*******************************************"
ui_print "Updating Kernel and Patching cmdline..."
ui_print "*******************************************"

patch_cmdline androidboot.selinux androidboot.selinux=permissive

write_boot # use flash_boot to skip ramdisk repack, e.g. for devices with init_boot ramdisk
## end boot install
