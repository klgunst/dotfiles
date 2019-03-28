# Own defined aliases

alias vi="vim "
alias rm="rm -v "
alias gpg="gpg2"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias paper="otex $HOME/Documents/papers/T3NS_SU2"
alias ssh=~/.config/scripts/startssh.sh
alias po="papis open "
alias pbo="papis -l books open "
alias startvpn="pass work/UGent | xargs -n1 sudo vpnstart.exp"
alias purvena='if [ "x$(pgrep vpnc)" = "x" ]; then startvpn; fi; ~/.config/scripts/startssh.sh purvena'
alias calana='if [ "x$(pgrep vpnc)" = "x" ]; then startvpn; fi; ~/.config/scripts/startssh.sh calana'
alias hpc="~/.config/scripts/startssh.sh hpc"

# search configs
se() { vim $(du -a ~/.vim/ftplugin/* ~/.vimrc ~/.config/* | awk '{print $2}' | fzf) ;}
# search code
sec() { cd "$HOME/Codes/$(ls ~/Codes | fzf)" ;}
follow() { watch "egrep 'ENERGY|TRUNCATION|TIME|DIM' $1 | tail -n8; echo ''; tail -n10 $1" }
