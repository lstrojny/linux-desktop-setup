# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }: {
  # Enable experimental flakes support
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  nixpkgs.config = {
    allowUnfree = true;
    joypixels.acceptLicense = true;
  };

  # Patch bluez to fix MX Master connectivity on reboot/sleep
  nixpkgs.overlays = with builtins; [
    (self: super: {
      alacritty = super.alacritty.overrideAttrs (originalAttributes: {
        buildInputs = originalAttributes.buildInputs ++ [ pkgs.makeWrapper ];
        postInstall = originalAttributes.postInstall or "" + ''
          wrapProgram "$out/bin/alacritty" --set WAYLAND_DISPLAY=""
        '';
      });
    })
    (self: super: { _1password-gui-beta = self.callPackage ./pkgs/_1password-gui-beta.nix { }; })
    # Install nix unit testing framework
    (import (fetchGit {
      url = "https://github.com/nix-community/nixt/";
      rev = "6338fcdbaf34c9eba72acfc7bc6a2e6cd7b4e3fe";
    }))
    (self: super: {
      google-chrome-beta = super.google-chrome-beta.override {
        commandLineArgs = [ "--enable-features=WebUIDarkMode" "--force-dark-mode" ];
      };
    })
  ];

  imports = [
    ./global/localization.nix
    ./global/networking.nix
    ./global/tty.nix
    ./global/desktop.nix
    ./global/users.nix
    ./global/packages.nix
    ./global/hardware.nix
  ];

  environment.memoryAllocator.provider = "scudo";
  environment.variables.SCUDO_OPTIONS = "ZeroContents=1";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
