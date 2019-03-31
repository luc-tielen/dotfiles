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

function nix_prompt() {
  if [ ! -z "$IN_NIX_SHELL" ]; then
    echo "\e[92mnix-shell\e[0m "
  else
    echo ""
  fi
}

function update_shell_prompt() {
  PROMPT="$(nix_prompt)$(current_path) $(git_prompt_info) $(parse_git_dirty) $ "
  export PS1=$PROMPT
}

function restore_prompt_after_nix_shell() {
  PROMPT_COMMAND=update_shell_prompt
  if [ "$PS1" != "$PROMPT" ]; then
    PS1=$PROMPT
  fi
}


# Aliases

alias vim=nvim


# Startup commands

PROMPT_COMMAND=restore_prompt_after_nix_shell
update_shell_prompt

