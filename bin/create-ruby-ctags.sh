#!/bin/sh

# You will want to run this in your ruby project's folder
# Will set ctags for your project as well as everything in your bundled gems
TAGSFILE=tags
ctags -R -f $TAGSFILE && bundle show --paths | xargs ctags -R -a -f $TAGSFILE
