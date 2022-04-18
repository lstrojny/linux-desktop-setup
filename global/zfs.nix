{ config, pkgs, ... }:

{
  boot = {
    supportedFilesystems = [ "zfs" ];
    kernelParams = [ "nohibernate" ];
    loader.grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      mirroredBoots = [{
        devices = [ "/dev/disk/by-label/BOOT-FB" ];
        path = "/boot-fallback";
      }];

      gfxmodeEfi = "2560x1440";
    };

    zfs = {
      devNodes = "/dev/disk/by-label/zroot";
      enableUnstable = true;
    };
  };
  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
    autoSnapshot = {
      enable = true;
      frequent = 8;
      monthly = 6;
    };
  };
}
