# --------------------------------------------------------------------------
# shellcheck shell=bash
# vim: set syntax=sh ft=sh sw=2 ts=2 expandtab:
# --------------------------------------------------------------------------
set -o emacs -o monitor -o notify
shopt -qs checkwinsize cmdhist expand_aliases histappend hostcomplete histverify interactive_comments nocaseglob nocasematch no_empty_cmd_completion progcomp promptvars sourcepath
shopt -qu mailwarn
[[ "${BASH_VERSINFO[0]}" -gt "3" ]] && shopt -qs autocd checkjobs
# --------------------------------------------------------------------------
export HISTFILE=$HOME/.bash_history
export HISTCONTROL=ignorespace
export HISTFILESIZE=999999999
export INPUTRC=$HOME/.bash_inputrc
export BROWSER=open
export PAGER=less
export EDITOR=vim
export VISUAL=vim
export LESS=iRQXF
export HISTSIZE=999999999
export HISTFILESIZE=999999999
export MAILCHECK=0
export SHELLCHECK_OPTS="--shell=bash --exclude=SC2001,SC1090,SC2164,SC2068,SC2155"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export FZF_DEFAULT_OPTS='--info=inline --ansi --tabstop=2 --multi --preview-window=right'
export DOCKER_SCAN_SUGGEST=false
export PS1='\t \u@\h \w \$ '
export BASE16_THEME=twilight
export BASE16_DEFAULT_THEME=base16-${BASE16_THEME}
# --------------------------------------------------------------------------
for s in "$HOME/.shell-path" "$HOME/.shell-common"; do
  [[ -s "$s" ]] && source "$s"
done
# --------------------------------------------------------------------------
command -v mise >&/dev/null && eval "$(mise activate bash)"
# --------------------------------------------------------------------------
[[ -z "$PS1" ]] && return
# --------------------------------------------------------------------------
command -v op >&/dev/null && source <(op completion bash)
command -v direnv >&/dev/null && eval "$(direnv hook bash)"
# --------------------------------------------------------------------------
for s in "$HOME/.fzf.bash" "$HOME/bin/git-prompt.sh"; do
  [[ -s "$s" ]] && source "$s"
done

alias base16_twilight="source \"\$HOME/.config/base16-shell/scripts/base16-twilight.sh\""
# --------------------------------------------------------------------------
_completion_loader() {
  local _command="$1"
  local _completion
  local _completion_script

  for _completion_dir in /etc/bash_completion.d /usr/local/etc/bash_completion.d /opt/homebrew/etc/bash_completion.d; do
    _completion="${_completion_dir}/${_command}"

    for _completion_script in "${_completion}" "${_completion}.sh"; do
      if [[ -s "${_completion_script}" ]]; then
        source "${_completion_script}" >&/dev/null && return 124
      fi
    done
  done
}

if [[ "${BASH_VERSINFO[0]}" -gt 3 ]]; then
  for s in /etc/bash_completion /opt/homebrew/etc/bash_completion; do
    [[ -s "$s" ]] && source "$s"
  done
  # complete -D -F _completion_loader -o bashdefault -o default
fi
# Colors---------------------------------------------------------------------
if command -v tput >&/dev/null && [[ -n "$TERM" && "$TERM" != "dumb" && "$TERM" != "tty" ]]; then
  # if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hh -- \C-j"'; fi

  color() {
    tput setaf "$1"
    :
  }

  _ps1_time_color() {
    local e=$?
    color $((e == 0 ? 4 : 1))
  }

  _ps1_id_color() {
    color $((UID == 0 ? 9 : 7))
  }

  _ps1_id() {
    if command -v am_i_someone_else >&/dev/null && am_i_someone_else; then
      echo -n "__${USER}__"
    else
      echo -n "$USER"
    fi
  }

  _ps1_git_prep() {
    command -v git >&/dev/null || return 0
    export __LOCAL_GIT_STATUS=$(git status -unormal 2>&1)
  }

  _ps1_git_color() {
    if ! [[ "$__LOCAL_GIT_STATUS" =~ Not\ a\ git\ repo ]]; then
      if [[ "$__LOCAL_GIT_STATUS" =~ nothing\ to\ commit ]]; then
        color 10
      elif [[ "$__LOCAL_GIT_STATUS" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
        color 11
      else
        color 9
      fi
    fi
  }

  _ps1_git() {
    if [[ "$__LOCAL_GIT_STATUS" =~ On\ branch\ ([^[:space:]]+) ]]; then
      branch=${BASH_REMATCH[1]}
      test "$branch" != master || branch=' '
    else
      branch="($(git describe --all --contains --abbrev=4 HEAD 2> /dev/null || echo HEAD))"
    fi
    printf "%s" "$(__git_ps1 "")"
  }

  if ! command -v git >&/dev/null || ! command -v __git_ps1 >&/dev/null; then
    _ps1_git_color() { :; }
    _ps1_git() { :; }
  fi
  #-----------------------------------------------------------------------------
  declare __reset=$(tput sgr0)
  _ps1_update() {
    export PS1='\[$__reset\]\[$(_ps1_time_color)\]\t\[$__reset\] \[$(_ps1_id_color)\]$(_ps1_id)\[$__reset\]@\[$(_ps1_time_color)\]\h\[$__reset\]\[$(_ps1_git_color)\]$(_ps1_git)\[$__reset\] \w \$ '
  }

  export -a PROMPT_COMMAND=("_ps1_git_prep" "_ps1_update")
fi
