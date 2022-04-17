{ settings, ... }: {
  programs.git = {
    enable = true;
    userName = settings.name;
    userEmail = settings.email;
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
}
