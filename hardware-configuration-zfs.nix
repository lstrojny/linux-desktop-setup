{ config, pkgs, ... }:

{
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.devNodes = "/dev/disk/by-label/zroot";
  boot.zfs.enableUnstable = true;
  boot.kernelParams = [ "nohibernate" ];
  services.zfs.autoScrub.enable = true;
  services.zfs.trim.enable = true;
}
