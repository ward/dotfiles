" Random ------------------------------------------------------------------ {{{
" Use vim instead of vi defaults
set nocompatible
" Encoding to 32bit UTF-8 Unicode
set encoding=utf-8
" Show --INSERT-- etc mode when in one
set showmode
" Show where in the document we are
set ruler
" Allow backspacing over everything in insert mode
set backspace=indent,eol,start
" Print line numbers
set number
" Don't highlight the line where our cursor is
set nocursorline
" Ignore case when searching
set ignorecase
" Enable mouse for different modes
" (Normal, Visual, Insert, Commandline, All)
set mouse=a
" Let vim set the window title
set title
" Always show status line
set laststatus=2
" Indicates the terminal is fast and more chars can be sent
set ttyfast

" For use with ctags, looks for tags file in current folder
" and if not found, works its way up till it does
set tags=./tags;/

" }}}

" Syntax Highlighting ----------------------------------------------------- {{{
syntax on
"set background=dark
" Find schemes in /usr/share/vim/vim73/colors/
"colorscheme darkblue
" }}}

" Tabs, spacing, wrapping ------------------------------------------------- {{{
" Change tabwidth to N in insert mode
set tabstop=2
" Change tabwidth to N in normal mode (>> and << operators)
set shiftwidth=2
" Optional inbetween tabs
set softtabstop=2
" Turn tabs into spaces
set expandtab
" Wraps display, NOT BUFFER
set wrap

if has("autocmd")
	" For Python, we want 4 spaces instead of tabs
	filetype plugin indent on
	autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
	" For STK tinkering, we use the project's defaults
	autocmd BufNewFile,BufRead /opt/supertuxkart/stk/src/* setlocal expandtab shiftwidth=4 softtabstop=4
	" cd.net project defaults
	autocmd BufNewFile,BufRead ~/sep/cd/repo/* setlocal expandtab shiftwidth=2 softtabstop=2
	" My only .md files are markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif
" }}}
