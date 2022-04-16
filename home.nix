{ pkgs, ... }:
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
