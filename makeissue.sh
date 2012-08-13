#!/bin/bash

# Usage:
# Run as root
# ./makeissue.sh > /etc/issue
# Overwrites /etc/issue with this more colourful version
# /etc/issue appears in tty consoles (for one)

echo -e '\e[H\e[2J'
echo
echo
echo -e '                           \e[1;36m`'
echo -e '                          \e[1;36m-:'
echo -e '                         \e[1;36m.//:'
echo -e '                        \e[1;36m`////-'
echo -e '                       \e[1;36m`://///.'
echo -e '                       \e[1;36m:///////.'
echo -e '                      \e[1;36m-/////////.'
echo -e '                     \e[1;36m`://////////`'
echo -e '                    \e[1;36m-:..://///////`'
echo -e '                   \e[1;36m-////:::////////`'
echo -e '                  \e[1;36m-/////////////////`'
echo -e '                 \e[1;36m-//////////++++/////`'
echo -e '                \e[1;36m-////\e[0;36m++++oooooooooo+++.'
echo -e '               \e[0;36m-/+++oooooooooooooooooo+.     \e[1;37m//=========================---\e[0m'
echo -e '              \e[0;36m:+oooooooo+-..-/+oooooooo+.     \e[1;37m\\\\ \e[1;34m\s(\m) \\r\e[0m'
echo -e '            \e[0;36m`/ooooooooo:`     .+oooooooo+.     \e[1;37m\\\\\e[0m'
echo -e '           \e[0;36m`/ooooooooo/        .ooooooooo+-     \e[1;37m\\\\ \e[1;32m\\t\e[0m'
echo -e '          \e[0;36m`/oooooooooo`         /oooooo++++-     \e[1;37m\\\\ \e[1;32m\d\e[0m'
echo -e '         \e[0;36m`+ooooooooooo`         :oooooo++/-:.     \e[1;37m\\\\\e[0m'
echo -e '        \e[0;36m.+ooooooooooo+`         :+oooooooo+/-`     \e[1;37m\\\\ \e[1;31m\U\e[0m'
echo -e '       \e[0;36m.+oooooo++/:-.`          `..-:/++ooooo+:     \e[1;37m\\\\\e[0m'
echo -e '      \e[0;36m.+oo++/-.`                      `.-:++ooo:     \e[1;37m\\\\ \e[0;35m\l \e[0;37mon \e[0;33m\\n\e[0m'
echo -e '     \e[0;36m-++/-.`     \e[01;37mA simple, lightweight     \e[0;36m`-:++/`    \e[1;37m\\\\=========================---\e[0m'
echo -e '     \e[0;36m-++/-.`      \e[1;37mlinux distribution.      \e[0;36m`-:++/`     '
echo -e '    \e[0;36m.:.`                                       .--      \e[0m'
echo
echo
