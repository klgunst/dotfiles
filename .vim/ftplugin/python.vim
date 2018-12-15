setlocal tabstop=8
setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal foldmethod=indent

"autocomment
noremap <buffer> <localleader>c ^I#<esc>
"should not be for operatormode
ounmap <buffer> <localleader>c
