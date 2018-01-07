#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=emacs
export GIT_EDITOR=vim
export BROWSER=chromium
export PATH="/home/luc/.local/bin/:${PATH}"
     
# Prompt:
function git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

function parse_git_branch() {
    (command git symbolic-ref -q HEAD || command git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null
}

function parse_git_dirty() {
    if command git diff-index --quiet HEAD 2>/dev/null; then
        echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
    else
        echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
    fi
}

setopt prompt_subst
ZSH_THEME_GIT_PROMPT_CLEAN="%{%F{green}%}✔ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{%F{red}%}✗ %{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔ %{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}✗ %{$reset_color%}"
PROMPT='%{%F{white}%}[ %{%F{blue}%}%n@%m %{%F{white}%}%~%{%F{red}%} $(git_prompt_info) $(parse_git_dirty)%{%F{white}%}] %{%F{reset}%}$ '

#PS1='[\u@\h \W]\$ '

# Aliases:
alias ls='ls --color=auto --human-readable --group-directories-first'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias ln='ln -v'
alias chmod='chmod -c'
alias chown='chown -c'
alias grep='egrep --colour=auto'
alias su='su -'
alias I='nix-env --install'
alias R='nix-env --uninstall'
alias U='sudo nixos-rebuild test'
alias UU='sudo nixos-rebuild switch'
alias S='nix-env -qaP | grep'
alias tree='tree -C'
alias shutdown='sudo shutdown -h 0'
alias yt='youtube-viewer'
alias xssh='ssh -YC -c blowfish-cbc,arcfour'


# Better ls colors in terminal
export CLICOLOR=TRUE
export LSCOLORS=Gxfxbxdxcxegedabagacad

# Zsh options:

# Tab completion + load theme
autoload -U compinit promptinit colors
compinit
promptinit

# Alias autocompletion
setopt completealiases
# Extended globbing (completion)
setopt extendedglob
# Parameter/arithmetic expansion + command substitution
setopt promptsubst
# No flowcontrol
setopt noflowcontrol
# Ignore lines starting with #
setopt interactivecomments

# Case-insensitive (uppercase from lowercase) completion
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# History:
HISTFILE=~/.zsh_history
HISTSIZE=3000
SAVEHIST=3000

# History options:
setopt incappendhistory	\
extendedhistory	 \
histfindnodups	 \
histreduceblanks	\
histignorealldups	\
histsavenodups

# Add extra specific keys:
typeset -A key
key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# Key bindings:
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history
bindkey '^Y' yank
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Check if terminal is in application mode:
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# NOTE: requires https://github.com/zsh-users/zsh-syntax-highlighting
source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
