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
  };

  environment.etc."profile.local".text = ''
    sudo /etc/autorun.sh
  '';

  environment.systemPackages = with pkgs; [
    cryptsetup lvm2 git
  ];
}
