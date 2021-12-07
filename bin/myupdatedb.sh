#!/bin/bash

# Updates my local mlocate db.
# Encrypted home directory was not being indexed by locate.
# Fix it by forcing own indexing.
# Requires $LOCATE_PATH to be set to the same file for locate to pick
# up on it.

IGNORE_PATHS="$HOME/.rbenv $HOME/.npm $HOME/.nvm $HOME/.gem $HOME/.rustup $HOME/.cargo $HOME/.mozilla"

updatedb -l 0 -e "$IGNORE_PATHS" -o $HOME/.local/share/mlocate.db -U $HOME
