# Own defined aliases

alias vi="vim "
alias rcd='ranger --choosedir=/tmp/rcd; LASTDIR=`cat /tmp/rcd`; cd "$LASTDIR"'
alias rm="rm -v "
alias gpg="gpg2"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias paper="otex $HOME/Documents/papers/T3NS_SU2"
alias ssh="export GPG_TTY=$(tty); gpg-connect-agent updatestartuptty /bye &>/dev/null; ssh"
