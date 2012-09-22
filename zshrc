
# history
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=100000
setopt share_history

# settings
# setopt correct_all
setopt autocd
setopt hist_ignore_dups

export EDITOR='mvim -v'

# paths
export PATH=/usr/local/bin:$HOME/dotfiles/bin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH
typeset -U path # fix any path dupes

# keybindings (emac-style)
# bindkey -e

# colors
export CLICOLOR=1

autoload colors && colors
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

for COLOR in RED GREEN YELLOW WHITE BLACK CYAN; do
  eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
  eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done
PR_RESET="%{${reset_color}%}";

# aliases
if ls -F --color=auto >&/dev/null; then
  alias ls="ls --color=auto -F"
else
  alias ls="ls -F"
fi

alias cd..='cd ..'
alias fu='sudo $( fc -ln -1)'
alias grep='grep --color=auto'
alias soywiki='SOYWIKI_VIM=mvim soywiki'
alias diff='diff -u'
alias be='bundle exec'
alias vim='mvim -v'
alias cdf='cd `posd`'


# tab completion
autoload -U compinit && compinit

# prompt
setopt prompt_subst
# autoload -U promptinit && promptinit

. ~/dotfiles/bin/z.sh

# set window title
function precmd {
  print -Pn "\e]0;%n@%m: %~\a"
  vcs_info 'prompt'
  lprompt

  _z --add "$(pwd -P)"
}

# git repositories
autoload -Uz vcs_info && vcs_info

# %b - branchname
# %u - unstagedstr (see below)
# %c - stangedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository
FMT_BRANCH="${PR_GREEN}%b%u${PR_RESET}"
FMT_ACTION="(${PR_CYAN}%a${PR_RESET})"
FMT_PATH="%R${RP_YELLOW}/%S"

zstyle ':vcs_info:*:prompt:*' check-for-changes true
zstyle ':vcs_info:*:prompt:*' unstagedstr '1'
zstyle ':vcs_info:*:prompt:*' stagedstr '2'
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}" "${FMT_PATH}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"              "${FMT_PATH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""                             "%~"

function prompt_char {
  git branch >/dev/null 2>/dev/null && echo 'ʭ' && return
  echo '$'
}

function lprompt {
  local current_path=${(%):-%~}

  PROMPT="
${PR_CYAN}${current_path//\//${PR_WHITE}/${PR_RESET}${PR_CYAN}}${PR_RESET} $vcs_info_msg_0_$(prompt_char) "
  #RPROMPT="[${PR_YELLOW}%n@%m${PR_RESET}]"
}

lprompt

unsetopt extended_glob

# rvm / vim+rvm
SHELL=/bin/zsh
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"




