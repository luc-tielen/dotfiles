#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=gvim
export BROWSER=chromium

# Prompt:
PS1='[\u@\h \W]\$ '

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

alias I='sudo pacman -S'
alias UU='sudo pacman -Syu'
alias U='sudo pacman -Syu --ignore linux'
alias Q='pacman -Si'
alias R='sudo pacman -Rns'
alias S='pacman -Ss'
alias Y='yaourt -S'
alias L='yaourt -Ss'
alias shutdown='sudo shutdown -h 0'
alias yt='youtube-viewer'
alias tv='sudo systemctl start teamviewerd && /opt/teamviewer8/tv_bin/TeamViewer'

# Better ls colors in terminal
export CLICOLOR=TRUE
export LSCOLORS=Gxfxbxdxcxegedabagacad

# Zsh options:

# Tab completion + load theme
autoload -U compinit promptinit
compinit
promptinit
prompt redhat

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

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
