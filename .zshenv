# --------------------------------------------------------------------------
# shellcheck shell=zsh
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
unsetopt \
  hist_find_no_dups \
  hist_verify \
  hist_ignore_space \
  share_history

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
typeset -gx BASE16_THEME="base16-twilight"
typeset -gx SAVEHIST=99999999
typeset -gx HISTSIZE=99999999
typeset -gx HISTFILESIZE=99999999
typeset -gx WORDCHARS='*?_.~&;!#$%'
typeset -gx ZSH_AUTOSUGGEST_USE_ASYNC=1
#-----------------------------------------------------------------------------
typeset -U zpath=( \
  "$HOME"/{tbin,bin} \
  /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin \
  /Applications/Docker.app/Contents/Resources/bin \
  /Applications/Postgres.app/Contents/Versions/latest/bin \
  /usr/local/MacGPG2/bin \
  /{usr,opt}/{local,homebrew}/{bin,sbin} \
  /home/linuxbrew/.linuxbrew/bin \
  /usr/local/opt/openssl/bin \
  /{opt,usr,snap}/{bin,sbin,libexec} \
  /{bin,sbin} \
  $(find /etc/paths /etc/paths.d -type f -exec cat {} 2>/dev/null \;) \
)
typeset -T -Ugx PATH path=($(find $zpath[@] -type d -maxdepth 0 2>|/dev/null)) ':'
#-----------------------------------------------------------------------------
typeset -Agx ZI
ZI[BIN_DIR]="${HOME}/.zi/bin"
ZI[SF]="$HOME/.config/zsh/site-functions"
#-----------------------------------------------------------------------------
for s in "$HOME/.shell-common" "$HOME/.shell-prv"; do
  [[ -s "$s" ]] && source "$s"
done
#-----------------------------------------------------------------------------
