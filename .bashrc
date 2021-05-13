# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\] \[\e[m\]\[\e[31m\]:\[\e[m\]\[\e[31m\]:\[\e[m\] \[\033[01;34m\]\w\[\033[00m\]\033[01;35m\]$(__git_ps1)\[\e[m\] \[\e[01;31m\]»\[\e[m\] '
unset color_prompt force_color_prompt

export EDITOR='vim'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias jn='jupyter notebook' 

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/crow/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/crow/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/crow/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/crow/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS='
    --color=hl:#dc322f,hl+:#dc322f'
# git diff, bit with color
batdiff() {
    git diff --name-only --diff-filter=d | xargs bat --diff
}
export -f batdiff
