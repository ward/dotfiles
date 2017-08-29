#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#TEXT COLORS
TXTBLK='\[\e[0;30m\]'           # Black - Regular
TXTRED='\[\e[0;31m\]'           # Red
TXTGRN='\[\e[0;32m\]'           # Green
TXTYLW='\[\e[0;33m\]'           # Yellow
TXTBLU='\[\e[0;34m\]'           # Blue
TXTPUR='\[\e[0;35m\]'           # Purple
TXTCYN='\[\e[0;36m\]'           # Cyan
TXTWHT='\[\e[0;97m\]'           # White
BLDBLK='\[\e[1;30m\]'           # Black - Bold
BLDRED='\[\e[1;31m\]'           # Red
BLDGRN='\[\e[1;32m\]'           # Green
BLDYLW='\[\e[1;33m\]'           # Yellow
BLDBLU='\[\e[1;34m\]'           # Blue
BLDPUR='\[\e[1;35m\]'           # Purple
BLDCYN='\[\e[1;36m\]'           # Cyan
BLDWHT='\[\e[1;97m\]'           # White
UNDBLK='\[\e[4;30m\]'           # Black - Underline
UNDRED='\[\e[4;31m\]'           # Red
UNDGRN='\[\e[4;32m\]'           # Green
UNDYLW='\[\e[4;33m\]'           # Yellow
UNDBLU='\[\e[4;34m\]'           # Blue
UNDPUR='\[\e[4;35m\]'           # Purple
UNDCYN='\[\e[4;36m\]'           # Cyan
UNDWHT='\[\e[4;97m\]'           # White
BAKBLK='\[\e[40m\]'             # Black - Background
BAKRED='\[\e[41m\]'             # Red
BAKGRN='\[\e[42m\]'             # Green
BAKYLW='\[\e[43m\]'             # Yellow
BAKBLU='\[\e[44m\]'             # Blue
BAKPUR='\[\e[45m\]'             # Purple
BAKCYN='\[\e[46m\]'             # Cyan
BAKWHT='\[\e[47m\]'             # White
TXTRST='\[\e[0m\]'              # Text Reset

# Default interaction prompt
PS1="${TXTWHT}${BAKRED}[\u@\h \W]\$${TXTRST} "
# Continuation prompt (if using \ on the previous line in a command)
PS2="${TXTWHT}${BAKRED}>${TXTRST} "
# Prompt used by select inside scripts
#PS3
# Prompt used when tracing output with set -x
#PS4
# Command executed before PS1 is shown
#PROMPT_COMMAND

#### HISTORY DEFAULTS

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Record each line as it gets issued
PROMPT_COMMAND='history -a'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# Use standard ISO 8601 timestamp for `history`
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

# Do not record some commands
HISTIGNORE="ls:clear:l:ll"


# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# usage: remindme <time> <text>
# e.g.: remindme 10m "omg, the pizza"
function remindme()
{
    sleep $1 && zenity --info --text "$2" &
}

export EDITOR=vim
# Make sure we don't have to do this every time we use SVN
export SVN_EDITOR=vim
