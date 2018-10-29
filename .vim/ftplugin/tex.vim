setlocal tabstop=8
setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal foldmethod=indent

"spell check
setlocal spell

"text width to 80
setlocal textwidth=80

"disable highlighting of italics and bold
hi clear texItalStyle
hi clear texBoldStyle

let g:vimtex_compiler_method='latexmk'
let g:vimtex_view_general_viewer = 'evince'

if empty(v:servername) && exists('*remote_startserver')
    call remote_startserver('VIM')
endif

" Macros
nnoremap <buffer> <localleader>eq o\begin{equation}<cr>\end{equation}<esc>O
nnoremap <buffer> <localleader>al o\begin{align}<cr>\end{align}<esc>O
nnoremap <buffer> <localleader>fig o\begin{figure}[!ht]<cr>\centering<cr>\includegraphics{}<cr>\caption{}<cr>\end{figure}<esc>/includegra<cr>f{a
nnoremap <buffer> <localleader>ev :split $HOME/.vim/ftplugin/tex.vim<cr>
nnoremap <buffer> <localleader>pc :Papis<cr>
nnoremap <buffer> <localleader>pv :PapisView<cr>

"abbreviations
iabbrev <buffer> equation NOPENOPENOPE
iabbrev <buffer> align NOPENOPENOPE
