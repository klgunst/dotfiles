# Own defined aliases

alias vi="vim "
alias rm="rm -v "
alias gpg="gpg2"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias paper="otex $HOME/Documents/papers/T3NS_SU2"
alias ssh=~/.config/scripts/startssh.sh
alias po="papis open "
alias pbo="papis -l books open "
alias purvena="~/.config/scripts/startssh.sh purvena"
alias hpc="~/.config/scripts/startssh.sh hpc"
alias calana="~/.config/scripts/startssh.sh calana"

# search configs
se() { vim $(du -a ~/.vim/ftplugin/* ~/.vimrc ~/.config/* | awk '{print $2}' | fzf) ;}
# search code
sec() { cd "$HOME/Codes/$(ls ~/Codes | fzf)" ;}
