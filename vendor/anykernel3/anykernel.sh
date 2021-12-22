# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=SM-T500 kernel for GSI builds
do.devicecheck=1
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=0
device.name1=gta4lwifi
device.name2=
device.name3=
device.name4=
device.name5=
supported.versions=10 - 12
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;
keep_vbmeta_flag=auto;

. tools/ak3-core.sh;
dump_boot;
write_boot;

