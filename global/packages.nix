{ pkgs, settings, ... }: {
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
    lesspipe

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
    google-chrome-beta
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

  programs._1password-gui = {
    enable = true;
    gid = 5000;
    polkitPolicyOwners = [ settings.identity.nick ];
    package = pkgs._1password-gui-beta;
  };

  programs.chromium = {
    enable = true;
    extraOpts = {
      HomepageLocation = "about:blank";
      NewTabPageLocation = "about:blank";
      PasswordManagerEnabled = false;
      BrowserAddPersonEnabled = false;
      AutofillCreditCardEnabled = false;
      AutofillAddressEnabled = false;
      PaymentMethodQueryEnabled = false;
      SyncDisabled = true;
      BrowserSignin = 0;
      PromotionalTabsEnabled = false;
      HttpsOnlyMode = "force_enabled";
      HideWebStoreIcon = true;
      EnableOnlineRevocationChecks = true;
      DnsOverHttps = "automatic";
      BuiltInDnsClientEnabled = false;
      SpellcheckEnabled = true;
      SpellcheckLanguage = [ "de" "en-US" ];
      ExtensionSettings = {
        # 1Password
        "aeblfdkhhhdcdjpifhhbdiojplfjncoa" = {
          "installation_mode" = "force_installed";
          "update_url" = "https://clients2.google.com/service/update2/crx";
        };
        # uBlock Origin
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" = {
          "installation_mode" = "force_installed";
          "update_url" = "https://clients2.google.com/service/update2/crx";
        };
        # Super Agent (Cookie consent)
        "neooppigbkahgfdhbpbhcccgpimeaafi" = {
          "installation_mode" = "force_installed";
          "update_url" = "https://clients2.google.com/service/update2/crx";
        };
        # Lighthouse
        "blipmdconlkpinefehnmjammfjpmpbjk" = {
          "installation_mode" = "force_installed";
          "update_url" = "https://clients2.google.com/service/update2/crx";
        };
        # JSON viewer
        "gbmdgpbipfallnflgajpaliibnhdgobh" = {
          "installation_mode" = "force_installed";
          "update_url" = "https://clients2.google.com/service/update2/crx";
        };
      };
    };
  };
}
