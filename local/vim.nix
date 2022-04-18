{ pkgs, settings, ... }: {
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-polyglot
      vim-scala
      vim-colors-solarized
      vim-nix
      vim-nixhash
      vim-autoformat
      vim-fugitive
      vim-airline
      vim-airline-themes
    ];
    extraConfig = ''
      set background=dark
      set expandtab
      set tabstop=4
      set history=${builtins.toString settings.buffersize}

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

      " airline
      let g:airline_powerline_fonts = 1

      " Last cursor position
      autocmd BufReadPost *
         \ if line("'\"") > 0 && line("'\"") <= line("$") |
         \   exe "normal! g`\"" |
         \ endif
    '';
  };
}
