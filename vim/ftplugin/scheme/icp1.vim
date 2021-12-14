function! s:OpenR5RS(path)
  let prelude = [
        \ "(#%require xrepl)",
        \ "(load \"" . a:path . "\")",
        \ "\<CR>"
        \ ]->join("")
  let s:term = term_start("plt-r5rs --no-prim", {"term_finish": "close"})
  call term_sendkeys("", prelude)
endfunction

function! s:GetVisualSelection()
  try
    let a_save = @a
    normal! gv"ay
    return @a
  finally
    let @a = a_save
  endtry
endfunction

function! s:SendR5RSkeys()
  call term_sendkeys(s:term, s:GetVisualSelection() . "\n")
endfunction

nnoremap <buffer> <LocalLeader>s :call <sid>OpenR5RS(@%)<CR>
" <c-u> ensures the function is only called once in a multiline visual block
" xmap is like vmap but without selection mode
xnoremap <buffer> <LocalLeader>r :<c-u>call <sid>SendR5RSkeys()<CR>

