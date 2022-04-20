{ settings, ... }: {
  programs.git = with settings.identity; {
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
}
