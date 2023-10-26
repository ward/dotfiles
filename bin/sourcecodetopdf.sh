#!/bin/bash

sourcecode="$1"
format="$2"
tmpmd=/tmp/sourcecodetopdf.md
outpdf=${sourcecode%.*}.pdf
codedelin='```'

echo "$codedelin$format" >$tmpmd
cat $sourcecode >>$tmpmd
echo "$codedelin" >>$tmpmd

pandoc -o $outpdf $tmpmd
