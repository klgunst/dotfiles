set expandtab
set shiftwidth=8
set softtabstop=8
set foldmethod=syntax
set foldnestmax=3
set cindent

:inoremap ( ()<Esc>:let leavechar=")"<CR>i
:inoremap [ []<Esc>:let leavechar="]"<CR>i
:imap <C-j> <Esc>:exec "normal f" . leavechar<CR>a

:vnoremap _( <Esc>`>a)<Esc>`<i(<Esc>

inoremap { {<CR><BS>}<Esc>ko

"indent options
set cinoptions=:0,l1,t0,g0,(0
