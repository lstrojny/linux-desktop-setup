{ pkgs, lib, ... }:
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
  programs.bash = rec {
    enable = true;
    historyControl = [ "ignorespace" ];
    shellOptions =
      [ "histappend" "checkwinsize" "extglob" "globstar" "checkjobs" "nocaseglob" "cdspell" "nocasematch" ];
    shellAliases = { g = "git"; };
    bashrcExtra = ''
      PATH=$PATH:./vendor/bin:./node-modules/bin
    '';
    initExtra = ''
      function __configure_bash_completion_for_alias() {
          local original=$1
          local alias=$2
          type __load_completion &>/dev/null && __load_completion $original
          local cmd=(`complete -p $original`)
          unset cmd[''${#cmd[@]}-1]
          eval ''${cmd[*]} $alias
      }

      ${lib.strings.concatStrings
      (lib.attrsets.mapAttrsToList (alias: original: "__configure_bash_completion_for_alias ${original} ${alias}")
        shellAliases)}
    '';
  };
  programs.vim = {
    enable = true;
    plugins = [ pkgs.vimPlugins.vim-polyglot pkgs.vimPlugins.vim-scala pkgs.vimPlugins.vim-colors-solarized ];
    settings = {
      background = "dark";
      expandtab = true;
      tabstop = 4;
      history = 10000;
    };
    extraConfig = ''
      " Use system clipboard
      set clipboard=unnamedplus

      " Backspace deletes anything
      set backspace=2

      " Enable line numbers
      set nu!

      " It's 2020 something
      set textwidth=120

      " Highlight trailing whitespace
      highlight WhitespaceEOL ctermbg=red guibg=red
      match WhitespaceEOL /\s\+$/

      " Fix my favorite typos
      cnoreabbrev X x
      cnoreabbrev W w
      cnoreabbrev Q q

      "Make command tab completion usable
      set wildmenu
      set wildmode=list:longest

      set title

      " Solarized
      colorscheme solarized
    '';
  };
}
