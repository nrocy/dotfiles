
" pathogen kicks ass
filetype off
"call pathogen#helptags()
"call pathogen#runtime_append_all_bundles()

call pathogen#infect()

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

" Better block selection
set virtualedit=block

" Search options
set ignorecase
set smartcase
set grepprg=~/bin/ack
set gdefault "assume /g for :s subs
set incsearch

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

" from: http://items.sjbach.com/319/configuring-vim-right
set hidden
set history=1000
set wildmenu
set wildmode=list:longest
set showmode

" wildcards
set wildignore+=templates_c,vendor,.git,.hg,node_modules,*.png,*.jpg,*.gif

" scroll offset
set scrolloff=3

" nice sudo save shortcut :w!!
" http://blog.stebalien.com/2009/08/write-file-as-root-from-non-root-vim.html
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" emacs bindings for command mode
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

" NERDTree - don't use this much, but the bookmarks are nice for projects
" nmap <F7> :NERDTreeToggle<CR>
" let NERDTreeBookmarksFile="/Users/nroc/.vim/NERDTreeBookmarks"
" let NERDTreeShowBookmarks=1

" from http://www.derekwyatt.org/vim/the-vimrc-file/my-vimrc-file/
set hlsearch
set showcmd
nmap <silent> ,n :set invhls<CR>:set hls?<CR>
set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]
set fillchars=""
nmap <silent> ,cd :lcd %:h<CR>

" from http://amix.dk/vim/vimrc.html, when vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

" nuke whitespace at the end of lines before saving
autocmd bufwritepre * :%s/\s\+$//e

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

" disable ex mode
nnoremap Q <nop>

" close tags, handy for html, messes with ,<esc>
" imap ,/ </<C-X><C-O>

""""""""""""""""""""""""""""""""""
" General bindings
""""""""""""""""""""""""""""""""""
let mapleader = ","

" mapping to select text that was just pasted
nmap <Leader>v `[V`]

nmap <space> zz

" Buffers
map <Leader>d :bd<CR>

" Saving
map <Leader>w <ESC>:w<CR>

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

" disable paste mode after leaving insert mode
au InsertLeave * set nopaste

" ag shortcut
noremap <leader>a :Ag<Space>

""""""""""""""""""""""""""""""""""
" Plugin/Filetype Related
""""""""""""""""""""""""""""""""""

" let g:Powerline_symbols = 'unicode'

" let g:alternateSearchPath = "sfr:templates/"
" let g:alternateExtensions_php = "tpl"
" let g:alternateExtensions_tpl = "php"
" nmap <Leader>a :A<CR>
" nmap <Leader>A :AV<CR>

" for PDV
nnoremap <Leader>p :call PhpDocSingle()<CR>
vnoremap <Leader>p :call PhpDocRange()<CR>

let g:ctrlp_map = '<Leader>f'

let g:syntastic_javascript_checkers = ['jsl']
let g:syntastic_javascript_jsl_conf = "--es5"
let g:syntastic_error_symbol="✗"
let g:syntastic_warning_symbol="⚠"
let g:syntastic_style_error_symbol="s✗"
let g:syntastic_style_warning_symbol="s⚠"
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=3

let g:syntastic_mode_map={'mode': 'active', 'active_filetypes': [], 'passive_filetypes': ['html'] }

" osx/gui settings
set guioptions-=r
set guioptions-=L
set guioptions-=T

set list

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
set gfn=Monaco:h14

" demos
" colorscheme hemisu
" set background=light
" set nonumber
" set nolist
" set gfn=Monaco:h18
" au BufReadPost *.html set syntax=javascript

" GUI specific
if has("gui_running")
  set noantialias
  " colorscheme solarized
endif

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
  " set colorcolumn=80
  " really liked relativenumber at first but it's a bit buggy
  " set relativenumber
  " au BufNewFile,BufRead * set rnu
  " hi ColorColumn ctermbg=DarkGray guibg=#2d2d2d

  " Keep undo files so we can rollback
  set undofile
  set undodir=~/.vim/undo
else
  set number
endif

" misc funcs that sometimes come in useful, should really be in their own
" files but I can't be arsed at the mo.

" set pman as K binding for php files
autocmd FileType php setlocal keywordprg=pman
nnoremap K :silent !pman '<cword>'<CR> \| :redraw!<CR>

:nmap <Leader>- :normal YpVr-<cr>

function! AdiumLogToTextFunction()
  let s:globaldefault = &gdefault
  let &gdefault = 0
  silent! %s/<message.\+time="\([^"]\+\)".\+alias="\([^"]\+\)\">/\1 \2: /g
  silent! %s/<\_.\{-1,\}>//g
  silent! %s/&apos;/'/g
  silent! %s/&amp;/\&/g
  silent! %s/&quot;/"/g
  silent! %s/&gt;/\>/g
  silent! %s/&lt;/\</g
  let &gdefault = s:globaldefault
endfunction
command! AdiumLogToText call AdiumLogToTextFunction()

" XML formatter
function! DoFormatXML() range
  " Save the file type
  let l:origft = &ft

  " Clean the file type
  set ft=

  " Add fake initial tag (so we can process multiple top-level elements)
  exe ":let l:beforeFirstLine=" . a:firstline . "-1"
  if l:beforeFirstLine < 0
    let l:beforeFirstLine=0
  endif
  exe a:lastline . "put ='</PrettyXML>'"
  exe l:beforeFirstLine . "put ='<PrettyXML>'"
  exe ":let l:newLastLine=" . a:lastline . "+2"
  if l:newLastLine > line('$')
    let l:newLastLine=line('$')
  endif

  " Remove XML header
  exe ":" . a:firstline . "," . a:lastline . "s/<\?xml\\_.*\?>\\_s*//e"

  " Recalculate last line of the edited code
  let l:newLastLine=search('</PrettyXML>')

  " Execute external formatter
  exe ":silent " . a:firstline . "," . l:newLastLine . "!xmllint --noblanks --format --recover -"

  " Recalculate first and last lines of the edited code
  let l:newFirstLine=search('<PrettyXML>')
  let l:newLastLine=search('</PrettyXML>')

  " Get inner range
  let l:innerFirstLine=l:newFirstLine+1
  let l:innerLastLine=l:newLastLine-1

  " Remove extra unnecessary indentation
  exe ":silent " . l:innerFirstLine . "," . l:innerLastLine "s/^  //e"

  " Remove fake tag
  exe l:newLastLine . "d"
  exe l:newFirstLine . "d"

  " Put the cursor at the first line of the edited code
  exe ":" . l:newFirstLine

  " Restore the file type
  exe "set ft=" . l:origft
endfunction
command! -range=% FormatXML <line1>,<line2>call DoFormatXML()

nmap <silent> <leader>x :%FormatXML<CR>

