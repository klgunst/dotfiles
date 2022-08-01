# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/kgunst/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export PROMPT='${ret_status} %m %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export VSC_SCRATCH=/user/home/gent/vsc412/vsc41288/scratch
export VSC_DATA_VO_USER=/user/data/gent/gvo000/gvo00003/vsc41288
export VSC_SCRATCH_VO_USER=/user/scratch/gent/gvo000/gvo00003/vsc41288
export OMP_NUM_THREADS=4
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '
export PATH=$PATH:/usr/local/bagel/bin:$HOME/qsimulate/software/devel/genesis-scripts/bin:$HOME/.local/bin

# change history size 
export HISTSIZE=1000000
export SAVEHIST=1000000

TIMEFMT='%J   %U  user %S system %P cpu %*E total'$'\n'\
'avg shared (code):         %X KB'$'\n'\
'avg unshared (data/stack): %D KB'$'\n'\
'total (sum):               %K KB'$'\n'\
'max memory:                %M MB'$'\n'\
'Major page faults:         %F'$'\n'\
'Minor page faults:         %R'

# vi mode
bindkey -v
bindkey '^p' up-line-or-beginning-search
bindkey '^n' down-line-or-beginning-search

# zshell completion
compdef _gnu_generic T3NS

# Aliases moved to .oh-my-zsh/custom/aliases.zsh

# for gpg-agent to ssh-agent
GPG_TTY=$(tty)
export GPG_TTY

# refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye &>/dev/null

# MKL
# source /opt/intel/oneapi/setvars.sh
export MANPATH=$MANPATH:/usr/share/man:/usr/local/share/man:$HOME/.local/share/man

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/kgunst/Codes/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/kgunst/Codes/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/kgunst/Codes/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/kgunst/Codes/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

autoload -U +X bashcompinit && bashcompinit
source '/home/kgunst/.local/lib/azure-cli/az.completion'
