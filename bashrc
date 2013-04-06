
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f /etc/bash_completion.d/git ]; then
	. /etc/bash_completion.d/git
fi

if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	. /usr/local/etc/bash_completion.d/git-completion.bash

	if [ -f /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
		. /usr/local/etc/bash_completion.d/git-prompt.sh
	fi
fi

export PATH=/usr/local/bin:$HOME/bin:$PATH

GREP_OPTIONS="--color=auto"

# http://dancingpenguinsoflight.com/2008/11/bash-history-tips-and-tricks/
HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '
HISTSIZE=100000
HISTFILESIZE=100000

shopt -s histappend
shopt -s cmdhist
shopt -s cdspell

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\n\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[1;35m\] $(__git_ps1 "(%s) ")\[\033[01;33m\]$([ \j -gt 0 ] && echo [\j]\ )\[\033[00m\]\$ '
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/#$HOME/~}\007"'

export GIT_DIFF_OPTS=-bw

alias cd..='cd ..'
alias diff='diff -u'
alias be='bundle exec'

if [ `uname` == "Darwin" ]; then
	export CLICOLOR=1
	EDITOR=$(which mvim)

	alias vim='$EDITOR -v'
	if [ -x /usr/local/bin/gls ]; then
		alias ls='gls -lF --color'
	fi
else
	export LS_COLORS="di=00;36"
	EDITOR='vim'

	for PATTERN in .svn .git .hg; do
		GREP_OPTIONS="$GREP_OPTIONS --exclude-dir=$PATTERN"
	done

	alias ls='ls -lF --color'
fi

export EDITOR
export GREP_OPTIONS

. ~/dotfiles/bin/z.sh

