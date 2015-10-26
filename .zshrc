## GENERAL
export ZSH=/Users/jmc/.oh-my-zsh
ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git brew colorize sudo)

## PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin:/opt/local/bin:/usr/local/texlive/2014/bin/x86_64-darwin:/usr/sbin"
# export MANPATH="/usr/local/man:$MANPATH"
source $ZSH/oh-my-zsh.sh

## ALIASES
alias vi=vim
alias dc="cd ~/Documents/"
alias dv="cd ~/Dev/"
alias l='ls -l'
alias bci="brew cask install"
alias ack=ag
alias spa='spotify play album'

## FUNCTIONS
function chpwd() {
	emulate -L zsh
	ls -l
}
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

eval `/usr/libexec/path_helper -s`
