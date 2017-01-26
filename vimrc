" Vundle ------------------------------------------------------------------ {{{
" Use vim instead of vi defaults (required)
set nocompatible
" (required)
filetype off
" set the runtime path to include Vundle and initialize
" (need to have downloaded Vundle in that folder)
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" required
Plugin 'VundleVim/Vundle.vim'

" Use this area to specify plugins you want to use

Plugin 'ctrlpvim/ctrlp.vim'
" Change keyboard for ctrlp to leader o
let g:ctrlp_map = '<Leader>o'

Plugin 'scrooloose/nerdtree'

Plugin 'tpope/vim-rails'

Plugin 'airblade/vim-gitgutter'

Plugin 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1

Plugin 'Valloric/YouCompleteMe'
" This is where rustup dumps the source. Can youcomplete me not do this
" automatically?
let g:ycm_rust_src_path = '/Users/ward/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src'
let g:ycm_python_binary_path = 'python'
let g:ycm_autoclose_preview_window_after_insertion = 1
" Note: semantic completion is never triggered automatically when at top level
" since this would be too slow. If you do need semantic completion, use ^space
" to trigger it. This is the YouCompleteMe command. You could use vim's omni-
" complete directly (^x ^o), but adviced to go through YouCompleteMe instead.

Plugin 'rust-lang/rust.vim'
let g:rust_fold = 1
" Became hella slow?
"let g:rustfmt_autosave = 1

" Creates tags files in memory and uses it to display the structure of your
" file. Note for LaTeX you will want to make sure you use ctags' HEAD version.
" The stable version (5.8 released in 2009) sucks.
Plugin 'majutsushi/tagbar'
" Also requires "extending" ctags by adding the rust definitions (find in rust
" repo) to a ~/.ctags file.
let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \'T:types,type definitions',
        \'f:functions,function definitions',
        \'g:enum,enumeration names',
        \'s:structure names',
        \'m:modules,module names',
        \'c:consts,static constants',
        \'t:traits,traits',
        \'i:impls,trait implementations',
    \]
\}
" Using ctags definition via https://github.com/majutsushi/tagbar/issues/70
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:headings',
        \ 'l:links',
        \ 'i:images'
    \ ],
    \ "sort" : 0
\ }

Plugin 'LaTeX-Box-Team/LaTeX-Box'
let g:LatexBox_Folding = 1

call vundle#end()            " required
filetype plugin indent on    " required
" }}}

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
" Highlight the line where our cursor is
set cursorline
" Enable mouse for different modes
" (Normal, Visual, Insert, Commandline, All)
set mouse=a
" Let vim set the window title
set title
" Always show status line
set laststatus=2
" Indicates the terminal is fast and more chars can be sent
set ttyfast
" Visual autocomplete for command menu
set wildmenu
" How to complete. longest:full goes for longest substring and shows the
" options. Subsequent tabs then start cycling through it.
set wildmode=longest:full,full
" Ignore node_modules folder (also covers ctrlp plugin)
set wildignore+=node_modules
" Ignore jekyll's target
set wildignore+=_site
" Ignore rust's target
set wildignore+=target

" Disable arrow keys (except for insert mode)
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" For use with ctags, looks for tags file in current folder
" and if not found, works its way up till it does
set tags=./tags;/

" Via vim-sensible
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

" Via vim-sensible
" Load matchit.vim, but only if the user hasn't installed a newer version.
" matchit makes % more useful visavis html tags etc
" Plugin is included by default in vim
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif
" }}}

" Leader stuff ------------------------------------------------------------ {{{
" Set space as the leader (should maybe be done earlier in the file? TODO)
let mapleader = "\<Space>"
" Copy/pasting to system clipboard with <Leader>copy stuff.
" (note on Ubuntu need vim-gnome for interaction with system clipboard, not
" regular vim)
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
" Toggle NERDTree (better place to put this?)
nmap <Leader>T :NERDTreeToggle<CR>
nmap <Leader>t :TagbarToggle<CR>
" }}}

" Search ------------------------------------------------------------------ {{{
" Ignore case when searching
set ignorecase
" But do it intelligently (case sensitive if the search has uppercase chars)
set smartcase
" Start searching as you type
set incsearch
" }}}

" Syntax Highlighting ----------------------------------------------------- {{{
syntax on
set background=dark
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
" }}}

if has("autocmd")
  filetype plugin indent on
  " Language specific settings -------------------------------------------- {{{
  " Python ---------------------------------------------------------------- {{{
  autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
  " Run current file in ipython and give shell (pip install ipython required)
  autocmd FileType python nmap <Leader>r :!ipython -i %<CR>
  " When teaching ICW, using idle is preferred
  "autocmd FileType python nmap <Leader>r :!idle -r % &<CR><CR>
  " }}}

  " Markdown -------------------------------------------------------------- {{{
  " My only .md files are markdown
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
  autocmd FileType markdown setlocal spell spelllang=en_gb
  autocmd FileType markdown setlocal autoindent
  autocmd FileType markdown setlocal makeprg=pandoc\ %\ -t\ latex\ --latex-engine=xelatex\ -o\ /tmp/%<.pdf
  autocmd FileType markdown nmap <Leader>v :!open /tmp/%<.pdf<CR><CR>
  " }}}

  " Latex ----------------------------------------------------------------- {{{
  " Enable spellcheck when writing in latex
  autocmd FileType tex setlocal spell spelllang=en_gb
  "autocmd FileType tex setlocal makeprg=latexmk\ %<
  "autocmd FileType tex setlocal foldmethod=marker
  " }}}

  " Go -------------------------------------------------------------------- {{{
  autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=0
  " }}}

  " R --------------------------------------------------------------------- {{{
  " Have make just run the current file
  autocmd FileType r setlocal makeprg=R\ --no-save\ -q\ <%
  " }}}

  " Vim ------------------------------------------------------------------- {{{
  autocmd FileType vim setlocal foldmethod=marker
  " }}}
  " }}}
  " Project specific settings --------------------------------------------- {{{
  " Does this stuff really belong in a vimrc? (No)
  " For STK tinkering, we use the project's defaults
  autocmd BufNewFile,BufRead /opt/supertuxkart/stk/src/* setlocal expandtab shiftwidth=4 softtabstop=4
  " cd.net project defaults
  autocmd BufNewFile,BufRead ~/sep/cd/repo/* setlocal expandtab shiftwidth=2 softtabstop=2
  " }}}
endif
