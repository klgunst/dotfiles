"autocomment
setlocal nowrap
noremap <buffer> <localleader>c ^I#<esc>
"should not be for operatormode
ounmap <buffer> <localleader>c

setlocal makeprg=bash\ %
