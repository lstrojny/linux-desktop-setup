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
  programs.bash = rec {
    enable = true;
    historyControl = [ "ignorespace" ];
    shellOptions =
      [ "histappend" "checkwinsize" "extglob" "globstar" "checkjobs" "nocaseglob" "cdspell" "nocasematch" ];
    shellAliases = aliases;
    bashrcExtra = ''
      PATH=$PATH:./vendor/bin:./node-modules/bin
    '';
    initExtra = ''
      # Configure bash completion for aliases
      . `which complete_alias`
      complete -F _complete_alias "''${!BASH_ALIASES[@]}"
    '';
  };
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-polyglot vim-scala vim-colors-solarized vim-nix vim-nixhash vim-autoformat ];
    settings = {
      background = "dark";
      expandtab = true;
      tabstop = 4;
      history = 10000;
    };
    extraConfig = ''
      silent! source $VIMRUNTIME/defaults.vim

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

      " Make command tab completion usable
      set wildmenu
      set wildmode=list:longest

      set title

      " Solarized
      colorscheme solarized

      " vim-autoformat
      let g:formatdef_nix_format = '"nixfmt --width=".&textwidth'
      let g:formatdef_shfmt = '"shfmt -p -sr -ci -s -i ".(&expandtab ? shiftwidth() : "0")'
      " Map F3 to autoformatter
      noremap <F3> :Autoformat<CR>
      " Autoformat on save
      au BufWrite * :Autoformat
    '';
  };
}
