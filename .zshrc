#-----------------------------------------------------------------------------
# This has to be here.

typeset -gx SAVEHIST=99999999
typeset -gx HISTSIZE=99999999
typeset -gx HISTFILESIZE=99999999
#-----------------------------------------------------------------------------
## ZI
if ! [[ -s "${ZI[BIN_DIR]}/zi.zsh" ]]; then
   echo git clone https://github.com/z-shell/zi.git "${ZI[BIN_DIR]}"
   exit 0
fi

source "${ZI[BIN_DIR]}/zi.zsh"
(( ${+_comps} )) && _comps[zi]=_zi
autoload -Uz _zi

zi add-fpath "${ZI[SF]}"
zi add-fpath /opt/homebrew/share/zsh/site-functions
zi add-fpath /opt/homebrew/share/zsh/functions

## Deps

zi ice lucid
zi light z-shell/z-a-bin-gem-node

zi ice lucid
zi light z-shell/z-a-rust

zi ice lucid from'gh-r' as'program' mv'mise* -> mise' sbin'mise* -> mise' atclone"\"$HOME/.zi/polaris/bin/mise\" activate zsh > zhook.zsh; \"$HOME/.zi/polaris/bin/mise\" completion zsh > \"${ZI[SF]}/_mise\"" atpull'%atclone' src'zhook.zsh'
zi load jdx/mise

zi ice lucid
zi light mafredri/zsh-async

## Programs

zi ice lucid wait'1' from'gh-r' as'program'
zi light junegunn/fzf

zi ice lucid wait'1' from'gh-r' as'program' mv'ripgrep*/rg -> rg' sbin'rg* -> rg'
zi light BurntSushi/ripgrep

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

autoload -Uz bashcompinit && bashcompinit
autoload -Uz compinit && compinit

zi ice lucid wait as'completion' blockf mv'git-completion.zsh -> _git'
zi snippet https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh

zi ice lucid wait'1' as'completion'
zi light zsh-users/zsh-completions

if (( $+commands[op] )); then
  __op="${ZI[SF]}/_op"
  [[ -s "${__op}" ]] || op completion zsh > "$__op"
  zi ice as'completion'
  zi snippet "${__op}"
fi

if (( $+commands[mise] )); then
  __mise_comp="${ZI[SF]}/_mise"
  __direnv_lib="${HOME}/.config/direnv/lib"
  __mise_direnv="${__direnv_lib}/mise.sh"

  if [[ -s "${__mise_comp}" ]]; then
    zi ice as'completion'
    zi snippet "$__mise_comp"
  fi

  if (( $+commands[direnv] )); then
    [[ -d "$__direnv_lib" ]] || mkdir -p "$__direnv_lib"
    [[ -s "$__mise_direnv" ]] || mise direnv activate > "$__mise_direnv"
  fi
fi

## Interactive

zi ice lucid wait'1'
zi light chriskempson/base16-shell

zi ice lucid wait'1'
zi light z-shell/zui

zi ice lucid wait'1'
zi light z-shell/zbrowse

zi ice lucid wait'1'
zi light z-shell/zsh-lint

zi wait pack for ls_colors

zi ice lucid wait'1' atload'!_zsh_autosuggest_start'
zi load zsh-users/zsh-autosuggestions

## Prompt

typeset -agx _preferred_languages=(node go ruby elixir python)
zi ice lucid wait'!0'
zi light @chorn/chorn-zsh-prompt

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
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

typeset -g PERIOD=60
autoload -Uz add-zsh-hook
whence -w preserve_my_history >&/dev/null && add-zsh-hook periodic preserve_my_history
#-----------------------------------------------------------------------------
# CTRL-R - Paste the selected command from history into the command line
chorn-history-widget() {
  local selected num

  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null

  selected=( $(fc -rl 1 \
    | fzf --height 80% --info=inline --ansi --tabstop=2 --no-multi -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort,ctrl-z:ignore --query="${LBUFFER}") )

  local ret=$?

  if [[ -n "$selected" ]]; then
    num=$selected[1]

    [[ -n "$num" ]] && zle vi-fetch-history -n $num

  fi
  zle reset-prompt
  return $ret
}

if (( $+commands[fzf] )); then
  zle     -N   chorn-history-widget
  bindkey '^R' chorn-history-widget
fi
#-----------------------------------------------------------------------------
unset MANPATH
#-----------------------------------------------------------------------------
# vim: set syntax=zsh ft=zsh sw=2 ts=2 expandtab:
#-----------------------------------------------------------------------------
