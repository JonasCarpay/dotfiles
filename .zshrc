## GENERAL
export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git brew z sudo stack cabal)
export EDITOR=nvim

## PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin:/opt/local/bin:/usr/sbin"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.stack/programs/x86_64-osx/ghc-8.0.1/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/opt/sbt@0.13/bin:$PATH"

export PATH=/Developer/NVIDIA/CUDA-7.5/bin${PATH:+:${PATH}}
export DYLD_LIBRARY_PATH=/Developer/NVIDIA/CUDA-7.5/lib\
                           ${DYLD_LIBRARY_PATH:+:${DYLD_LIBRARY_PATH}}
source $ZSH/oh-my-zsh.sh

export RUST_SRC_PATH="$HOME/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"

## ALIASES
alias vi=nvim
alias v=nvim
alias dc="cd ~/Documents/"
alias dv="cd ~/Dev/"
alias dw="cd ~/Downloads/"
alias dr="cd ~/Dropbox/"
alias dm="cd ~/Documents/CE/"
alias l='ls -l'
alias bci="brew cask install"
alias ack=ag
alias spa='spotify play album'
alias lmk='latexmk -pvc -interaction=nonstopmode'
alias lmc='latexmk -c'
alias eclim='~/Applications/Eclipse.app/Contents/Eclipse/eclimd'
alias c=cd
alias p=python3
alias rn=ranger
alias sb='stack build'
alias sbe='stack build && stack exec'
alias sc='stack clean'
alias si='stack install'
alias se='stack exec'
alias sr='stack repl'
alias st='stack test'
alias cr='cabal run'
alias cb='cabal build'
alias ci='cabal install'
alias cid='cabal install --only-dependencies -j'
alias cs='cabal sandbox'
alias rd='rm -rf'


## FUNCTIONS
function chpwd() {
	emulate -L zsh
	ls -l
}
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

# Show hostname if not at home
[[ $(hostname -s) != "Jonass-MacBook-Pro" ]] && export PROMPT="$(hostname -s) $PROMPT"

eval `/usr/libexec/path_helper -s`

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -g ""'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#echo ""
#fortune -a
#echo ""
