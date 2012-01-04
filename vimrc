" Random ------------------------------------------------------------------ {{{
set nocompatible                                           " Use vim instead of vi defaults
set encoding=utf-8                                         " Encoding to 32bit UTF-8 Unicode
set showmode                                               " Show --INSERT-- etc mode when in one
set ruler                                                  " Show where in the document we are
set backspace=indent,eol,start                             " Allow backspacing over everything in insert mode
set number                                                 " Print line numbers
set cursorline                                             " Highlight the line where our cursor is
set ignorecase                                             " Ignore case when searching
set mouse=a                                                " Enable mouse for different modes
                                                           " (Normal, Visual, Insert, Commandline, All)
set title                                                  " Let vim set the window title
set laststatus=2                                           " Always show status line
set ttyfast                                                " Indicates the terminal is fast and more chars can be sent
" }}}

" Syntax Highlighting ----------------------------------------------------- {{{
syntax on
set background=dark
colorscheme darkblue                                       " Find schemes in /usr/share/vim/vim73/colors/
" }}}

" Tabs, spacing, wrapping ------------------------------------------------- {{{
set tabstop=2                                              " Change tabwidth to N in insert mode
set shiftwidth=2                                           " Change tabwidth to N in normal mode (>> and << operators)
set softtabstop=2                                          " Optional inbetween tabs
set noexpandtab                                            " Don't turn tabs into spaces
set wrap                                                   " Wraps display, NOT BUFFER

" For Python, we want 4 spaces instead of tabs
if has("autocmd")
	filetype plugin indent on
	autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
endif
" }}}
