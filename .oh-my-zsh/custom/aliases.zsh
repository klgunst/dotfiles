# Own defined aliases

alias vi="vim "
# alias rm="rm -v "
alias rm="echo Use 'del', or the full path i.e. '/bin/rm'"
alias mv="mv --backup=numbered"
alias gpg="gpg2"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias ssh=startssh
alias xapers="conda_xapers"
alias qxap="XAPERS_ROOT=$HOME/.xapers/qsimulate xapers"
alias azlogin='az login -u gunst@shiozakiqsimulate.onmicrosoft.com -p $(pass qsimulate/azure)'
alias ssh-hosts="grep -P \"^Host ([^*]+)$\" $HOME/.ssh/config | sed 's/Host //'"
alias ssh-select='ssh $(ssh-hosts | fzf)'
alias ddir='cd $(find ~/devel/ -type d | fzf)'
alias dedit='vim $(find ~/devel/ -type f | fzf)'
azip () {
    # Store azure ip in environment
    if [ x"$AZURE_IP" = x"" ]; then
	export AZURE_IP=$(az vm show -d -g gunst_gunst-dev_01 -n gunst_gunst-dev_01_vm -o table | tail -n1 | awk '{print $(NF-1)}')
    fi
    echo $AZURE_IP
}

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

get_bibtex() {
     xapers source2bib doi:$1 | sed 's~\\%2F~/~g' | tee bibtex
}

qxadd() {
     XAPERS_ROOT=$HOME/.xapers/qsimulate xapers add --source=bibtex --file=$1
     trash bibtex $1
}

pmol() {
    conda activate pymol
    pymol $@
    conda deactivate
}
