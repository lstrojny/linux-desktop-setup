{ settings, ... }: {
  programs.bash = {
    enable = true;
    historyControl = [ "ignorespace" ];
    shellOptions =
      [ "histappend" "checkwinsize" "extglob" "globstar" "checkjobs" "nocaseglob" "cdspell" "nocasematch" ];
    shellAliases = {
      l = "ls -alh";
      ll = "ls -l";
      ls = "ls --color=tty";
      g = "git";
      vim = "nvim";
      vi = "nvim";
      nvi = "nvim";
    };
    bashrcExtra = ''
      PATH=$PATH:./vendor/bin:./node-modules/bin
    '';
    initExtra = ''
      # Configure bash completion for aliases
      . `which complete_alias`
      complete -F _complete_alias "''${!BASH_ALIASES[@]}"

      # Make cd follow symlinks
      set -o physical

      # Searchpath for cd
      CDPATH="/etc"
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
