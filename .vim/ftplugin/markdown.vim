setl spell
setl nojs
setl list

setlocal makeprg=pandoc\ %\ --pdf-engine=xelatex

"Folding
function! MarkdownLevel()
  let h = matchstr(getline(v:lnum), '^#\+')
  if empty(h)
    return "="
  else
    return ">" . len(h)
  endif
endfunction

setlocal foldexpr=MarkdownLevel()
setlocal foldmethod=expr
