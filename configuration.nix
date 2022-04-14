# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes; # or versioned attributes like nix_2_7
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (self: super: {
      bluezFull = super.bluezFull.overrideAttrs (originalAttributes: rec {
        patches = originalAttributes.patches or [ ] ++ [
          (self.fetchpatch {
            name = "fix-mx-master-connectivity.diff";
            url = "https://github.com/bluez/bluez/commit/7fe38a17f6bee713fde587487fc224b0ae390e8f.diff";
            sha256 = "0iwpwlwkyqwc644fwd40snlvnwm1l48agq3y9sbizwksavmqd44v";
          })
        ];
      });
    })
  ];

  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./hardware-configuration-zfs.nix
  ];

  system.copySystemConfiguration = true;

  networking.hostName = "hackstrojny";
  networking.hostId = "24041986";
  networking.wireless.enable = false;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp6s0.useDHCP = true;
  networking.interfaces.enp8s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment with Wayland
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;
  hardware.opengl.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "de";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.lstrojny = {
    isNormalUser = true;
    createHome = true;
    home = "/home/lstrojny";
    description = "Lars Strojny";
    extraGroups = [ "wheel" "networkmanager" ];
    hashedPassword =
      "$6$3wh8GiYYOgFm321d$8CXIw54QA8FrrbbQB/XtIMUQq11CFVPzvMwg1vdDgW7bTFd92i6pihw9JQR2nqQfinCpK0dVgdRp7XuazWvaL.";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim_configurable
    wget
    nixfmt
    git
    lsof
    cryptsetup
    powertop
    usbutils
  ];

  # Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
