#
# git completion
#

# brew info zsh-completion
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

#
# disable HUSKY git hooks by default - https://bobbyhadz.com/blog/git-commit-skip-hooks
#
export HUSKY=0


#
# kubectl completion - https://kubernetes.io/docs/tasks/tools/included/optional-kubectl-configs-zsh/
#
type kubectl &> /dev/null && source <(kubectl completion zsh)


# $HOME/bin
export PATH="${HOME}/bin:${PATH}"


# env vars that should NOT be committed (e.g., aliases & exports that are work specific)
[ -f "$HOME/.nocommit_profile" ] && . "$HOME/.nocommit_profile"


# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"


alias ll='ls -al'

alias ack='ack --ignore-dir coverage --ignore-dir log --ignore-dir tmp --ignore-dir vendor'
alias ackp="ack --pager='less -R'"
alias curl_json='curl --header '\''Content-Type: application/json'\'' --request POST'
alias decode64='ruby -rbase64 -e '\''print Base64.decode64(File.open(ARGV[0]){|f| f.read})'\'''
alias dss='diff --side-by-side'
alias encode64='ruby -rbase64 -e '\''print Base64.encode64(File.open(ARGV[0]){|f| f.read})'\'''
alias gshort='git rev-parse --short=7 HEAD'
alias gshort_master='git rev-parse --short=7 master'
# alias k9s='k9s --readonly -r 1'
alias k9s='k9s -r 1'
alias mac2unix='perl -pe '\''s/\r/\n/mg'\'''
alias paths='echo $PATH | perl -pe "s/:/\n/g"'
alias pretty_json='ruby -r json -e '\''txt = ARGF.read; h = JSON.parse(txt); puts JSON.pretty_generate(h)'\'''
alias psgrep='ps aux | grep -v grep | grep '
alias python2_simple_http_server='python -m SimpleHTTPServer'
alias python_http_server='python3 -m http.server'
alias rspecc='rspec --profile 0 --format documentation'
alias rube='echo DEPENDENCIES_NEXT=$DEPENDENCIES_NEXT RUBYOPT=$RUBYOPT'
alias tabify='ruby -pe '\''gsub(/ +/, "\t")'\'''

# docker aliases because I'm tired of all the typing
alias dcl='docker container list'
alias dcla='docker container list --all'
alias dil='docker image list'
alias dila='docker image list --all'

# --rm auto remove container upon exit
alias drrm='docker run --rm'

# git aliases for submodules
alias gal='git config --get-regexp alias\. | egrep --color '\''\.\w+\s+'\'
alias gcl='git clone --recurse-submodules'
alias gco='git checkout --recurse-submodules'
alias gfe='git fetch --recurse-submodules'
alias gpu='git pull --recurse-submodules'
alias gst='git status'
alias gsu='git submodule update --init --recursive'

# exec bash as root interactively for a docker container
dexecbash ()
{
    DOCKER_TAINER=$1
    shift
    docker exec -u root -it $DOCKER_TAINER bash
}


# Mac OS X specific
alias aquamacs='open -a /Applications/Aquamacs.app'
alias marked='open -a /Applications/Marked\ 2.app'
alias open_ports='lsof -i | grep LISTEN'
alias sourcetree='open -a /Applications/SourceTree.app'


#
# Bash bahavior
#

# Bash-like navigation - https://stackoverflow.com/a/10860628
autoload -U select-word-style
select-word-style bash

# Ctrl-U kills to start-of-line - https://unix.stackexchange.com/a/513198
bindkey "^U" backward-kill-line

# time in bash format - https://superuser.com/a/71890
TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'


# change "pause screen" to Ctrl-X so that Ctrl-S is forward search
stty stop ^X


# nice zsh feature - remove duplicate paths
typeset -U path


#
# pyenv for Python environments
#

# output of `pyenv env`
if type brew && test -n "$(brew list pyenv)"; then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi


#
# Using spaceship to get rvm prompt in zsh
# - https://computingforgeeks.com/best-terminal-shell-prompts-for-zsh-bash-fish/
# - switch font to 'DejaVu Sans Mono; Book 13 seems best for iTerm2
#

fpath=($fpath "$HOME/.zfunctions")

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship


#
# Ruby & Rails stuff
#

# fast book dual boot gem - "bootboot"
export DEPENDENCIES_NEXT=1
# Ruby 3.0
export RUBYOPT='-W:deprecated'
# remind me the latest dev env vars
echo DEPENDENCIES_NEXT=$DEPENDENCIES_NEXT RUBYOPT=$RUBYOPT
