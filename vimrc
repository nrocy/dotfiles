
" pathogen kicks ass
filetype off 
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

set nocompatible

" security exploit fix: http://lists.alioth.debian.org/pipermail/pkg-vim-maintainers/2007-June/004020.html
" from: http://stevelosh.com/blog/2010/09/coming-home-to-vim/
set modelines=0

" fix broken backspace
set backspace=2

filetype on
filetype indent on
filetype plugin on

set number

syntax on
syntax match Tab /\t/

set tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent smartindent 
set visualbell

set tags=tags;/

set laststatus=2
set ruler

" Search options
set ignorecase
set smartcase
set grepprg=/opt/local/bin/ack
set gdefault "assume /g for :s subs

" Long lines 
set wrap
set formatoptions=qrn1

" Turn backup off
set nobackup
set nowb
set noswapfile

" Use arrows for cnext, cprev
nmap <Up> :cprev<CR>
nmap <Down> :cnext<CR>

" CScope seems nicer than ctags
set cscopetag

" from: http://items.sjbach.com/319/configuring-vim-right
set hidden
set history=1000
set wildmenu
set wildmode=list:longest
set showmode

let g:easytags_cmd = '/opt/local/bin/ctags'

" scroll offset
set scrolloff=3

" nice sudo save shortcut :w!!
" http://blog.stebalien.com/2009/08/write-file-as-root-from-non-root-vim.html
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" emacs bindings for command mode
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

" NERDTree - don't use this much, but the bookmarks are nice for projects
nmap <F7> :NERDTreeToggle<CR>
let NERDTreeBookmarksFile="/Users/nroc/.vim/NERDTreeBookmarks"
let NERDTreeShowBookmarks=1

" from http://www.derekwyatt.org/vim/the-vimrc-file/my-vimrc-file/
set hlsearch
set showcmd
nmap <silent> ,n :set invhls<CR>:set hls?<CR>
set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]
set fillchars=""
nmap <silent> ,cd :lcd %:h<CR>

" from http://amix.dk/vim/vimrc.html, when vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

" set pman as K binding for php files 
autocmd FileType php setlocal keywordprg=pman

" show function prototype when only one match during omnicomplete
" from comments here: http://ruturajv.wordpress.com/2006/12/21/vim-7-autocomplete/
set cot+=menuone

" window navigation
set splitright
map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l

" move up and down screen lines, not text lines
nnoremap j gj
nnoremap k gk

" disable F1, i've hit you in error for the last time!
map <F1> <Esc>
imap <F1> <Esc>

""""""""""""""""""""""""""""""""""
" General bindings
""""""""""""""""""""""""""""""""""
let mapleader = ","

" mapping to select text that was just pasted
nmap <Leader>v `[V`]

nmap <space> zz

" Buffers
map <Leader>d :bd<CR>
map <Leader>da :bufdo bd<CR>

" Saving
map <Leader>w <ESC>:w<CR>

" Reindent whole file and move back to where you were
nnoremap <Leader>r G=gg<C-o><C-o>

" from @tpope's util plugin
nnoremap <silent> <Plug>unimpairedBlankUp   :<C-U>put!=repeat(nr2char(10),v:count)<Bar>']+1<CR>
nnoremap <silent> <Plug>unimpairedBlankDown :<C-U>put =repeat(nr2char(10),v:count)<Bar>'[-1<CR>
nmap [o <Plug>unimpairedBlankUp
nmap ]o <Plug>unimpairedBlankDown

" from vimwiki somewhere
nnoremap <silent>[d m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent>]d m`:silent +g/\m^\s*$/d<CR>``:noh<CR>

" open file in same dir
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>

""""""""""""""""""""""""""""""""""
" Plugin/Filetype Related
""""""""""""""""""""""""""""""""""

" a.vim 
let g:alternateExtensions_tpl = "php"
let g:alternateExtensions_php = "tpl"
let g:alternateSearchPath = 'templates'
map <Leader>a :AV<CR>

" for PDV
nnoremap <Leader>p :call PhpDocSingle()<CR>
vnoremap <Leader>p :call PhpDocRange()<CR>

" fuzzyfilefinder
map <Leader>rf :FuzzyFinderTextMateRefreshFiles<CR>

let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**;templates_c/**"

" osx/gui settings
set guioptions-=r
set guioptions-=L
set guioptions-=T
if has('ruby')
  map <D-k> :FuzzyFinderTextMate<CR>
  map <D-r> :! php -l %<CR>
else 
  map <D-k> :FindFileSplit<CR>
  map <D-K> :FindFile<CR>
endif

set list

" GUI specific
if has("gui_running")
  set background=dark
  " colorscheme solarized
endif 

" colours
set t_Co=256
set background=dark
colorscheme peaksea
highlight SpecialKey ctermfg=DarkGray guifg=#666666

if has("multi_byte")
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set listchars=tab:›\ ,eol:¬
endif

"set gfn=Droid_Sans_Mono:h11
"set gfn=ProggyCleanTT:h15
set gfn=Monaco:h10

" see :h ft-lisp-syntax
let g:lisp_rainbow = 1

" vimdiff settings
if &diff
  set t_Co=256
  set background=dark
  set diffopt+=iwhite
  colorscheme peaksea
  nmap Q :qa!<CR>
  nmap <space> ]c
endif

" vim 7.3
if v:version >= 703
  " Set color column colour
  set colorcolumn=80
  " really liked relativenumber at first but it's a bit buggy
  " set relativenumber
  " au BufNewFile,BufRead * set rnu
  hi ColorColumn ctermbg=DarkGray guibg=#2d2d2d

  " Keep undo files so we can rollback
  set undofile
  set undodir=~/.vim/undo
else
  set number
endif

