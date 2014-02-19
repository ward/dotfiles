#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#TEXT COLORS
TXTBLK='\e[0;30m'           # Black - Regular
TXTRED='\e[0;31m'           # Red
TXTGRN='\e[0;32m'           # Green
TXTYLW='\e[0;33m'           # Yellow
TXTBLU='\e[0;34m'           # Blue
TXTPUR='\e[0;35m'           # Purple
TXTCYN='\e[0;36m'           # Cyan
TXTWHT='\e[0;97m'           # White
BLDBLK='\e[1;30m'           # Black - Bold
BLDRED='\e[1;31m'           # Red
BLDGRN='\e[1;32m'           # Green
BLDYLW='\e[1;33m'           # Yellow
BLDBLU='\e[1;34m'           # Blue
BLDPUR='\e[1;35m'           # Purple
BLDCYN='\e[1;36m'           # Cyan
BLDWHT='\e[1;97m'           # White
UNDBLK='\e[4;30m'           # Black - Underline
UNDRED='\e[4;31m'           # Red
UNDGRN='\e[4;32m'           # Green
UNDYLW='\e[4;33m'           # Yellow
UNDBLU='\e[4;34m'           # Blue
UNDPUR='\e[4;35m'           # Purple
UNDCYN='\e[4;36m'           # Cyan
UNDWHT='\e[4;97m'           # White
BAKBLK='\e[40m'             # Black - Background
BAKRED='\e[41m'             # Red
BAKGRN='\e[42m'             # Green
BAKYLW='\e[43m'             # Yellow
BAKBLU='\e[44m'             # Blue
BAKPUR='\e[45m'             # Purple
BAKCYN='\e[46m'             # Cyan
BAKWHT='\e[47m'             # White
TXTRST='\e[0m'              # Text Reset

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
