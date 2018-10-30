setlocal expandtab
setlocal shiftwidth=8
setlocal softtabstop=8
setlocal foldmethod=syntax
setlocal foldnestmax=3
setlocal cindent
setlocal nowrap
setlocal path+=../include

"inoremap <buffer> ( ()<Esc>:let leavechar=")"<CR>i
"inoremap <buffer> [ []<Esc>:let leavechar="]"<CR>i
"imap <buffer> <C-j> <Esc>:exec "normal f" . leavechar<CR>a
"
":vnoremap <buffer> _( <Esc>`>a)<Esc>`<i(<Esc>
"
"inoremap <buffer> { {<CR><BS>}<Esc>ko

"autocomment
noremap <buffer> <localleader>c ^I//<esc>
"should not be for operatormode
ounmap <buffer> <localleader>c

"indent options
setlocal cinoptions=:0,l1,t0,g0,(0

"MACROS
inoremap <buffer> <localleader>if if () {<cr>}<esc>kf(a
inoremap <buffer> <localleader>for for () {<cr>}<esc>kf(a
inoremap <buffer> <localleader>while while () {<cr>}<esc>kf(a
inoremap <buffer> <localleader>pro printf();<esc>hi
inoremap <buffer> <localleader>pre fprintf(stderr, );<esc>hi

nnoremap <buffer> <localleader>if oif () {<cr>}<esc>kf(a
nnoremap <buffer> <localleader>for ofor () {<cr>}<esc>kf(a
nnoremap <buffer> <localleader>while owhile () {<cr>}<esc>kf(a
nnoremap <buffer> <localleader>pro oprintf();<esc>hi
nnoremap <buffer> <localleader>pre ofprintf(stderr, );<esc>hi

nnoremap <buffer> <localleader>oi :e %:p:h:h/include/%:t:r.h<cr>

"Abbreviations
iabbrev <buffer> if NOPENOPENOPE
iabbrev <buffer> forr NOPENOPENOPE
iabbrev <buffer> whill NOPENOPENPOE
iabbrev <buffer> printf NOPENOPENPOE
iabbrev <buffer> efal exit(EXIT_FAILURE);
iabbrev <buffer> EXIT_FAILURE NOPNOPENOPE
