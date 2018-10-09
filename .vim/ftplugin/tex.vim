set tabstop=8
set expandtab
set shiftwidth=2
set softtabstop=2
set foldmethod=indent

"spell check
set spell

"text width to 80
set textwidth=80

"disable highlighting of italics and bold
hi clear texItalStyle
hi clear texBoldStyle

let g:vimtex_compiler_method='latexmk'
let g:vimtex_view_general_viewer = 'evince'

if empty(v:servername) && exists('*remote_startserver')
    call remote_startserver('VIM')
endif
