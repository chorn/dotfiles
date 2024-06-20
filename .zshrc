# --------------------------------------------------------------------------
# shellcheck shell=bash disable=SC2207,SC1087,SC2128,SC2086,SC2016,SC2154,SC2034,SC1091,SC2139
# vim: set syntax=sh ft=sh sw=2 ts=2 expandtab:
#-----------------------------------------------------------------------------
zmodload zsh/compctl \
  zsh/complete \
  zsh/complist \
  zsh/datetime \
  zsh/main \
  zsh/parameter \
  zsh/terminfo \
  zsh/zle \
  zsh/zleparameter \
  zsh/zutil
#-----------------------------------------------------------------------------
setopt \
  always_to_end \
  auto_cd \
  auto_list \
  auto_menu \
  auto_param_slash \
  brace_ccl \
  case_glob \
  cdable_vars \
  check_jobs \
  clobber \
  combining_chars \
  complete_in_word \
  emacs \
  extended_glob \
  hash_list_all \
  interactive_comments \
  list_ambiguous \
  list_packed \
  list_types \
  long_list_jobs \
  multios \
  path_dirs \
  posix_builtins \
  prompt_subst

unsetopt \
  auto_resume \
  beep \
  bg_nice \
  complete_aliases \
  correct \
  correct_all \
  flow_control \
  hup \
  list_beep \
  mail_warning \
  menu_complete \
  notify

# History
setopt \
  append_history \
  bang_hist \
  extended_history \
  hist_allow_clobber \
  hist_fcntl_lock \
  hist_no_store \
  hist_reduce_blanks \
  inc_append_history

unsetopt \
  hist_find_no_dups \
  hist_expire_dups_first \
  hist_verify \
  hist_ignore_space \
  share_history \
  hist_ignore_all_dups \
  inc_append_history_time
#-----------------------------------------------------------------------------
typeset -gx PS1='%f%b%k%u%s%n@%m %~ %(!.#.$)%f%b%k%u%s '
typeset -gx RPS1=''
typeset -gx BASE16_THEME=twilight
typeset -gx BROWSER=open
typeset -gx DOCKER_SCAN_SUGGEST=false
typeset -gx EDITOR=vim
typeset -gx FZF_DEFAULT_OPTS='--info=inline --ansi --tabstop=2 --multi --preview-window=right'
typeset -gx HISTFILESIZE=99999999
typeset -gx HISTSIZE=99999999
typeset -gz HOMEBREW_NO_ENV_HINTS=1
typeset -gx LESS="iRQXF"
typeset -gx MAILCHECK=0
typeset -gx PAGER=less
typeset -gx RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
typeset -gx SAVEHIST=99999999
typeset -gx SHELLCHECK_OPTS="--shell=bash --exclude=SC2001,SC1090,SC2164,SC2068,SC2155"
typeset -gx VISUAL=vim
typeset -gx WORDCHARS='*?_.~&;!#$%'
typeset -gx ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=128
typeset -gx ZSH_AUTOSUGGEST_USE_ASYNC=1
unset MANPATH
#-----------------------------------------------------------------------------
typeset -U zpath=(
  "$HOME"/{tbin,bin}
  /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin
  /Applications/Docker.app/Contents/Resources/bin
  /Applications/Postgres.app/Contents/Versions/latest/bin
  /usr/local/MacGPG2/bin
  /{usr,opt}/{local,homebrew}/{bin,sbin}
  /home/linuxbrew/.linuxbrew/bin
  /usr/local/opt/openssl/bin
  /{opt,usr,snap}/{bin,sbin,libexec}
  /{bin,sbin}
  $(find /etc/paths /etc/paths.d -type f -exec cat {} \; 2> /dev/null)
)
typeset -T -Ugx PATH path=($(find $zpath[@] -type d -maxdepth 0 2>| /dev/null)) ':'
#-----------------------------------------------------------------------------
for s in "$HOME/.shell-common" "$HOME/.shell-prv"; do
  [[ -s "$s" ]] && source "$s"
done
#-----------------------------------------------------------------------------
## ZI
typeset -Agx ZI
ZI[BIN_DIR]="${HOME}/.zi/bin"
#-----------------------------------------------------------------------------
if ! [[ -s "${ZI[BIN_DIR]}/zi.zsh" ]]; then
  echo git clone https://github.com/z-shell/zi.git "${ZI[BIN_DIR]}"
  return 0
fi
#-----------------------------------------------------------------------------
source "${ZI[BIN_DIR]}/zi.zsh"
autoload -Uz _zi

zi lucid light-mode 'for' \
  z-shell/z-a-meta-plugins \
  z-shell/z-a-bin-gem-node \
  z-shell/z-a-rust \
  @annexes @zsh-users+fast @sharkdp @ext-git @console-tools @fuzzy

zi wait'0' pack 'for' \
  ls_colors \

zi ice as'null' sbin'bin/*'
zi light z-shell/zsh-diff-so-fancy

zi ice lucid atinit'Z_A_USECOMP=1'
zi light z-shell/z-a-eval

zi ice lucid from'gh-r' as'program' mv'mise* -> mise' sbin'mise* -> mise' atclone'$PWD/mise activate zsh > zhook.zsh' atpull'%atclone' src'zhook.zsh'
zi load jdx/mise
zi ice lucid wait'1' as'completion' blockf has'mise'
zi snippet https://github.com/jdx/mise/blob/main/completions/_mise

zi ice lucid wait'1' as'program' make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src'zhook.zsh'
zi light direnv/direnv

zi ice lucid wait'1' from'gh-r' as'program' sbin'**/delta -> delta'
zi light dandavison/delta

zi ice if'[ -z "$SSH_CONNECTION" ]' lucid wait'1' as'program' has'perl' pick'inxi'
zi light smxi/inxi

zi wait'1' lucid 'for' as'command' from'gh-r' bpick'kubectx;kubens' sbin'kubectx;kubens' \
  ahmetb/kubectx

#-----------------------------------------------------------------------------
[[ -z "$PS1" ]] && return
#-----------------------------------------------------------------------------
zi wait'0' atload=+'zicompinit_fast; zicdreplay' pack 'for' \
  system-completions \
  brew-completions

if (( $+commands[op] )); then
  [[ -d "$HOME/.cache" ]] || mkdir -p "$HOME/.cache"
  __comp="$HOME/.cache/_op"
  [[ -s "${__comp}" ]] || op completion zsh > "$__comp"
  zi ice lucid wait'1' blockf as'completion'
  zi snippet "${__comp}"
fi

if (( ${+_comps} )); then
  _comps[zi]=_zi
else
  zi ice lucid wait'1' blockf as'completion'
  zi snippet "${ZI[BIN_DIR]}/lib/_zi"
fi

zi has'zoxide' light-mode 'for' \
  z-shell/zsh-zoxide

zi lucid light-mode silent wait'1' 'for' \
  chriskempson/base16-shell

## Prompt
typeset -gx DEBUG_CHORN_PROMPT=
typeset -agx _preferred_languages=(ruby node elixir python3 go)
zi lucid light-mode 'for' \
  mafredri/zsh-async \
  @chorn/chorn-zsh-prompt

# zi ice as'command' from'gh-r' src'spaceship.zsh'
# zi light spaceship-prompt/spaceship-prompt
#-----------------------------------------------------------------------------
autoload -Uz zcalc
__calc() {
  zcalc -e "$*"
}
aliases[=]='noglob __calc'
#-----------------------------------------------------------------------------
_yup() {
  case "$1" in
    brew) (( $+commands[brew] )) && brew update --quiet && brew upgrade --greedy ;;
    zi)   (( $+commands[zi]   )) && zi self-update && zi update --all --parallel --quiet ;;
    mise) (( $+commands[mise] )) && mise self-update && mise install && mise upgrade ;;
    vim)  (( $+commands[vim]  )) && vim --not-a-term +PlugUpgrade +PlugUpdate +PlugClean +qall ;;
    nvim) (( $+commands[nvim] )) && nvim --headless +UpdateRemotePlugins +PlugUpgrade +PlugUpdate +PlugClean\! +qall ;;
  esac
}

yup() {
  for _cmd in brew zi mise vim nvim; do _yup "$_cmd"; done
}
#-----------------------------------------------------------------------------
alias -g M='| $PAGER'
alias -g J='| jq -rC \. | $PAGER -R'
alias -g B='| bat'
bindkey -e
bindkey -m 2>/dev/null

# Fuzzy match completions https://wiki.zshell.dev/docs/guides/customization#pretty-completions
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select
#-----------------------------------------------------------------------------
(( $+commands[atuin] )) && eval "$(atuin init zsh --disable-up-arrow)" || true
#-----------------------------------------------------------------------------
