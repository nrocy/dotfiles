# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f /etc/bash_completion.d/git ]; then
	. /etc/bash_completion.d/git
fi

# User specific aliases and functions
function bg_jobs {
	echo "$(jobs | wc -l | sed -e 's/^0$//' -e 's/^[0-9]\+$/[&] /')"
}

export PATH=$PATH:$HOME/bin

export TERM="xterm-color"
export GREP_OPTIONS="--color"

export HISTCONTROL=erasedups
shopt -s histappend

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\n\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[1;35m\] $(__git_ps1 "(%s) ")\[\033[01;33m\]$(bg_jobs)\[\033[00m\]\$ '
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/#$HOME/~}\007"'

export LS_COLORS="di=00;36"

export EDITOR=vim

export GIT_DIFF_OPTS=-b

alias be='bundle exec'
alias ls='ls -l --color'

