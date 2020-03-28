" Small hacks to force some syntax highlighting on register machines of ICP1
" course. Not sure I am really satisfied with it yet, but also do not want to
" delve into vim syntax inner workings.

" Downside is this ruins the prettier parentheses highlighting they use for
" lists. It makes sense in that you would have no other syntax markers in a
" list otherwise, but still.
syn region icp1RegisterMachine matchgroup=schemeParentheses start=/'(start/ end=/)/ contains=ALLBUT,schemeUnquote,schemeDatumCommentForm,@schemeImportCluster

syn keyword schemeSyntax assign
syn keyword schemeSyntax branch
syn keyword schemeSyntax goto
syn keyword schemeSyntax perform
syn keyword schemeSyntax restore
syn keyword schemeSyntax save
syn keyword schemeSyntax test
syn keyword schemeSyntax const
syn keyword schemeSyntax label
syn keyword schemeSyntax op
syn keyword schemeSyntax reg
