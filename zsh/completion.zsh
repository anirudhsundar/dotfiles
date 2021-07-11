autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zmodload zsh/complist
# use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol # Disable flow control using ^S/^Q keys
setopt auto_menu         # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end
setopt complete_aliases
