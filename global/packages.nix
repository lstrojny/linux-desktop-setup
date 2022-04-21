{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Utilities
    unzip
    powertop
    htop
    usbutils
    pciutils
    lsof
    jq
    yq-go

    # Security
    cryptsetup
    tpm2-tools

    neovim
    tmux

    # Shell
    shellcheck
    shfmt
    xclip
    powerline-go
    terminal-colors

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
    gnomeExtensions.system-monitor
    materia-theme

    # Core desktop apps
    _1password-gui
    chromium
    alacritty
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
