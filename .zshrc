# --------------------------------------------------------------------------
# shellcheck shell=bash disable=SC2207,SC1087,SC2128,SC2086,SC2016,SC2154,SC2034,SC1091,SC2139,SC2004,SC2299,SC2296,SC2298
# vim: set syntax=zsh ft=zsh sw=2 ts=2 expandtab:
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

typeset -a __zi_setup=(
  z-shell/z-a-default-ice
  z-shell/z-a-rust
  z-shell/z-a-bin-gem-node
  z-shell/z-a-patch-dl
  z-shell/z-a-readurl
  mafredri/zsh-async
  from'gh-r' sbin'tinty' atclone'./tinty generate-completion zsh > _tinty' atpull'%atclone' tinted-theming/tinty
  silent tinted-theming/tinted-shell
  from'gh-r' sbin'starship' atclone'./starship init zsh > starship.plugin.zsh' atpull'%atclone' compile'starship.plugin.zsh' src'starship.plugin.zsh' starship/starship
  from'gh-r' sbin'**/fzf' dl'https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh -> _fzf' junegunn/fzf
)

typeset -a __zi_plugins=(
  z-shell/F-Sy-H
  zsh-users/zsh-autosuggestions
  voronkovich/gitignore.plugin.zsh
  paulirish/git-open
)

typeset -a __zi_ghr=(
  sbin'**/bat' @sharkdp/bat
  sbin'**/fd' @sharkdp/fd
  sbin'**/hexyl' @sharkdp/hexyl
  sbin'**/hyperfine' @sharkdp/hyperfine
  sbin'**/pastel' @sharkdp/pastel
  sbin'**/vivid' @sharkdp/vivid
  sbin'**/delta' dandavison/delta
  sbin'**/rg' BurntSushi/ripgrep
  sbin'**/reflex' cespare/reflex
  sbin'**/ubi' houseabsolute/ubi
  sbin'**/lf' gokcehan/lf
  sbin'**/zoxide' atclone'./zoxide init zsh --cmd cd > zoxide.plugin.zsh' atpull'%atclone' compile'zoxide.plugin.zsh' src'zoxide.plugin.zsh' ajeetdsouza/zoxide
  mv'direnv* -> direnv' atclone'./direnv hook zsh > direnv.plugin.zsh' atpull'%atclone' compile'direnv.plugin.zsh' src'direnv.plugin.zsh' direnv/direnv
  mv'mise* -> mise' atclone'$PWD/mise activate zsh > mise.plugin.zsh && $PWD/mise completion zsh > _mise' atpull'%atclone' compile'mise.plugin.zsh' src'mise.plugin.zsh' jdx/mise
  bpick'atuin-*.tar.gz' mv'atuin*/atuin -> atuin' atclone'./atuin init zsh --disable-up-arrow > atuin.plugin.zsh; ./atuin gen-completions --shell zsh > _atuin' atpull'%atclone' compile'atuin.plugin.zsh' src'atuin.plugin.zsh' atuinsh/atuin
)

typeset -a __zi_gh=(
  sbin'**/eza' if'[[ ! -d /usr/syno ]]' atclone'CARGO_HOME=$ZPFX cargo install --force --path .' eza-community/eza
)

typeset -a __zi_commands=(
  paulirish/git-recent
  davidosomething/git-my
  arzzen/git-quick-stats
  iwata/git-now
  pick'czhttpd' mv'czhttpd -> httpd' chorn/czhttpd
  pick'bin/*' z-shell/zsh-diff-so-fancy
)

typeset -a __zi_completions=(
  zchee/zsh-completions
  zsh-users/zsh-completions
)

zi lucid light-mode 'for' "${__zi_setup[@]}"
zi lucid light-mode wait'0'                           'for' "${__zi_plugins[@]}"
zi lucid light-mode wait'0' from'gh-r' as'command'    'for' "${__zi_ghr[@]}"
zi lucid light-mode wait'1' from'gh'   as'command'    'for' "${__zi_gh[@]}"
zi lucid light-mode wait'1'            as'command'    'for' "${__zi_commands[@]}"
zi lucid light-mode wait'1' blockf     as'completion' 'for' "${__zi_completions[@]}"

__cli_comp() {
  local _cmd=$1
  local -a _how=("$@")
  command -v "${_cmd}" >&/dev/null || return
  local _c="${ZI[CACHE_DIR]}/_${_cmd}"
  [[ -s "${_c}" ]] || "${_how[@]}" > "$_c"
  zi ice lucid wait'0' id-as"_${_cmd}" as'completion' has"${_cmd}"
  zi snippet "${_c}"
}

__cli_comp op completion zsh
__cli_comp yar completion zsh
#-----------------------------------------------------------------------------
for s in "$HOME/.shell-common" "$HOME/.shell-prv"; do
  [[ -s "$s" ]] && source "$s"
done
#-----------------------------------------------------------------------------
[[ -z "$PS1" ]] && return

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
autoload -Uz zcalc
__calc() { zcalc -e "$*"; }
aliases[=]='noglob __calc'

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
