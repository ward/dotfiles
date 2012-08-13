#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
	PATH="$HOME/bin:$PATH"
fi

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias more='less'

# usage: remindme <time> <text>
# e.g.: remindme 10m "omg, the pizza"
function remindme()
{
	sleep $1 && zenity --info --text "$2" &
}


export EDITOR=vim
# Make sure we don't have to do this every time we use SVN
export SVN_EDITOR=vim
