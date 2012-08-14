#!/bin/bash

# Usage:
# Run as root
# ./makeissue.sh > /etc/issue
# Overwrites /etc/issue with this more colourful version
# /etc/issue appears in tty consoles (for one)
# See `man agetty` for escape sequences

echo -e '\e[H\e[2J'
echo -e '       \e[1;34m, \e[1;37m             \s(\m) \\r'
echo -e '      \e[1;34m/#\\\\ \e[1;37m            \U'
echo -e '     \e[1;34m,###\\\\ \e[1;37m           \l on \\n'
echo -e '    \e[1;34m/#####\\\\ \e[1;37m'
echo -e '   \e[1;34m/##\e[0;34m,-,##\\\\ \e[1;37m'
echo -e '  \e[0;34m/##(   )##` '
echo -e ' \e[0;34m/#.--   --.#\\\\ \e[1;37m       Make it simple and lightweight.'
echo -e '\e[0;34m/`           `\\\\ \e[0m '
