{config, pkgs, ...}:
{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  environment.etc = {
    "autorun.sh" = {
      source = ./autorun.sh;
      mode = "0755";
    };

    "repos.txt" = {
      source = ./repos.txt;
      mode = "0755";
    };

    "profile.local".text = "sudo /etc/autorun.sh";
  };

  nixpkgs.config.packageOverrides = pkgs: {
    unstable = import (builtins.fetchTarball "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz") {
      config = config.nixpkgs.config;
    };
  };

  nix = {
    binaryCaches = [ "https://nixcache.neulandlabor.de" ];
    binaryCachePublicKeys = [ "nixcache.neulandlabor.de:iWPJklU/Tq9NdFWUcO8S7TBHwUjyZMjKIkCIWOei/Tw=" ];
  };

  environment.systemPackages = with pkgs; [
    # required
    git networkmanager dmidecode

    # install
    cryptsetup lvm2
  ];
}
