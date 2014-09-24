" File: .vimrc
" Author: Michael Sanders

" ============================
" 1. Plugins
" ============================
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'Keithbsmiley/swift.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'fatih/vim-go'
Plugin 'gmarik/Vundle.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'topfunky/PeepOpen-EditorSupport'
Plugin 'wincent/Command-T'

let g:goyo_width=100

call vundle#end()
filetype plugin indent on

" ============================
" 2. Settings
" ============================

" Autocompletion
set wildignore+=*.o,*.obj,*.pyc,*.DS_Store,*.db,*.git
set wildmenu
set undofile
set undodir=/tmp

if exists('+wildignorecase')
	set wildignorecase
endif

" Backup
set nobackup
set nowritebackup
set noswapfile

" Buffers
set encoding=utf-8
set autoread
set hidden

" Display
set rulerformat=%l:%c ruler
set shortmess=atI
set showcmd
set titlestring=%f title

" Editing
set backspace=2
set nofoldenable
set pastetoggle=<f2>
set shiftwidth=4
set tabstop=4
set textwidth=80

" Searching
set gdefault
set hlsearch
set ignorecase
set smartcase

" Default plugins in Vim expect a POSIX-compliant shell
if &shell !~ '/sh$'
	set shell=/bin/sh
endif

" Mac options
if has('mac')
	function! s:PBCopy()
		let old = @"
		normal! gvy
		call system('pbcopy', @")
		let @" = old
	endfunction

	vnoremap <silent> "+y :<c-u>call<SID>PBCopy()<cr>
	vmap "+Y "+y
endif

" GUI options
if has('gui_running')
	set columns=101 lines=38 " Default window size
	set guicursor=a:blinkon0 " Disable blinking cursor
	set guifont=Menlo\ Regular:h13
	set guioptions=ha

	inoremap <d-\> <esc>:Goyo<cr>
	nnoremap <d-\> :Goyo<cr>
endif

" Syntax (must go after :set guioptions+=M)
set t_Co=16
if !&diff
	syntax on
	set background=dark
	color solarized
endif

" ============================
" 3. Macros
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

" Y ought to be to y as D is to d and C is to c
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

" Turn off search highlighting
nnoremap <silent> <c-n> :nohlsearch<cr>

" Alternate buffer (equivalent to :e #)
nnoremap <leader>a <c-^>

" Alternate file
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

autocmd BufRead,BufNewFile *.h nnoremap <buffer> <silent> <leader>A :call<SID>AlternateFile('c', 'm', 'cpp', 'cc')<cr>
autocmd BufRead,BufNewFile *.{c\|m\|mm\|cpp\|cc} nnoremap <buffer> <silent> <leader>A :call<SID>AlternateFile('h')<cr>

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

nnoremap <leader>H :<c-u>call<SID>ToggleLongLineHighlight()<cr>

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

nnoremap <silent> <leader>R :call<SID>RemoveWhitespace()<cr>

" * and # should search for selected text when used in visual mode
function! s:VisualSearch()
	let old = @"
	normal! gvy
	let @/ = '\V'.substitute(escape(@", '\'), '\n', '\\n', 'g')
	let @" = old
endfunction

xnoremap * :<c-u>call<SID>VisualSearch()<cr>/<cr>
xnoremap # :<c-u>call<SID>VisualSearch()<cr>?<cr>

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

autocmd FileType c,objc,cpp,perl inoremap <buffer> <silent> ;; <c-r>=<SID>AppendSemicolon()<cr>

" Sane navigation in command mode
noremap! <c-a> <home>
noremap! <c-e> <end>
cnoremap <c-h> <left>
cnoremap <c-l> <right>
cnoremap <c-b> <s-left>
cnoremap <c-f> <s-right>
cnoremap <c-k> <c-\>estrpart(getcmdline(), 0, getcmdpos()-1)<cr>

" ... insert mode
inoremap <silent> <c-b> <c-o>b
inoremap <silent> <c-f> <esc>ea
inoremap <c-h> <left>
inoremap <c-l> <right>
inoremap <c-k> <c-o>D
inoremap <expr> <up> pumvisible() ? '<c-p>' : '<c-o>k'
inoremap <expr> <down> pumvisible() ? '<c-n>' : '<c-o>j'

" ... and visual mode
xnoremap m g_
xnoremap v <esc>

" ============================
" 3. Autocommands
" ============================

" Automatically open the quickfix window on :make
" from: http://vim.wikia.com/wiki/Automatically_open_the_quickfix_window_on_:make
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost l* nested lwindow

autocmd BufRead,BufNewFile *.h set filetype=objc
autocmd BufRead,BufNewFile *.json set filetype=javascript
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd FileType coffee setlocal indentexpr=indent
autocmd FileType haskell setlocal makeprg=ghci\ \"%:p\"
autocmd FileType help nnoremap <buffer> q <c-w>q
autocmd FileType html setlocal expandtab softtabstop=4
autocmd FileType html setlocal nowrap
autocmd FileType objc setlocal textwidth=100
autocmd FileType objc,python,scheme,haskell,ruby,typescript,coffee setlocal expandtab
autocmd FileType python setlocal makeprg=python\ -t\ \"%:p\"
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2
autocmd FileType typescript,coffee,javascript setlocal cursorcolumn
autocmd FileType typescript,coffee,javascript,css setlocal softtabstop=2 nowrap
autocmd FileType typescript,javascript setlocal indentexpr=cindent textwidth=110
autocmd FileType vim,help let&l:keywordprg=':help'
