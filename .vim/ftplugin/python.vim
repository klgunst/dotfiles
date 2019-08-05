setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix
setlocal foldmethod=indent
setlocal encoding=utf-8
setlocal makeprg=python3\ %

:match ExtraWhitespace /\s\+\%#\@<!$/
:autocmd InsertLeave * redraw!

"autocomment
noremap <buffer> <localleader>c ^I# <esc>
"should not be for operatormode
ounmap <buffer> <localleader>c

noremap <buffer> <localleader>a o"""<CR>"""<Esc>kA
