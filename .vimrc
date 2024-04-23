" An example for a vimrc file.
" Maintainer:	The Vim Project <https://github.com/vim/vim>
" Last Change:	2023 Aug 10
" Former Maintainer:	Bram Moolenaar <Bram@vim.org>
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
syntax on
filetype on
filetype indent on
filetype plugin on
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
set number
set relativenumber
set undofile
set undodir=~/.vim/undodir
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=2

set backup  "Enable backup files.
set backupdir=~/.vim_backups/
set backupskip=/tmp/*,/private/tmp/*

set clipboard=unnamed,unnamedplus
set ignorecase
nnoremap p p`]mm`[v`]=`m:silent delmarks m<CR>:redraw!<CR>
vnoremap p p`]mm`[v`]=`m:silent delmarks m<CR>:redraw!<CR>
nnoremap == mmgg=G`m:silent delmarks m<CR>:redraw!<CR>
vnoremap y ygv<Esc>
inoremap kj <Esc>
nnoremap c "_c
vnoremap c "_c
vnoremap p "_dP
nnoremap <space>d "_d
vnoremap <space>d "_d
noremap x "_x
" Change cursor to a vertical bar in insert mode
let &t_SI = "\e[5 q"
" Change cursor back to a block in normal mode
let &t_EI = "\e[1 q"
set autowriteall
