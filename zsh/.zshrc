# pnpm
export PNPM_HOME="/Users/willie/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/willie/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# Init zoxide
eval "$(zoxide init zsh)"

# Go
export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

# aliases
alias vim="nvim"
alias vi="nvim"
alias gs="git status"
alias gb="git branch"
alias ta="tmux attach || tmux"
alias ls="ls -G"
alias ll="ls -l"

# python alias
pc() {
  python3 -c "print($*)"
}
