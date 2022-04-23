{ settings, ... }: {
  programs.bash = {
    enable = true;
    historyControl = [ "ignorespace" ];
    historySize = settings.buffersize;
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
      copy = "xclip -i -selection clipboard";
      paste = "xclip -o -selection clipboard";
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

      # Automatically attach tmux
      if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
        tmux has-session && exec tmux attach-session || exec tmux new-session
      fi

      # Mouse support in less
      LESS="--mouse"
      # Syntax highlighting for less
      eval `lesspipe.sh`
      # Configure colors for less
      export LESS_TERMCAP_md=`printf '\e[01;35m'`
      export LESS_TERMCAP_me=`printf '\e[0m'`
      export LESS_TERMCAP_us=`printf '\e[01;32m'`
      export LESS_TERMCAP_ue=`printf '\e[0m'`
      export LESS_TERMCAP_so=`printf '\e[45;30m'`
      export LESS_TERMCAP_se=`printf '\e[0m'`
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
