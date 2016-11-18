" vim:set ts=2 sts=2 sw=2 expandtab:

" prevent duplicate autocmd when souring .vimrc again
autocmd!

set nocompatible
filetype off

set shell=/bin/bash

set hidden
set history=10000

" UI
syntax enable

set number relativenumber
set cursorline
set winwidth=81
set scrolloff=5
" always show status line
set laststatus=2
" show matching brackets
set showmatch

" Search
set hlsearch
" show matches when typing search pattern
set incsearch
set ignorecase smartcase

" Edit
set backspace=indent,eol,start

set expandtab
set tabstop=4 shiftwidth=4 softtabstop=4
set autoindent smartindent

" Behavior
let mapleader = ","

set complete+=kspell
set list
set listchars=tab:>-,trail:·,extends:#,nbsp:. ",eol:¬ " end
set wildmode=longest,list
set switchbuf=useopen
" prevent vim from clobbering the scrollback buffer. see
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" no startup message
set shortmess+=I
set showcmd
set noswapfile

" Encodings
set encoding=utf-8
set fileencodings=utf-8,gb2312,gbk,cp936,latin1

" IO
set autoread

" Neovim
if has('nvim')
else
endif

" Vundle

" modified bootstrap, originally by John Whitley
" https://github.com/jwhitley/vimrc/blob/master/.vim/bootstrap/bundles.vim

let s:current_folder = expand("<sfile>:h")

" returns path inside .vim folder relative to this file
function! s:RelativePathWithinDotVim(path)
  return s:current_folder."/.vim/".a:path
endfunction

" Initialize Vundle if haven't yet
let s:bundle_path = s:RelativePathWithinDotVim("bundle")
let s:vundle_path = s:RelativePathWithinDotVim("bundle/Vundle.vim")
if !isdirectory(s:vundle_path."/.git")
  silent exec "!mkdir -p ".s:bundle_path
  silent exec "!git clone --depth=1 https://github.com/gmarik/Vundle.vim.git ".s:vundle_path
  let s:vundle_initialized=1
endif

exec "set rtp+=".s:vundle_path
call vundle#begin(s:bundle_path)

" let Vundle manage itself
Plugin 'gmarik/Vundle.vim'

" UI
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'

" Behaviour
Plugin 'wincent/command-t'
let g:CommandTFileScanner = "git"

Plugin 'bufkill.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
" create any non-existent directories before writing a buffer
Plugin 'pbrisbin/vim-mkdir'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-endwise' " helps to end certain structures automatically
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-fugitive'
Plugin 'rking/ag.vim'
Plugin 'jiangmiao/auto-pairs'

Plugin 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "context"

" language

" Ruby
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-rails'
Plugin 'NicholasTD07/vim-rspec'

Plugin 'Valloric/YouCompleteMe'
Plugin 'nvie/vim-flake8'
Plugin 'hynek/vim-python-pep8-indent'

Plugin 'cespare/vim-toml'

Plugin 'bumaociyuan/vim-swift'

Plugin 'dag/vim-fish'

call vundle#end()

if exists("s:vundle_initialized") && s:vundle_initialized
  unlet s:vundle_initialized
  autocmd VimEnter * PluginInstall
endif

filetype plugin indent on

" Plugin Setup
nnoremap <leader>vi :so $MYVIMRC\|PluginInstall<cr>
nnoremap <leader>vc :so $MYVIMRC\|PluginClean<cr>

" solarized
colorscheme solarized
set background=dark
if (strftime("%H") < 8 || strftime("%H") >= 18)
  set background=dark
else
  set background=light
endif
call togglebg#map("<F5>") " solarized background toggle

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

nmap <leader>. <Plug>BufKillBd

" easymotion
let g:EasyMotion_smartcase = 1 " turn on case insensitive feature
let g:EasyMotion_do_mapping = 0 " disable default mappings
let g:EasyMotion_use_smartsign_us = 1 " 1 will match 1 and !
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'
let g:EasyMotion_space_jump_first = 1
let g:EasyMotion_enter_jump_first = 1

nmap <leader>g <Plug>(easymotion-bd-w)
nmap s <Plug>(easymotion-s2)
map t <Plug>(easymotion-bd-t)
map f <Plug>(easymotion-bd-f2)
omap t <Plug>(easymotion-tl)
omap f <Plug>(easymotion-fl)
vmap t <Plug>(easymotion-tl)
vmap f <Plug>(easymotion-fl)

" jk motions: line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" end of easymotion

nnoremap <silent> <c-f> :CommandT .<cr>
nnoremap <silent> <c-b> :CommandTBuffer<cr>
noremap <buffer> <leader>t :wa \| silent make coverage \| redraw! \| cw 4 <cr>

" Autocmds

augroup vimrcEx
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml,html,haml,javascript,cucumber,json set ai sw=2 sts=2 et

  " *.md is markdown
  autocmd! BufNewFile,BufRead *.md setlocal filetype=markdown

  " *.fish is fish
  autocmd! BufNewFile,BufRead *.fish setlocal filetype=fish

  " *.swift is swift
  autocmd! BufNewFile,BufRead *.swift setlocal filetype=swift
  autocmd FileType swift set ai sw=4 sts=4 et
  autocmd FileType swift call SetUpSwift()

  function! SetUpSwift()
    " reset errorformat
    set efm=

    " swift test/build errors
    set efm+=%E%f:%l:%c:\ error:\ %m
    set efm+=%W%f:%l:%c:\ warning:\ %m
    set efm+=%Z%\s%#^~%#
    set efm+=%f:%l:\ error:\ %m
    set efm+=fatal\ error:\ %m

    " custom codecov errors (zero-hit detection)
    " Example: Ignore zero-hit ending brackets
    " File /path/to/another.swift:104|            }
    set efm+=%-GFile\ %f:%l:\ %#}
    " Example: Detect other zero-hit lines
    " File /path/to/a.swift:56|    func remove(todo: ToDo) -> State {
    set efm+=File\ %f:%l:\ %#%m

    set efm+=%-G%.%#
    noremap <buffer> <leader>w :wa \| silent make \| redraw! \| cw 4 <cr>
    noremap <buffer> <leader>t :wa \| silent make coverage \| redraw! \| cw 4 <cr>
  endfunction


  " *.podspec is ruby
  autocmd! BufNewFile,BufRead *.podspec setlocal filetype=ruby

  " Podfile is ruby
  autocmd! BufNewFile,BufRead Podfile setlocal filetype=ruby

  " wrap at 80 characters and spell check markdown
  autocmd FileType markdown setlocal textwidth=80 spell

  " wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72 spell
  autocmd FileType gitcommit noremap <buffer> <leader>w :wq<cr>

  autocmd FileType vim noremap <buffer> <leader>w :w \| source $MYVIMRC <cr>
augroup END

" Key settings

noremap ; :
noremap : ;

inoremap <c-c> <esc>
inoremap kj <esc>
cnoremap kj <c-c> " fix exit after typing :help in command

" vim
nnoremap <leader>w :w<cr>

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
" motions for splits
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap <leader><leader> <c-^>
nnoremap <leader>' :bprev<cr>

nnoremap <leader>h :help<space>

nnoremap <leader>s :%s/\<<C-r><C-w>\>/
vnoremap <leader>s :%s/\<<C-r><C-w>\>/

nnoremap <silent> <leader>c :nohlsearch<cr>

nnoremap <leader>ee :e %<cr>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>eg :e ~/.gitconfig<cr>
nnoremap <leader>rv :source $MYVIMRC<cr>

vnoremap <leader>p "*p
nnoremap <leader>p "*p

vnoremap <leader>y "*y
nnoremap <leader>y "*y

nnoremap <tab> >>
nnoremap <s-tab> <<

" delete comment lines and empty lines
nnoremap <leader>dc :%g/^\s*#.*/d
nnoremap <leader>de :%g/^s*$/d

" FIXME: When sharing Vim with someone else
inoremap <esc> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <right> <nop>
nnoremap <left> <nop>
"nnoremap h <nop>
"nnoremap j <nop>
"nnoremap k <nop>
"nnoremap l <nop>

" for python and ruby
inoremap ; :
inoremap : ;
" for all programming languages
" TOO INCONVIENT
" when writing git commit message with version number...
" inoremap 1 !
" inoremap ! 1
" inoremap 2 @
" inoremap @ 2
" inoremap 3 #
" inoremap # 3
" inoremap 4 $
" inoremap $ 4
" inoremap 5 %
" inoremap % 5
" inoremap 6 ^
" inoremap ^ 6
" inoremap 7 &
" inoremap & 7
" inoremap 8 *
" inoremap * 8
" inoremap 9 (
" inoremap ( 9
" inoremap 0 )
" inoremap ) 0
