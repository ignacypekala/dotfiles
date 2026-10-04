#!/usr/bin/env bash
systemd_boot='/boot/EFI/systemd/systemd-bootx64.efi'
systemd_boot_name='systemd-bootx64.efi'
shim='/boot/EFI/BOOT/shimx64.efi'
shim_name='shimx64.efi'
bootx64='/boot/EFI/BOOT/BOOTX64.EFI'
bootx64_name='BOOTX64.EFI'
grub='/boot/EFI/BOOT/grubx64.efi'
grub_name='grubx64.efi'
mm='/boot/EFI/BOOT/mmx64.efi'
mm_name='mmx64.efi'

critical=false
unsafe=false

function error() {
	echo "Error: the system WILL NOT boot: $1"
}

function warn() {
	echo "Warning: the system may fail to boot: $1"
}

if [ -f "${shim}" ]; then
	if [ -f "${bootx64}" ]; then
		cmp -s "${shim}" "${bootx64}" || error "${shim_name} is not saved as ${bootx64_name}!"
	else
		error "BOOT64.EFI doesn\'t exist!"
	fi
else
	error "${shim_name} doesn\'t exist!"
fi

if [ -f "${systemd_boot}" ]; then
	if [ -f "${grub}" ]; then
		cmp -s "${systemd_boot}" "${grub}" || error "${systemd-boot_name} is not saved as ${grub_name}!"
	else
		error "${grub_name} doesn\'t exist!"
	fi
else
	error "${systemd_boot_name} doesn\'t exist!"
fi

[ -f "${mm}" ] || warn "${mm_name} doesn\'t exist. Enrolling new machine owner keys will be impossible."

echo 'All of the following files should be SIGNED:'
sbctl verify 2>&1 | grep -E "$grub_name|$systemd_boot_name|nixos-generation-" | \
	while read line
	do
		echo $line
	done
