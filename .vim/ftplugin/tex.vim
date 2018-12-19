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

"autocomment
noremap <buffer> <localleader>c ^I%<esc>
"should not be for operatormode
ounmap <buffer> <localleader>c

" Macros
nnoremap <buffer> <localleader>eq o\begin{equation}<cr>\end{equation}<esc>O
nnoremap <buffer> <localleader>al o\begin{align}<cr>\end{align}<esc>O
nnoremap <buffer> <localleader>fig o\begin{figure}[!ht]<cr>\centering<cr>\includegraphics{}<cr>\caption{}<cr>\end{figure}<esc>?includegra<cr>f{a
nnoremap <buffer> <localleader>pc :Papis<cr>
nnoremap <buffer> <localleader>pV :PapisView<cr>
nnoremap <buffer> <localleader>pv :PapisInfo<cr>

" References
nnoremap <buffer> <localleader>rf ifig.~\ref{fig:}<Esc>:let leavechar="}"<CR>i
nnoremap <buffer> <localleader>rq ieq.~\ref{eq:}<Esc>:let leavechar="}"<CR>i
nnoremap <buffer> <localleader>rt itable~\ref{tab:}<Esc>:let leavechar="}"<CR>i
nnoremap <buffer> <localleader>rs isection~\ref{sec:}<Esc>:let leavechar="}"<CR>i
inoremap <buffer> <C-j> <Esc>:exec "normal f" . leavechar<CR>a

"abbreviations
iabbrev <buffer> coordinaten coördinaten
iabbrev <buffer> coordinaat coördinaat
iabbrev <buffer> potentiele potentiële
iabbrev <buffer> \ref{ NONONONO
