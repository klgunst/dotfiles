setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix
setlocal foldmethod=indent
setlocal encoding=utf-8

:match ExtraWhitespace /\s\+\%#\@<!$/
:autocmd InsertLeave * redraw!

"This is for error navigation
nnoremap <buffer> <localleader>ne :lnext<cr>
nnoremap <buffer> <localleader>pe :lprevious<cr>

"autocomment
noremap <buffer> <localleader>c ^I# <esc>
"should not be for operatormode
ounmap <buffer> <localleader>c

noremap <buffer> <localleader>a o'''<CR>'''<Esc>kA
