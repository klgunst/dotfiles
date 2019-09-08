setl spell
"setl fo+=aw
setl nojs
setl list

setlocal makeprg=pandoc\ %\ --pdf-engine=xelatex\ -o\ '%:r'.pdf
