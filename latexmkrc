$pdf_mode = 1;
$pdf_previewer = "xdg-open";
# Use xelatex by default
#$pdflatex = "xelatex %O %S";
# Forgot what this one was
#$dvi_mode = $postscript_mode = 0;

# Add a custom compile step. When looking for a x.pdf file, see if there is a
# x.dot file. If that is the case, call the dot program to compile it into a
# pdf.
sub dottopdf {
  my $name = shift;
  system("dot -Tpdf $name.dot > $name.pdf");
}
add_cus_dep("dot", "pdf", 0, "dottopdf");
