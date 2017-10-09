set encoding=utf-8

" Vim plugins expect a POSIX-compliant shell
if &shell !~ '/sh$'
    set shell=/bin/sh
endif

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'ElmCast/elm-vim'
Plugin 'Keithbsmiley/swift.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'cfdrake/vim-carthage'
Plugin 'dag/vim-fish'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'gmarik/Vundle.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'msanders/snipMate.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'shemerey/vim-peepopen'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vim-syntastic/syntastic'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-notes'

let g:rust_recommended_style = 1
let g:rustfmt_autosave = 1
let g:notes_directories = ['~/Dropbox/Notes']

call vundle#end()
filetype plugin indent on

" ============================
" Settings
" ============================

" Autocompletion
set wildignore+=*.o,*.obj,*.pyc,*.DS_Store,*.db,*.git
set wildmenu

if exists('+wildignorecase')
    set wildignorecase
endif

" Backup
set nobackup
set noswapfile
set nowritebackup
set undodir=/tmp
set undofile

" Buffers
set autoread
set hidden

" Display
set rulerformat=%l:%c ruler
set shortmess=atI
set showcmd
set titlestring=%f title

" iTerm weirdness (https://stackoverflow.com/a/2105981)
set t_ts=]1;
set t_fs=

" Editing
set backspace=indent,eol,start
set nofoldenable
set pastetoggle=<f2>
set shiftwidth=4
set tabstop=4
set mouse=a

" Search
set gdefault
set hlsearch
set ignorecase
set smartcase

" Mac options
if has('mac')
    function! s:PBCopy()
        let old = @"
        normal! gvy
        call system('pbcopy', @")
        let @" = old
    endfunction

    vnoremap <silent> Y :<c-u>call<SID>PBCopy()<cr>
endif

" GUI options
if has('gui_running')
    set columns=101 lines=38 " Default window size
    set guicursor=a:blinkon0 " Disable blinking cursor
    set guifont=Menlo\ Regular:h16
    set guioptions=hae
endif

" Syntax
set t_Co=16
if !&diff
    syntax on
    set background=dark
    try
        colorscheme solarized
    catch
        colorscheme slate
    endtry
endif

" ============================
" Macros
" ============================

" Typos
iabbrev !+ !=
iabbrev ~? ~/

" Escape with jj
cnoremap jj <c-c>
inoremap jj <esc>

" Enter cmdline mode with ;
noremap ; :
noremap \ ;

" Paste yanked text (as opposed to cut text)
noremap gp "0p
noremap gP "0P

" Make Y to y as D is to d and C is to c
nnoremap Y y$

" Add blank line while maintaining cursor position
if exists('repeat#set')
    " Use repeat#set for proper "." support if it's installed
    " http://www.vim.org/scripts/script.php?script_id=2136
    nnoremap <silent> <c-o> :put_<bar>call repeat#set("\<c-o>")<cr>k
else
    nnoremap <silent> <c-o> :put_<cr>k
endif

let mapleader = ','
nnoremap <leader> <c-w>
nnoremap <leader>, <c-w>p
nnoremap <leader>D :lcd %:p:h<cr>
nnoremap <leader>W <c-w>w
nnoremap <leader>w :w<cr>
nnoremap <leader>x :x<cr>
nnoremap j gj
nnoremap k gk

" Turn off search highlighting
nnoremap <silent> <c-n> :nohlsearch<cr>

" Alternate buffer (equivalent to :e #)
nnoremap <leader>a <c-^>

" Shortcut for switching to/from header files.
function! s:AlternateFile(...)
    for extension in a:000
        let path = expand('%:p:r').'.'.extension
        if filereadable(path) || bufexists(path)
            execute 'e'.fnameescape(path)
            return
        endif
    endfor

    echohl ErrorMsg
    let ext = (a:0 > 1) ? '{'.join(a:000, ',').'}' : a:1
    echo expand('%:p:r').'.'.ext.' not found.'
    echohl None
endfunction

" Shortcut for appending a semicolon at the end of a line.
function! s:AppendSemicolon()
    if pumvisible()
        call feedkeys("\<esc>a", 'n')
        call feedkeys(';;')
    elseif getline('.') !~ ';$'
        call setline('.', getline('.').';')
    endif
    return ''
endfunction

" Shortcut for toggling long lines past `textwidth`.
function! s:ToggleLongLineHighlight()
    if !exists('w:overLength')
        let w:overLength = matchadd('ErrorMsg', '.\%>'.(&textwidth + 1).'v', 0)
        echo 'Long lines highlighted'
    else
        call matchdelete(w:overLength)
        unlet w:overLength
        echo 'Long lines unhighlighted'
    endif
endfunction

" Shortcut for removing trailing whitespace.
function! s:RemoveWhitespace()
    if &binary
        return
    endif

    if search('\s\+$', 'n')
        let line = line('.')
        let col = col('.')
        silent %s/\s\+$//ge
        call cursor(line, col)

        echo 'Trailing whitespace removed!'
    else
        echo 'No trailing whitespace found.'
    endif
endfunction

" * and # should search for selected text when used in visual mode
function! s:VisualSearch()
    let old = @"
    normal! gvy
    let @/ = '\V'.substitute(escape(@", '\'), '\n', '\\n', 'g')
    let @" = old
endfunction

nnoremap <leader>H :<c-u>call<SID>ToggleLongLineHighlight()<cr>
nnoremap <silent> <leader>R :call<SID>RemoveWhitespace()<cr>
xnoremap * :<c-u>call<SID>VisualSearch()<cr>/<cr>
xnoremap # :<c-u>call<SID>VisualSearch()<cr>?<cr>

" Sane navigation in command mode
noremap! <c-a> <home>
noremap! <c-e> <end>
cnoremap <c-b> <left>
cnoremap <c-f> <right>
cnoremap <c-k> <c-\>estrpart(getcmdline(), 0, getcmdpos()-1)<cr>

" ... insert mode
inoremap <c-b> <left>
inoremap <c-f> <right>
inoremap <c-k> <c-o>D
inoremap <expr> <up> pumvisible() ? '<c-p>' : '<c-o>k'
inoremap <expr> <down> pumvisible() ? '<c-n>' : '<c-o>j'

" ... and visual mode
xnoremap v <esc>
xmap s S

" ============================
" Autocommands
" ============================

augroup rccommands
autocmd!

autocmd BufRead,BufNewFile *.h,*.m set filetype=objc
autocmd BufRead,BufNewFile *.json set filetype=javascript
autocmd BufRead,BufNewFile *.md set filetype=markdown

autocmd BufRead,BufNewFile *.h nnoremap <buffer> <silent> <leader>A :call<SID>AlternateFile('c', 'm', 'cpp', 'cc')<cr>
autocmd BufRead,BufNewFile *.{c\|m\|mm\|cpp\|cc} nnoremap <buffer> <silent> <leader>A :call<SID>AlternateFile('h')<cr>
autocmd FileType c,cpp,objc,rust inoremap <buffer> <silent> ;; <c-r>=<SID>AppendSemicolon()<cr>

autocmd FileType css,html,objc setlocal nowrap
autocmd FileType elm,haskell,fish,html,javascript,objc,rust,sh,swift,typescript,vim setlocal softtabstop=4
autocmd FileType elm,fish,haskell,html,javascript,objc,pyrex,python,ruby,sh,swift,typescript,vim setlocal expandtab
autocmd FileType elm,haskell,python,pyrex,sh setlocal textwidth=80 colorcolumn=80
autocmd FileType help,vim let&l:keywordprg=':help'
autocmd FileType javascript,rust,typescript setlocal textwidth=100 colorcolumn=100
autocmd FileType javascript,typescript setlocal indentexpr=cindent
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2
autocmd FileType swift setlocal textwidth=120 colorcolumn=120
augroup END
