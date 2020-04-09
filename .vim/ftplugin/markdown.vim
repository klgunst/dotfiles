setl spell
setl nojs
setl list
"Setting digraph easier to input as <char1><BS><char2>
setl digraph

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
