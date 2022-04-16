with (import ./settings.nix); {
  programs.git = {
    enable = true;
    userName = name;
    userEmail = email;
    aliases = {
      st = "status";
      cm = "commit -m";
      pick = "cherry-pick";
      amend = "commit --ammend";
      diffs = "diff --cached";
      g = "grep";
      s = "stash";
    };
  };
  programs.bash = {
    enable = true;
    historyControl = [ "ignorespace" ];
    shellAliases = { g = "git"; };
    bashrcExtra = ''
      PATH=$PATH:./vendor/bin:./node-modules/bin
    '';
  };
}
