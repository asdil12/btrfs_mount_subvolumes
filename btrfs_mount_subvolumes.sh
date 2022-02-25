#!/bin/bash

blockdev=$1
mountpath=$2
shift 2

if [[ ! -e "$blockdev" ]] || [[ ! -e "$mountpath" ]] ; then
	echo "Usage: $0 DEVICE MOUNTDIR [extra mount options]"
	echo "For unmounting append '--unmount'"
	exit 1
fi

if echo "$@" | grep -q "\-\-unmount" ; then
	do_umount=1
	shift
else
	do_umount=0
fi

mountpath="$(echo "$mountpath" | sed 's#/$##')"

if [[ "$do_umount" == "0" ]] ; then
	mount -v "$blockdev" "$mountpath" $@
fi

if [[ "$do_umount" == "1" ]] ; then
	# reverse order to hopefully not run into dependency issues
	subvolume_list=$(btrfs subvolume list /mnt | cut -d ' ' -f9 | grep "^@" | grep -v "^@$" | tr -d '@' | tac)
else
	subvolume_list=$(btrfs subvolume list /mnt | cut -d ' ' -f9 | grep "^@" | grep -v "^@$" | tr -d '@')
fi

for subvolume in $subvolume_list ; do
	subvolume_stripped="$(echo "$subvolume" | sed 's#^/##')"
	if [[ $do_umount == "1" ]] ; then
		umount -v "$mountpath/$subvolume_stripped"
	else
		mount -v "$blockdev" "$mountpath/$subvolume_stripped" -o "subvol=@${subvolume}" $@
	fi
done

if [[ $do_umount == "1" ]] ; then
	umount -v "$mountpath"
fi
