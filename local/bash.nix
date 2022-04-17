{ settings, ... }: {
  programs.bash = {
    enable = true;
    historyControl = [ "ignorespace" ];
    shellOptions =
      [ "histappend" "checkwinsize" "extglob" "globstar" "checkjobs" "nocaseglob" "cdspell" "nocasematch" ];
    shellAliases = settings.aliases;
    bashrcExtra = ''
      PATH=$PATH:./vendor/bin:./node-modules/bin
    '';
    initExtra = ''
      # Configure bash completion for aliases
      . `which complete_alias`
      complete -F _complete_alias "''${!BASH_ALIASES[@]}"
    '';
  };
  programs.powerline-go = {
    enable = true;
    settings = {
      path-aliases = "/etc/nixos=NIXOS";
      colorize-hostname = "";
      cwd-max-dir-size = 3;
      max-width = 40;
    };
  };
}
