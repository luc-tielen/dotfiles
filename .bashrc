# Helper functions

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo $(basename $ref)
}

function parse_git_dirty() {
  if command git diff-index --quiet HEAD 2>/dev/null; then
    echo "\e[32m✔\e[0m"
  else
    echo "\e[31m✗\e[0m"
  fi
}

function current_path() {
  CURRENT_PATH=$(pwd)
  echo $(basename $CURRENT_PATH)
}

# Aliases

alias v=nvim
alias vi=nvim
alias vim=nvim
alias gg="git grep"
alias S="pacman -Ss"
alias I="sudo pacman -S"
alias R="sudo pacman -Rns"

eval "$(direnv hook bash)"

# Startup commands
PS1='$(basename $PWD) λ '
export EDITOR=nvim
export PATH="/home/luc/.local/bin:/home/luc/.ghcup/bin:/home/luc/.cargo/bin/:$PATH:/home/luc/code/llvm-project/build/bin"
[ -f "/home/luc/.ghcup/env" ] && source "/home/luc/.ghcup/env" # ghcup-env


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
