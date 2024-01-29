# --------------------------------------------------------------------------
# shellcheck shell=bash disable=SC2207,SC1087,SC2128,SC2086,SC2016,SC2154,SC2034,SC1091
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
typeset -gx PAGER=less
typeset -gx EDITOR=vim
typeset -gx VISUAL=vim
typeset -gx LESS="iRQXF"
typeset -gx MAILCHECK=0
typeset -gx SHELLCHECK_OPTS="--shell=bash --exclude=SC2001,SC1090,SC2164,SC2068,SC2155"
typeset -gx RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
typeset -gx FZF_DEFAULT_OPTS='--info=inline --ansi --tabstop=2 --multi --preview-window=right'
typeset -gx DOCKER_SCAN_SUGGEST=false
typeset -gx BASE16_THEME=twilight
typeset -gx BASE16_DEFAULT_THEME=base16-${BASE16_THEME}
typeset -gx SAVEHIST=99999999
typeset -gx HISTSIZE=99999999
typeset -gx HISTFILESIZE=99999999
typeset -gx WORDCHARS='*?_.~&;!#$%'
typeset -gx ZSH_AUTOSUGGEST_USE_ASYNC=1
typeset -gx ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=128
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

## Packs

zi wait pack for fzf
zi wait pack for ls_colors

## Deps

zi ice lucid
zi light z-shell/z-a-bin-gem-node

zi ice lucid
zi light z-shell/z-a-rust

zi ice lucid from'gh-r' as'program' mv'mise* -> mise' sbin'mise* -> mise' atclone'$PWD/mise activate zsh > zhook.zsh' atpull'%atclone' src'zhook.zsh'
zi load jdx/mise
zi ice lucid wait'1' as'completion' blockf has'mise'
zi snippet https://github.com/jdx/mise/blob/main/completions/_mise

zi ice lucid
zi light mafredri/zsh-async

## Programs

zi ice lucid wait'1' from'gh-r' as'program' mv'ripgrep*/rg -> rg' sbin'rg* -> rg'
zi light BurntSushi/ripgrep
zi ice lucid wait'1' as'completion' blockf has'rg' mv'rg.zsh -> _rg'
zi snippet https://github.com/BurntSushi/ripgrep/blob/master/crates/core/flags/complete/rg.zsh

zi ice lucid wait'1' from'gh-r' as'program' sbin'**/delta -> delta'
zi light dandavison/delta

zi ice lucid wait'1' from'gh-r' as'program' mv'fd* fd' sbin'**/fd(.exe|) -> fd'
zi light @sharkdp/fd

zi ice lucid wait'1' from'gh-r' as'program' mv'bat* bat' sbin'**/bat(.exe|) -> bat'
zi light @sharkdp/bat

zi ice lucid wait'1' from'gh-r' as'program' has'bat' pick'src/*'
zi light eth-p/bat-extras

zi ice if'[ -z "$SSH_CONNECTION" ]' lucid wait'1' as'program' has'perl' pick'inxi'
zi light smxi/inxi

zi ice lucid wait'1' from'gh-r' as'program' mv'hexyl* hexyl' sbin'**/hexyl(.exe|) -> hexyl'
zi light @sharkdp/hexyl

zi ice lucid wait'1' from'gh-r' as'program' mv'vivid* vivid' sbin'**/vivid(.exe|) -> vivid'
zi light @sharkdp/vivid

zi ice lucid wait'1' as'program' make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src'zhook.zsh'
zi light direnv/direnv

zi ice lucid wait'1' as'null' sbin'bin/*'
zi light z-shell/zsh-diff-so-fancy

zi as'null' lucid wait'1' for \
  sbin Fakerr/git-recall \
  sbin cloneopts paulirish/git-open \
  sbin paulirish/git-recent \
  sbin davidosomething/git-my \
  sbin iwata/git-now \
  sbin atload'export _MENU_THEME=legacy' arzzen/git-quick-stats \
  make'PREFIX=$ZPFX install' tj/git-extras

#-----------------------------------------------------------------------------
[[ -z "$PS1" ]] && return
#-----------------------------------------------------------------------------
## Completions

zi wait pack for system-completions
zi wait pack for brew-completions

zi ice lucid blockf as'completion'
zi light zsh-users/zsh-completions

if (( $+commands[op] )); then
  [[ -d "$HOME/.cache" ]] || mkdir -p "$HOME/.cache"
  __comp="$HOME/.cache/_op"
  [[ -s "${__comp}" ]] || op completion zsh > "$__comp"
  zi ice lucid wait'1' blockf as'completion'
  zi snippet "${__comp}"
fi

if (( $+commands[direnv] )) && (( $+commands[mise] )); then
  __direnv_lib="${HOME}/.config/direnv/lib"
  __mise_direnv="${__direnv_lib}/mise.sh"
  [[ -d "$__direnv_lib" ]] || mkdir -p "$__direnv_lib"
  [[ -s "$__mise_direnv" ]] || mise direnv activate > "$__mise_direnv"
fi

if (( ${+_comps} )); then
  _comps[zi]=_zi
else
  zi ice lucid wait'1' blockf as'completion'
  zi snippet "${ZI[BIN_DIR]}/lib/_zi"
fi

## Interactive

zi ice lucid wait'1'
zi light chriskempson/base16-shell

zi wait'0' lucid for \
  atinit"ZI[COMPINIT_OPTS]=-C; zicompinit_fast; zicdreplay" z-shell/F-Sy-H \
  blockf zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" zsh-users/zsh-autosuggestions

## Prompt

typeset -gx DEBUG_CHORN_PROMPT=
typeset -agx _preferred_languages=(ruby node elixir python3)
zi ice lucid wait'!0'
zi light @chorn/chorn-zsh-prompt

# zi ice as"command" from"gh-r" \
#   atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
#   atpull"%atclone" src"init.zsh"
# zi light starship/starship

#-----------------------------------------------------------------------------
autoload -Uz zcalc
__calc() {
  zcalc -e "$*"
}
aliases[=]='noglob __calc'
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
(( $+commands[atuin] )) && eval "$(atuin init zsh --disable-up-arrow)"
#-----------------------------------------------------------------------------
