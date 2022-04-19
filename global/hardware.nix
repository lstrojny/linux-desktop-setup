{ config, lib, pkgs, modulesPath, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "kvm-amd" ];
    supportedFilesystems = [ "zfs" ];
    kernelParams = [ "nohibernate" ];
    extraModulePackages = [ ];
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
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "amdgpu" ];
      kernelModules = [ ];
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

  fileSystems."/" = {
    device = "zroot/root";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/nix" = {
    device = "zroot/root/nix";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/var" = {
    device = "zroot/root/var";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/tmp" = {
    device = "zroot/root/tmp";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/home" = {
    device = "zroot/root/home";
    fsType = "zfs";
    options = [ "zfsutil" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2EC3-CBB7";
    fsType = "vfat";
  };

  fileSystems."/boot-fallback" = {
    device = "/dev/disk/by-label/BOOT-FB";
    fsType = "vfat";
  };

  swapDevices = [
    {
      device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_S6P7NJ0T104628N-part2";
      randomEncryption = {
        enable = true;
        cipher = "aes-xts-plain64";
      };
    }
    {
      device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_1TB_S6P7NG0R859102R-part2";
      randomEncryption = {
        enable = true;
        cipher = "aes-xts-plain64";
      };
    }
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;

  # Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
