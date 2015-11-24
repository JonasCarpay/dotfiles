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
alias vim=nvim
alias vi=nvim
alias v=nvim
alias dc="cd ~/Documents/"
alias dv="cd ~/Dev/"
alias dw="cd ~/Downloads/"
alias dr="cd ~/Dropbox/"
alias l='ls -l'
alias bci="brew cask install"
alias ack=ag
alias spa='spotify play album'
alias lmk='latexmk -pvc -interaction=nonstopmode'
alias lmc='latexmk -c'
alias eclim='~/Applications/Eclipse.app/Contents/Eclipse/eclimd'
alias c=cd

## FUNCTIONS
function chpwd() {
	emulate -L zsh
	ls -l
}
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

eval `/usr/libexec/path_helper -s`

screenfetch
