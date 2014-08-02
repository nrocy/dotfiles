
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

# coloured manpages: https://github.com/RobSis/dotfiles/blob/master/.shrc
export PAGER=less
man() {
	env LESS_TERMCAP_mb=$'\E[01;31m' \
		LESS_TERMCAP_md=$'\E[01;38;5;74m' \
		LESS_TERMCAP_me=$'\E[0m' \
		LESS_TERMCAP_se=$'\E[0m' \
		LESS_TERMCAP_so=$'\E[38;5;246m' \
		LESS_TERMCAP_ue=$'\E[0m' \
		LESS_TERMCAP_us=$'\E[04;38;5;146m' \
		man "$@"
}

export PATH=/usr/local/bin:$HOME/bin:$PATH:/usr/local/share/npm/bin:$HOME/src/adt/sdk/platform-tools:$HOME/src/adt/sdk/tools

GREP_OPTIONS="--color=auto"
LESS=-Ri

# http://dancingpenguinsoflight.com/2008/11/bash-history-tips-and-tricks/
HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '
HISTSIZE=100000
HISTFILESIZE=100000
HISTCONTROL=ignoreboth:erasedups

shopt -s histappend
shopt -s cmdhist
shopt -s cdspell

# disable stop/start terminal control
stty -ixon -ixoff

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\n\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[1;35m\] $(__git_ps1 "(%s) ")\[\033[01;33m\]$([ \j -gt 0 ] && echo [\j]\ )\[\033[00m\]\$ '
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/#$HOME/~}\007"'

export GIT_DIFF_OPTS=-bw

alias cd..='cd ..'
alias diff='diff -u'
alias be='bundle exec'

alias cpip="curl -s http://checkip.dyndns.org | tr -cd '[[:digit:].]' | pbcopy"
alias socks="ssh -C2qTnNc blowfish -D 8080"

if [ `uname` == "Darwin" ]; then
	export CLICOLOR=1
	EDITOR='mvim -v'

	alias vim='$EDITOR -v'
	if [ -x /usr/local/bin/gls ]; then
		alias ls='gls -lF --color'
	fi

	if [ -x /usr/local/bin/hub ]; then
		alias git=hub
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

if [ -f ~/dotfiles/local_alias ]; then
	. ~/dotfiles/local_alias
fi

