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
# Redirect to stdout, cut between :  and <
alias myip='wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\  -f 2 | cut -d\< -f 1'

# usage: remindme <time> <text>
# e.g.: remindme 10m "omg, the pizza"
function remindme()
{
	sleep $1 && zenity --info --text "$2" &
}

# Extract various archives
extract () {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xvf $1        ;;
			*.tar.gz)    tar xvf $1     ;;
			*.bz2)       bunzip2 $1       ;;
			*.rar)       unrar x -ad $1     ;;
			*.gz)        gunzip $1     ;;
			*.tar)       tar xvf $1        ;;
			*.tbz2)      tar xvf $1      ;;
			*.tgz)       tar xvf $1       ;;
			*.zip)       unzip $1     ;;
			*.Z)         uncompress $1  ;;
			*.7z)        7z x $1    ;;
			*)           echo "'$1' cannot be extracted by extract" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

function random()
{
	if [ -z "$1" ]
	then
		echo $RANDOM
	else
		number=$RANDOM
		let "number %= $1"
		echo $number
	fi
}


export EDITOR=vim
# Make sure we don't have to do this every time we use SVN
export SVN_EDITOR=vim
