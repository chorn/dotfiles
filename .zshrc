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
typeset -agx ZSH_AUTOSUGGEST_STRATEGY=( history completion )
typeset -gx EZA_CONFIG_DIR=$HOME/.config/eza
unset MANPATH
#-----------------------------------------------------------------------------
typeset -U zpath=(
  "$HOME"/{tbin,bin}
  "$HOME"/{.cargo,.local}/{bin,sbin}
  /Applications/CMake.app/Contents/bin
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

declare -a __zi_setup=(
  z-shell/z-a-default-ice
  z-shell/z-a-bin-gem-node
  z-shell/z-a-patch-dl
  z-shell/z-a-readurl
  z-shell/zui
  z-shell/zsh-lint
  mafredri/zsh-async
)

declare -a __zi_plugins=(
  z-shell/F-Sy-H
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  voronkovich/gitignore.plugin.zsh
  paulirish/git-open
)

declare -a __zi_ghr=(
  sbin'**/fzf' junegunn/fzf
  sbin'**/fd' @sharkdp/fd
  sbin'**/bat' @sharkdp/bat
  sbin'**/hexyl' @sharkdp/hexyl
  sbin'**/hyperfine' @sharkdp/hyperfine
  sbin'**/vivid' @sharkdp/vivid
  sbin'**/delta' dandavison/delta
  sbin'**/rg' BurntSushi/ripgrep
  sbin'**/reflex' cespare/reflex
  sbin'**/ubi' houseabsolute/ubi
  sbin'**/lf' gokcehan/lf
  sbin'**/zoxide'       atclone'./zoxide init zsh --cmd cd > zhook.zsh'                                 atpull'%atclone' src'zhook.zsh' ajeetdsouza/zoxide
  mv'direnv* -> direnv' atclone'./direnv hook zsh > zhook.zsh'                                          atpull'%atclone' src'zhook.zsh' direnv/direnv
  mv'mise* -> mise'     atclone'$PWD/mise activate zsh > zhook.zsh && $PWD/mise completion zsh > _mise' atpull'%atclone' src'zhook.zsh' jdx/mise
)

declare -a __zi_gh=(
  sbin'**/eza' atclone'CARGO_HOME=$ZPFX cargo install --path . && cp -vf completions/zsh/_eza _eza' eza-community/eza
)

declare -a __zi_commands=(
  paulirish/git-recent
  davidosomething/git-my
  arzzen/git-quick-stats
  iwata/git-now
  pick'czhttpd' mv'czhttpd -> httpd' chorn/czhttpd
  pick'bin/*' z-shell/zsh-diff-so-fancy
)

declare -a __zi_silent=(
  tinted-theming/tinted-shell
)

zi lucid light-mode 'for' "${__zi_setup[@]}"
zi lucid light-mode wait'0'                           'for' "${__zi_plugins[@]}"
zi lucid light-mode wait'1' from'gh-r' as'command'    'for' "${__zi_ghr[@]}"
zi lucid light-mode wait'1' from'gh'   as'command'    'for' "${__zi_gh[@]}"
zi lucid light-mode wait'1'            as'command'    'for' "${__zi_commands[@]}"
zi lucid light-mode wait'1' silent                    'for' "${__zi_silent[@]}"

#-----------------------------------------------------------------------------
[[ -z "$PS1" ]] && return
#-----------------------------------------------------------------------------
typeset -A __zi_comps=(
  [tinty]='generate-completion'
  [op]='completion'
  [yar]=''
)

for _cmd in "${(k)__zi_comps[@]}"; do
  (( $+commands["${_cmd}"] )) || continue
  typeset _comp="${ZI[CACHE_DIR]}/_${_cmd}"
  [[ -s "${_comp}" ]] || "$_cmd" ${__zi_comps[${_cmd}]} zsh > "$_comp"
  zi ice lucid wait'1' as'completion'
  zi snippet "${_comp}"
done

[[ -d ~/.local/share/tinted-theming/tinty ]] && find ~/.local/share/tinted-theming/tinty -mindepth 1 -maxdepth 1 -size +0 -name '*.sh' | while read -r f; do
  source "$f" >&/dev/null || true
done

## Prompt
if (( $+commands[starship])); then
  eval "$(starship init zsh)"
else
  typeset -gx DEBUG_CHORN_PROMPT=
  typeset -gxa _prompt_languages=(ruby node go)
  typeset -gxA _prompt_extra_git=( [PUB]="$HOME/.git-pub-dotfiles" [PRV]="$HOME/.git-prv-dotfiles" )
  zi lucid light-mode 'for' @chorn/chorn-zsh-prompt
fi

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
if (( $+commands[atuin] )); then
  eval "$(atuin init zsh --disable-up-arrow)" || true
fi
#-----------------------------------------------------------------------------
alias -g M='| $PAGER -R'
alias -g J='| jq -rC \. | $PAGER -R'
alias -g B='| bat'
alias -g C='| wc -l'
bindkey -e
bindkey -m 2>/dev/null

bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word
bindkey '^[[1;5D' beginning-of-line
bindkey '^[[1;5C' end-of-line
#-----------------------------------------------------------------------------
autoload -Uz zcalc
__calc() { zcalc -e "$*"; }
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
  zi compinit >/dev/null
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

_yup_tinty() {
  tinty sync --quiet
}

yup() {
  local -a _what=("${@[@]}")
  [[ "${#_what[@]}" -gt 0 ]] || _what=(brew zi mise vim tinty)
  for _cmd in "${_what[@]}"; do _yup "$_cmd"; done
}
#-----------------------------------------------------------------------------
