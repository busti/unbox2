#! /usr/bin/env nix-shell
#! nix-shell -i bash -p p7zip squashfsTools sasquatch
chmod -R 777 unsquash
rm -rf result system unsquash *.iso
nix-build -v '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=iso.nix
cp result/iso/*.iso result_`date --iso-8601=seconds`.iso
#7z x result/iso/*.iso -osystem
#unsquashfs -f -d unsquash system/*.squashfs
#echo Result /etc/autorun.sh
#ls -d unsquash/*-nixos-system-nixos-*
#cat unsquash/*-nixos-system-nixos-*/etc/autorun.sh
