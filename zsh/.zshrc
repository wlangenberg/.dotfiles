# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/willie/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# Init zoxide
eval "$(zoxide init zsh)"

# Settings
set -o vi

# bindkey
bindkey -M viins '^E' _expand_alias

## Exports ##

# opencode
export PATH=/Users/willie/.opencode/bin:$PATH

# Go
export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"


# For alert scripts
export REMINDER_SOUND=on

# Remove docker ci hints
export DOCKER_CLI_HINTS=false

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/Users/willie/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

## Aliases ##
alias vim="nvim"
alias vi="nvim"

alias gs="git status"
alias gb="git branch|grep '*'|tr -d '*'|tr -d '[:space:]'"
alias gbl="git branch --sort=-committerdate"
alias gd="git diff"
alias gp="git pull"
alias gl="git log"
alias gc="git checkout"
alias ga="git add"
alias gr="git restore"

alias dc="docker compose"
alias ta="tmux attach || tmux"
alias ls="ls --color"
alias ll="ls -l"
alias fkill='ps -e -o pid,comm | fzf --preview "echo {}" | awk "{print \$1}" | xargs kill -9'
alias nuke_docker='docker stop $(docker ps -a -q);docker rm $(docker ps -a -q)'
alias sourcevenv='source ./.venv/bin/activate'

# Python func
pc() {
  python3 -c "from math import *; print($*)"
}

. "$HOME/.local/bin/env"

# load .zsh_secrets if exists
if [ -f "$HOME/.zsh_secrets" ]; then
  source "$HOME/.zsh_secrets"
fi

# load .zsh_custom if exists
if [ -f "$HOME/.zsh_custom" ]; then
  source "$HOME/.zsh_custom"
fi
