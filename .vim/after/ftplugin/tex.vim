let g:vimtex_doc_handlers = ['MyHandler']
function! MyHandler(context)
  call vimtex#doc#make_selection(a:context)
  if !empty(a:context.selected)
    execute '!texdoc' a:context.selected '&'
  endif
  return 1
endfunction
