#!/bin/zsh

bindkey -v

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst
add-zsh-hook precmd vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{yellow}*%f'
zstyle ':vcs_info:*' stagedstr '%F{green}+%f'
zstyle ':vcs_info:git:*' formats       ' %F{cyan}[%b]%f%c%u'
zstyle ':vcs_info:git:*' actionformats ' %F{cyan}[%b]%F{magenta}%a%f%c%u'
zstyle ':vcs_info:git:*+set-message:*' hooks git-untracked

+vi-git-untracked(){
	if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
		git status --porcelain | grep '??' &> /dev/null ; then
		hook_com[staged]+='%F{red}?%f'
	fi
}

RPROMPT=\$vcs_info_msg_0_
PROMPT='%F{green}(%n)%f %F{blue}%~%f %# '

export EDITOR=vim

export HISTFILE=~/.histfile
export HISTSIZE=100000
export SAVEHIST=100000

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY_TIME
setopt EXTENDED_HISTORY

alias ls='ls --color'
