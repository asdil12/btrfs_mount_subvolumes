# btrfs_mount_subvolumes

On btrfs systems there are some submodules that need to be mounted manually.
This script mounts them automatically.

## Usage

```
# ./btrfs_mount_subvolumes.sh /dev/loop0p3 /mnt/
mount: /mnt: /dev/loop0p3 already mounted on /mnt.
mount: /mnt/.snapshots: /dev/loop0p3 already mounted on /mnt.
mount: /dev/loop0p3 mounted on /mnt/.snapshots/1/snapshot.
mount: /dev/loop0p3 mounted on /mnt/home.
mount: /dev/loop0p3 mounted on /mnt/opt.
mount: /dev/loop0p3 mounted on /mnt/root.
mount: /dev/loop0p3 mounted on /mnt/srv.
mount: /dev/loop0p3 mounted on /mnt/tmp.
mount: /dev/loop0p3 mounted on /mnt/var.
mount: /dev/loop0p3 mounted on /mnt/usr/local.
mount: /dev/loop0p3 mounted on /mnt/boot/grub2/arm64-efi.
```

```
# btrfs subvolume list /mnt
ID 256 gen 18 top level 5 path @
ID 257 gen 20 top level 256 path @/.snapshots
ID 258 gen 27 top level 257 path @/.snapshots/1/snapshot
ID 259 gen 27 top level 256 path @/home
ID 260 gen 20 top level 256 path @/opt
ID 261 gen 20 top level 256 path @/root
ID 262 gen 20 top level 256 path @/srv
ID 263 gen 24 top level 256 path @/tmp
ID 264 gen 27 top level 256 path @/var
ID 265 gen 22 top level 256 path @/usr/local
ID 266 gen 20 top level 256 path @/boot/grub2/arm64-efi
```

```
# ./btrfs_mount_subvolumes.sh /dev/loop0p3 /mnt/ --unmount
umount: /mnt/boot/grub2/arm64-efi unmounted
umount: /mnt/usr/local unmounted
umount: /mnt/var unmounted
umount: /mnt/tmp unmounted
umount: /mnt/srv unmounted
umount: /mnt/root unmounted
umount: /mnt/opt unmounted
umount: /mnt/home unmounted
umount: /mnt/.snapshots/1/snapshot unmounted
umount: /mnt/.snapshots unmounted
umount: /mnt unmounted
```
