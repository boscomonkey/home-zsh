#-*-shell-script-*-

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
# case-sensitive sort
#
export LC_COLLATE=C


#
# kubectl completion - https://kubernetes.io/docs/tasks/tools/included/optional-kubectl-configs-zsh/
#
type kubectl &> /dev/null && source <(kubectl completion zsh) && export KUBECTL_PATH=/usr/local/bin/kubectl


# $HOME/bin
export PATH="${HOME}/bin:${PATH}"


# env vars that should NOT be committed (e.g., aliases & exports that are work specific)
[ -f "$HOME/.nocommit_profile" ] && . "$HOME/.nocommit_profile"


# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"


alias ll='ls -al'

alias mcp-add-context7='claude mcp add context7 -- npx -y @upstash/context7-mcp'
alias ack='ack --ignore-dir .idea --ignore-dir coverage --ignore-dir log --ignore-dir tmp --ignore-dir vendor'
alias ackp="ack --pager='less -R'"
alias bundate='bundle && rake db:migrate:with_data'
alias cls='printf "\033[2J"'
alias cls_lines='for ii in {1..$(($LINES-5))}; echo'
alias curl_json='curl --header '\''Content-Type: application/json'\'' --request POST'
alias decode64='ruby -rbase64 -e '\''print Base64.decode64(File.open(ARGV[0]){|f| f.read})'\'''
alias dss='diff --side-by-side -W$(stty size | sed -r "s/^.* +//")'
alias encode64='ruby -rbase64 -e '\''print Base64.encode64(File.open(ARGV[0]){|f| f.read})'\'''
alias envkaf='env | egrep '\''(KAFKA_|KUBE_|MSK_)'\'
alias gshort='git rev-parse --short=7 HEAD'
alias gshort_master='git rev-parse --short=7 master'
# alias k9s='k9s --readonly -r 1'
alias k9s='k9s -r 1'
alias k9s-dev='av-dev k9s --namespace apps --context dev'
alias k9s-stage='av-stage k9s --namespace apps --context stage'
alias k9s-prod='av-prod k9s --namespace apps --context prod'
alias mac2unix='perl -pe '\''s/\r/\n/mg'\'''
alias nocomment='egrep -v '\''^#'\'
alias noblank='egrep -v '\''^$'\'
alias paths='echo $PATH | perl -pe "s/:/\n/g"'
alias pretty_json='ruby -r json -e '\''txt = ARGF.read; h = JSON.parse(txt); puts JSON.pretty_generate(h)'\'''
alias psgrep='ps aux | grep -v grep | grep '
alias python2_simple_http_server='python -m SimpleHTTPServer'
alias python_http_server='python3 -m http.server'
alias raw_json='ruby -rjson -e '\''puts JSON.parse(ARGF.read).to_json'\'
alias rc="rubycritic -f json --churn-after $(date -I)"
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

# shorthands for docker compose (brew install docker-compose)
alias dcomp='docker-compose '

# git aliases for submodules
alias gal='git config --get-regexp alias\. | egrep --color '\''\.\w+\s+'\'
alias gcl='git clone --recurse-submodules'
alias gco='git checkout --recurse-submodules'
alias gdm='git diff --merge-base main'
alias gdm-no='git diff --merge-base main --name-only'
alias gdmas='git diff --merge-base master'
alias gdmas-no='git diff --merge-base master --name-only'
alias gfe='git fetch --recurse-submodules'
alias gpu='git pull --recurse-submodules'
alias gst='git status'
alias gsu='git submodule update --init --recursive'
alias gwt='git worktree'

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

# Redefine ^L to clear screen & move cursor to bottom of screen (not really Bash)
function clear_screen_bot() {
    printf "\033[2J"
    zle redisplay
}
zle -N clear_screen_bot
bindkey "^L" clear_screen_bot	# clear underscore screen → cursor at bottom
bindkey "^X^L" clear-screen	# clear dash screen → cursor at top


# change "pause screen" to Ctrl-X so that Ctrl-S is forward search;
# unfortunately, this interferes with ^X^WHATEVER in zsh
###	stty stop ^X


# completely disable ctrl-s/ctrl-q software flow control; so that zsh
# can use ^x^WHATEVER key combos
stty -ixon


# nice zsh feature - remove duplicate paths
typeset -U path


#
# pyenv for Python environments
#

# output of `pyenv env`
if type brew &>/dev/null && test -n "$(brew list pyenv)"; then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi


#
# Using spaceship to get rvm prompt in zsh
# - https://computingforgeeks.com/best-terminal-shell-prompts-for-zsh-bash-fish/
# - switch font to 'DejaVu Sans Mono; Book 13 seems best for iTerm2
#

###	fpath=($fpath "$HOME/.zfunctions")

# Set Spaceship ZSH as a prompt
###	autoload -U promptinit; promptinit
###	prompt spaceship

###	type brew &>/dev/null && test -n "$(brew --prefix spaceship)" && source "$(brew --prefix spaceship)/spaceship.zsh"

#
# testing zsh starship prompt (2024/06/06) - https://starship.rs/
#
type brew &>/dev/null && test -n "brew --prefix starship" && eval "$(starship init zsh)"


#
# fastfetch (system info) & `onefetch --nerd-fonts` for git directory summary
#
###	fastfetch


#
# Ruby & Rails stuff
#

# fast book dual boot gem - "bootboot"
export DEPENDENCIES_NEXT=no_op

# Ruby 3.0
export RUBYOPT='-W:deprecated'

# Fix NSCFConstantString failure during `rspec --bisect` - https://github.com/rails/rails/issues/38560
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES


# remind me the latest dev env vars
#	- installed by garden-modules' `make setup`
echo -e "DEPENDENCIES_NEXT=$DEPENDENCIES_NEXT\nRUBYOPT=$RUBYOPT"

# Temporarily using Homebrew's openjdk 11. Remember to unlink the following when uninstalling:
#   sudo ln -sfn /opt/homebrew/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk
#
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
