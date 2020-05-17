# Set up the prompt

autoload -Uz promptinit
promptinit
prompt clint

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
case $(uname) in
  Linux)
    eval "$(dircolors -b)"
    ;;
  Darwin)
    export LSCOLORS="Gxfxcxdxbxegedabagacad"
    ;;
esac
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#######

# Make up/down arrow limit history to the part you already typed
# (via ArchWiki)
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

# Digraphs
autoload insert-composed-char
zle -N insert-composed-char
bindkey ^K insert-composed-char

# We totally have colour
export TERM=xterm-256color
export EDITOR=vim
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Aliases
case $(uname) in
  Linux)
    alias ls='ls --color=auto'
    ;;
  Darwin)
    alias ls='ls -G'
    ;;
esac
alias grep='grep --color=auto'
alias l='ls -lF'
alias ll='ls -alF'
alias shuf="perl -MList::Util=shuffle -e 'print shuffle(<STDIN>);'"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias cdgit='cd $(git rev-parse --show-toplevel)'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# View markdown file as a man page
function mman {
  pandoc -s -t man "$1" | groff -T utf8 -man | ${PAGER:-less}
}
## An alias for when you encounter an open directory with books.
# The --accept screws you over when the path/filename gets too long. wget
# automatically rewrites the file name when it gets too long. In doing so, the
# extension is likely to disappear and become ".tmp". Of course, that does not
# match and the file is deleted despite it being what you wanted. <_< Adding
# tmp in accept seems to work, then explicitly rejecting index.html.tmp to not
# become all cluttered.
alias wget-books='wget --recursive --no-clobber --no-parent --accept epub,mobi,pdf,tmp,cbr,cbz --reject index.html.tmp'

# Ensure the encrypted home directory is also searched
# Be sure to run ~/bin/myupdate.sh (or cron it)
export LOCATE_PATH=$HOME/.local/share/mlocate.db

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Notify if a reboot is required
if [ -f /var/run/reboot-required ]; then
  cat /var/run/reboot-required
  if [ -f /var/run/reboot-required.pkgs ]; then
    echo "for package(s):"
    cat /var/run/reboot-required.pkgs
  fi
fi

# Add rbenv
if [ -d "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  rbenv-update() {
    local current=$(pwd)
    cd $HOME/.rbenv
    echo "Running git pull in $(pwd)"
    git pull
    cd plugins/ruby-build
    echo "Running git pull in $(pwd)"
    git pull
    cd $current
  }
fi

# Only load nodejs when asked to
function load_node() {
  export NVM_DIR="$HOME/.nvm"
  if [ -s "/usr/local/opt/nvm/nvm.sh" ]; then
    # macOS homebrew installation
    . "/usr/local/opt/nvm/nvm.sh"
  elif [ -s "$NVM_DIR/nvm.sh" ]; then
    # Manual installation
    . "$NVM_DIR/nvm.sh"
  fi
  if [ -s "/usr/local/opt/nvm/etc/bash_completion" ]; then
    # macOS homebrew installation
    # TODO: Is there something for the manual installation
    . "/usr/local/opt/nvm/etc/bash_completion"
  fi
}

# Rust
if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# Anaconda python
if [ -d "$HOME/.anaconda3/bin" ]; then
  export PATH="$HOME/.anaconda3/bin:$PATH"
fi

if [ -x "$(command -v fzf)" ]; then
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

  alias fzf='fzf --bind "ctrl-o:execute(xdg-open {}&)"'
  function fzfd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) && cd "$dir"
  }
fi
