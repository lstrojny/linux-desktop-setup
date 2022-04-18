{ pkgs, settings, ... }: {
  environment.systemPackages = with pkgs; [
    # Utilities
    unzip
    powertop
    htop
    usbutils
    pciutils
    lsof

    # Security
    cryptsetup
    tpm2-tools

    neovim

    # Shell
    shellcheck
    shfmt
    xclip
    powerline-go

    # Networking
    dig
    wget

    # Shell
    complete-alias

    # Nix tools
    nix-index
    nixfmt
    nixt

    # GNOME
    gnomeExtensions.emoji-selector
    gnomeExtensions.clipboard-history
    gnomeExtensions.impatience
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.paperwm
    gnomeExtensions.system-monitor
    gnomeExtensions.pop-shell
    gnomeExtensions.arcmenu
    gnomeExtensions.tilingnome
    gnomeExtensions.dash-to-dock
    materia-theme

    # Core desktop apps
    _1password-gui
    chromium

    evolution

    # Development
    git
    jetbrains.phpstorm

    # Communication
    tdesktop
    whatsapp-for-linux
    signal-desktop
    element-desktop
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.git = {
    package = pkgs.gitFull;
    lfs.enable = true;
  };
}
