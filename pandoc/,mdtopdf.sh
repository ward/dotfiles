#!/bin/bash

DEFAULTS_LOCATION="$HOME/.dotfiles/pandoc/typst.defaults.yml"
filename="$1"
output="$filename.pdf"

pandoc "$filename" -t pdf --pdf-engine=typst --defaults="$DEFAULTS_LOCATION" -s -o "$output"

# See template for a filetype with
# pandoc -D typst
# The typst one checks whether a template variable is passed along (it being a
# file). If so, it imports it, otherwise it imports the default, which you can
# see with
# pandoc --print-default-data-file=templates/template.typst
# So I took that, copied it and changed paper size and margins to begin with.
# Then this script compiles using that file
# Buuuut... import doesnt resolve absolute paths? Just replacing the entire
# pandoc template then rather than the typst template.
# Pandoc verbose flag outputs the typst too, if you need to debug.
