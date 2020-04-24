# Own defined aliases

alias vi="vim "
alias rm="rm -v "
alias gpg="gpg2"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias paper="otex $HOME/Documents/papers/T3NS_SU2"
alias ssh=startssh
alias po="papis open "
alias pbo="papis -l books open "
alias startvpn="pass work/UGent | xargs -n1 sudo vpnstart.exp"
alias purvena='if [ "x$(pgrep vpnc)" = "x" ]; then startvpn; fi; startssh purvena'
alias calana='if [ "x$(pgrep vpnc)" = "x" ]; then startvpn; fi; startssh calana'
alias hpc="startssh hpc"
alias pauling="startssh pauling"
alias graham="startssh graham"
alias padoi="papis add --from doi"
alias python=python3
alias clebsch="feh -Z $HOME/Pictures/clebsch_gordan.jpg"
alias xapers="conda_xapers"

# search configs of my dotfile git repo
se() { 
    file=$(git --git-dir=$HOME/.cfg/ --work-tree=$HOME ls-files --full-name ~ | fzf)
    if [ ! -z "$file" ]; then
	vim $HOME/$file
    fi
}

# search code
sec() { 
    dir=$(ls ~/Codes | fzf)
    if [ ! -z "$dir" ]; then
	cd $HOME/Codes/$dir
    fi
}

follow() { watch "grep -E 'ENERGY|TRUNCATION|Total|DIM' $1 | tail -n8; echo ''; tail -n10 $1" }
o() {
    vimopen=
    for i in $@; do
	if [ "$(xdg-mime query filetype $i)" = "text/plain" ]; then
	    if [ ! -z $vimopen ]; then
		vimopen="$vimopen\n$i"
	    else
		vimopen="$i"
	    fi
	else
	    xdg-open $i &> /dev/null&!
	fi
    done
    if [ ! -z $vimopen ]; then
	echo -e "$vimopen" | parallel -Xj1 --tty vim
    fi
    }
replot() { python3 plot.py $*; }
plot() { replot $* ; ls -t *.pdf | head -n1; o "$(ls -t *.pdf | head -n1)" ; }
gmol() { gmolden $1 &> /dev/null&! ; }
