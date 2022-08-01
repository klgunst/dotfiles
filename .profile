export PATH="$PATH:/usr/local/bagel/bin:$HOME/qsimulate/software/devel/genesis-scripts/bin:$HOME/.local/bin"
export GOPATH="$HOME/.local/go"
export NO_AT_BRIDGE=1  # suppresses evince warnings
export BROWSER='firefox'
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

# For google translate
export GOOGLE_TRANSLATE_LANG=nl
export GOOGLE_TRANSLATE_SECOND_LANG=en

eval $(gpg-agent --daemon --enable-ssh-support)
# API_KEY for google translate and other things
[ -f ~/.secrets ] && . ~/.secrets
