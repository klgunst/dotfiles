set tabstop=8
set expandtab
set shiftwidth=2
set softtabstop=2
set foldmethod=syntax
"set foldnestmax=2

:inoremap ( ()<Esc>:let leavechar=")"<CR>i
:inoremap [ []<Esc>:let leavechar="]"<CR>i
":inoremap " ""<Esc>:let leavechar="""<CR>i
"#:inoremap ' ''<Esc>:let leavechar="'"<CR>i
:imap <C-j> <Esc>:exec "normal f" . leavechar<CR>a

:vnoremap _( <Esc>`>a)<Esc>`<i(<Esc>

inoremap { {<CR><BS>}<Esc>ko
