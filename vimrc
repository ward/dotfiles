" Set space as the leader
let mapleader = "\<Space>"

" vim-plug ------------------------------------------------------------------ {{{
" Download plug.vim (junegunn/vim-plug) and put it in autoload directory
call plug#begin('~/.vim/plugged')

" General plugins

" --bin ensures local install, I do not want vim to manage global commands
" (however, it seems it might have picked up on my existing fzf installation)
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdtree'

Plug 'airblade/vim-gitgutter'

Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1
" Override their line and column count (did not care for percentages)
" 3 char padded current line / total lines <space> 2 char padded column
let g:airline_section_z = "%3l/%L %2v"

" Pressing tab in insert mode triggers various vim built-in completions
Plug 'ajh17/VimCompletesMe'

" Creates tags files in memory and uses it to display the structure of your
" file. Note for LaTeX you will want to make sure you use ctags' HEAD version.
" The stable version (5.8 released in 2009) sucks.
Plug 'majutsushi/tagbar'
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

" Asynchronous lint engine
Plug 'w0rp/ale'
" Disable for rust, we use LSP
let g:ale_linters = {
      \ 'rust': [],
      \ 'ocaml': [],
      \ 'python': [],
      \}

" Language Server Protocol client
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
" Note you may need vim patch 5xx for yellow/red highlighting of warnings and errors
" Echo warning/error under cursor in normal mode
let g:lsp_diagnostics_echo_cursor = 1
" Prettier signs
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}
" Debug logging
" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
" TODO: Make lsp fill up tags?
" See: https://github.com/prabirshrestha/vim-lsp/issues/321#issuecomment-473492723
" Set up Rust
" Be sure to: rustup component add rls rust-analysis rust-src
if executable('rls')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': { server_info->['rustup', 'run', 'stable', 'rls'] },
        \ 'workspace_config': { 'rust': { 'clippy_preference': 'on' } },
        \ 'whitelist': ['rust'],
        \ })
  au FileType rust set omnifunc=lsp#complete
  " Use my tags muscle memory to go to definitions
  " TODO: C-T does not work since tag stack is not updated.
  " There does not seem to be a function for pushing on the tag stack.
  " Update: Seems to be fixed upstream? Need to confirm some more.
  au FileType rust nnoremap <buffer> <C-]> :LspDefinition<CR>
  " Lets you use K to lookup keyword under cursor
  au FileType rust setlocal keywordprg=:LspHover
endif

if executable('ocamlmerlin-lsp')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'ocamlmerlin-lsp',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'opam config exec -- ocamlmerlin-lsp']},
        \ 'whitelist': ['ocaml'],
        \ })
  au FileType ocaml nnoremap <buffer> <C-]> :LspDefinition<CR>
  au FileType ocaml setlocal keywordprg=:LspHover
  au FileType ocaml setlocal omnifunc=lsp#complete
endif

if executable('pyls')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
  au FileType python nnoremap <buffer> <C-]> :LspDefinition<CR>
  " Does not seem to work as I hoped here?
  au FileType python setlocal keywordprg=:LspHover
endif

" Improved ^A and ^X (incrementing and decrementing numbers)
" Adds support for dates, time, some other stuff
Plug 'tpope/vim-speeddating'

" Handle calling the formatter of a language so we do not need to worry about
" things. Will just pick up on what is installed.
Plug 'sbdchd/neoformat'
" If no formatter found, just does regular = on entire document
let g:neoformat_basic_format_align = 1
" There are also fallbacks for tabs to spaces and removing trailing spaces
nnoremap <Leader>= :Neoformat<CR>

Plug 'dbeniamine/todo.txt-vim'
autocmd BufNewFile,BufRead *.todo set ft=todo

" Language specific plugins

Plug 'tpope/vim-rails'

Plug 'rust-lang/rust.vim'
let g:rust_fold = 1
" Became hella slow?
let g:rustfmt_autosave = 1

Plug 'LaTeX-Box-Team/LaTeX-Box'
let g:LatexBox_Folding = 1

call plug#end()
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
" Ignore node_modules folder
set wildignore+=*/node_modules/*
" Ignore jekyll's target
set wildignore+=*/_site/*
" Ignore rust's target
set wildignore+=*/target/*

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

" The let _s=@/ saves your register content and then puts it back afterwards
" The <Bar> is a |, so I guess piping commands
command StripTrailingSpaces let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s

" Toggle showing these with :set list!
set listchars=trail:·,tab:»·,eol:¬
" }}}

" Set keyboard shortcuts -------------------------------------------------- {{{
" Disable arrow keys (except for insert mode)
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Copy/pasting to system clipboard with <Leader>copy stuff.
" (note on Ubuntu need vim-gnome for interaction with system clipboard, not
" regular vim)
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
" Toggle NERDTree and tagbar info
nmap <Leader>T :NERDTreeToggle<CR>
nmap <Leader>t :TagbarToggle<CR>
" fzf plugin to open files
nmap <Leader>o :Files<CR>

" In insert mode, press CTRL+L to fix the most recent spelling mistake by
" using the first suggestion. <c-g>u enables undoing it the regular way.
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Open vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" C-X C-K triggers dictionary complete
" Default is non fuzzy and only works when spell is turned on. Advantage:
" different languages. Can I make it use the spell dictionary instead of a
" hardcoded location?
" inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /usr/share/dict/words')
" }}}

" Search ------------------------------------------------------------------ {{{
" Ignore case when searching
set ignorecase
" But do it intelligently (case sensitive if the search has uppercase chars)
set smartcase
" Start searching as you type
set incsearch
" Show search matches (after search, turn off temporarily with :noh
" (:nohlsearch)
set hlsearch

" If ag is installed, use it instead of grep
" Can use :grep in vim now and ag will be used
" Step through results with :cnext and :cprev. :clist to show all.
" (Just quickfix stuff really)
" Note that fzf plugin provides both :Rg and :Ag which are probably nicer
if executable('ag')
    " Note we extract the column as well as the file and line number
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m
endif
" Prefer rg over ag
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" }}}

" Syntax Highlighting ----------------------------------------------------- {{{
syntax on
set background=dark
" Find schemes in /usr/share/vim/vim73/colors/
colorscheme industry
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
  " I believe the following should technically work on anything that pandoc
  " takes as input.
  function s:pandoc_to_html()
    :!pandoc "%" --number-sections -t html --css ~/.dotfiles/pandoc/htmlstylesheet.css -s -o /tmp/%:t.html
    let b:pandoc_to_what_last = '.html'
  endfunction
  function s:pandoc_to_pdf()
    :!pandoc "%" -t latex --pdf-engine=xelatex -o "/tmp/%:t.pdf"
    let b:pandoc_to_what_last = '.pdf'
  endfunction
  function s:pandoc_open_last_made()
    execute "!open /tmp/%:t" . b:pandoc_to_what_last
  endfunction
  command PandocToHtml call <SID>pandoc_to_html()
  command PandocToPdf call <SID>pandoc_to_pdf()
  nmap <Leader>v :call <SID>pandoc_open_last_made()<CR><CR>
  " }}}

  " Dot ------------------------------------------------------------------ {{{
  autocmd FileType dot setlocal makeprg=dot\ -Tpng\ %\ >\ /tmp/%<.png\ &&\ return\ 0
  autocmd FileType dot nmap <Leader>v :!open /tmp/%<.png<CR><CR>
  " }}}

  " Latex ----------------------------------------------------------------- {{{
  " Enable spellcheck when writing in latex
  autocmd FileType tex setlocal spell spelllang=en_gb
  "autocmd FileType tex setlocal makeprg=latexmk\ %<
  "autocmd FileType tex setlocal foldmethod=marker
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
  autocmd BufNewFile,BufRead ~/prog/sep/cursusdienst/* setlocal expandtab shiftwidth=2 softtabstop=2
  " Convoluted so I can also start `vim` without arguments and have the
  " settings applied still. Regular matching was failing me.
  function IgnoreTmp()
    if getcwd() == expand("~/prog/sep/cursusdienst")
      setlocal wildignore+=*/tmp/*
    endif
  endfunction
  autocmd VimEnter * call IgnoreTmp()
  " }}}
endif

" Trying out things in order to seamlessly work with Scheme in class.
function! OpenR5RS(path)
  let prelude = [
        \ "(#%require xrepl)",
        \ "(load \"" . a:path . "\")",
        \ "\<CR>"
        \ ]->join("")
  let term = term_start("plt-r5rs --no-prim", {"term_finish": "close"})
  call term_sendkeys("", prelude)
endfunction

autocmd FileType scheme nnoremap <LocalLeader>s :call OpenR5RS(@%)<CR>
