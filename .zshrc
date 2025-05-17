# --------------------------------------------------------------------------
# shellcheck shell=bash disable=SC2207,SC1087,SC2128,SC2086,SC2016,SC2154,SC2034,SC1091,SC2139,SC2004,SC2299,SC2296,SC2298
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
typeset -gx TINTED_SHELL_ENABLE_BASE16_VARS=1
typeset -gx TINTED_SHELL_ENABLE_BASE24_VARS=1
typeset -gx VISUAL=vim
typeset -gx WORDCHARS='*?_.~&;!#$%'
typeset -gx ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=128
typeset -gx ZSH_AUTOSUGGEST_USE_ASYNC=1
unset MANPATH
#-----------------------------------------------------------------------------
typeset -U zpath=(
  "$HOME"/{tbin,bin}
  "$HOME"/.local/{bin,sbin}
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
[[ -d '/usr/syno' ]] && zpath+=(/volume1/homes/linuxbrew/.linuxbrew/bin)
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
  z-shell/z-a-eval \
  @annexes \
  @sharkdp \
  @ext-git \
  @console-tools

zi pack'bgn-binary' 'for' fzf

# zi light-mode 'for' \
#     skip'zsh-users/zsh-completions' @zsh-users+fast

zi light z-shell/F-Sy-H
zi light zsh-users/zsh-autosuggestions
zi light zsh-users/zsh-completions
# zi light z-shell/zsh-fancy-completions

zi lucid light-mode wait'0' 'for' as'null' sbin'bin/*' z-shell/zsh-diff-so-fancy

zi ice lucid from'gh-r' as'command' mv'mise* -> mise' sbin'mise* -> mise' atclone'$PWD/mise activate zsh > zhook.zsh' atpull'%atclone' src'zhook.zsh'
zi light jdx/mise

zi ice lucid wait'0' as'command' make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src'zhook.zsh'
zi light direnv/direnv

zi ice lucid wait'0' as'command' pick'inxi' has'perl'
zi light smxi/inxi

zi ice lucid wait'1' as'command' pick'czhttpd' mv'czhttpd -> httpd'
zi light chorn/czhttpd

zi ice lucid wait'0' from'gh-r' as'command' sbin'**/delta -> delta'
zi light dandavison/delta

zi ice lucid wait'1' from'gh-r' as'command' bpick'kubectx;kubens' sbin'kubectx;kubens'
zi light ahmetb/kubectx

zi ice lucid wait'1' from'gh-r' as'command' sbin'**/delta -> delta'
zi light dandavison/delta

zi ice lucid wait'1' from'gh-r' as'program' has'fzf'
zi light denisidoro/navi

zi ice lucid wait'1' from'gh-r' as'command' sbin'**/reflex-> reflex'
zi light cespare/reflex

zi ice lucid wait'1' from'gh-r' as'command'
zi light houseabsolute/ubi

#-----------------------------------------------------------------------------
[[ -z "$PS1" ]] && return
#-----------------------------------------------------------------------------
declare _tinty=$HOME/.local/share/tinted-theming/tinty
declare -a _tint_scripts=(tinted-shell-scripts-file.sh tinted-fzf-sh-file.sh)
[[ "${OSTYPE/[^a-z]*/}" == 'darwin' ]] && _tint_scripts+=(tinted-iterm2-scripts-file.sh)

for f in "${_tint_scripts[@]}"; do
  [[ -s "${_tinty}/${f}" ]] && source "${_tinty}/${f}"
done
#-----------------------------------------------------------------------------
zi ice lucid wait'1' 'for' has'eza' atinit'AUTOCD=1' zplugin/zsh-eza

zi ice lucid wait'0' pack 'for' ls_colors

# zi lucid light-mode wait'0' atload=+'zicompinit_fast; zicdreplay' pack 'for' brew-completions system-completions

zi ice lucid wait'0' as'completion' has'mise'
zi snippet https://raw.githubusercontent.com/jdx/mise/main/completions/_mise

if (( $+commands[op] )); then
  declare _op_comp="${ZI[CACHE_DIR]}/_op"
  [[ -s "${_op_comp}" ]] || op completion zsh > "$_op_comp"
  zi ice lucid wait'0' as'completion'
  zi snippet "${_op_comp}"
fi

if (( $+commands[yar] )); then
  declare _yar_comp="${ZI[CACHE_DIR]}/_yar"
  [[ -s "${_yar_comp}" ]] || yar zsh > "$_yar_comp"
  zi ice lucid wait'0' as'completion'
  zi snippet "${_yar_comp}"
fi

# if (( ${+_comps} )); then
#   _comps[zi]=_zi
# else
#   zi ice lucid wait'1' blockf as'completion'
#   zi snippet "${ZI[BIN_DIR]}/lib/_zi"
# fi

zi has'zoxide' light-mode 'for' \
  z-shell/zsh-zoxide

zi lucid light-mode silent wait'1' 'for' \
  tinted-theming/tinted-shell

## Prompt
typeset -gx DEBUG_CHORN_PROMPT=
typeset -gxa _prompt_languages=(ruby node go)
typeset -gxA _prompt_extra_git=( [PUB]="$HOME/.git-pub-dotfiles" [PRV]="$HOME/.git-prv-dotfiles" )
zi lucid light-mode 'for' \
  mafredri/zsh-async \
  @chorn/chorn-zsh-prompt

# zi ice as'command' from'gh-r' src'spaceship.zsh'
# zi light spaceship-prompt/spaceship-prompt

zicompinit_fast
zicdreplay

#-----------------------------------------------------------------------------
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
alias -g M='| $PAGER'
alias -g J='| jq -rC \. | $PAGER -R'
alias -g B='| bat'
bindkey -e
bindkey -m 2>/dev/null
#-----------------------------------------------------------------------------
autoload -Uz zcalc
__calc() {
  zcalc -e "$*"
}
aliases[=]='noglob __calc'
#-----------------------------------------------------------------------------
_yup() {
  local _what=$1
  [[ -n "$_what" ]] || return 0
  (( $+functions[${_what}] || $+commands[${_what}] )) || return 0
  local _ywhat=_yup_${_what}
  (( $+functions[${_ywhat}] )) || return 1
  echo ">>> $_what"
  (
    set -e
    "${_ywhat}"
  )
}

_yup_vim() {
  vim --not-a-term +PlugUpgrade +PlugUpdate +PlugClean +qall
}

_yup_nvim() {
  nvim --headless +UpdateRemotePlugins +PlugUpgrade +PlugUpdate +PlugClean\! +qall
  echo
}

_yup_zi() {
  zi self-update -q
  zi update --all --parallel --quiet
  zi compinit
  zi zstatus
}

_yup_brew() {
  local _greedy=${${${(L)OSTYPE:0:1}/[^d]/}/d/--greedy}
  brew doctor --quiet || true
  brew update --quiet
  brew outdated $_greedy
  brew upgrade --quiet $_greedy
  brew cleanup --prune=all --scrub --quiet
}

_yup_mise() {
  mise self-update --yes --quiet
  mise doctor >&/dev/null
  mise install --yes --quiet
  mise upgrade --yes --bump --quiet
}

yup() {
  local -a _what=("${@[@]}")
  [[ "${#_what[@]}" -gt 0 ]] || _what=(brew zi mise vim)
  for _cmd in "${_what[@]}"; do _yup "$_cmd"; done
}
#-----------------------------------------------------------------------------
