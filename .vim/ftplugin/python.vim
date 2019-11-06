setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix
setlocal foldmethod=indent
setlocal encoding=utf-8
setlocal makeprg=python3\ %
setlocal errorformat^=%-G%f:%l:\ H5pyDeprecationWarning%.%#

:match ExtraWhitespace /\s\+\%#\@<!$/
:autocmd InsertLeave * redraw!

"autocomment
noremap <buffer> <localleader>c ^I# <esc>
"should not be for operatormode
ounmap <buffer> <localleader>c

noremap <buffer> <localleader>a o"""<CR>"""<Esc>kA

"For Jedi-Vim
let g:jedi#popup_on_dot=0
