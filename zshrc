
# history
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=1000
setopt share_history

# settings
setopt correct_all
setopt autocd
setopt hist_ignore_dups

export EDITOR=vim

# paths
export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/bin:$PATH:/Applications/MAMP/bin/php5/bin
export MANPATH=/opt/local/share/man:$MANPATH
typeset -U path # fix any path dupes

# keybindings (emac-style)
bindkey -e

# colors
autoload colors && colors
LS_COLORS='no=00:fi=00:di=00;36:ln=00;37;44:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:';
export LS_COLORS

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

# tab completion
autoload -U compinit && compinit

# prompt
setopt prompt_subst
# autoload -U promptinit && promptinit

# set window title
function precmd {
  print -Pn "\e]0;%n@%m: %~\a"
  vcs_info 'prompt'
  lprompt
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
  RPROMPT="[${PR_YELLOW}%n@%m${PR_RESET}]"
}

lprompt

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"



