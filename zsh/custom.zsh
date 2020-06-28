
# Setup common aliases
source $HOME/.shell/aliases.sh

# Update PATH env with auto installed packages
source $HOME/.shell/paths.sh

# Source fzf if it exists
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source local paths if it exists
[ -f $HOME/.local_paths ] && source $HOME/.local_paths

# set 256 color in terminal
export TERM=xterm-256color

custom_plugins=(k zsh-autosuggestions zsh-syntax-highlighting)

MY_CUSTOM_PLUGINS=$HOME/.zsh/plugins

for plugin ($custom_plugins); do
  if [ -f $MY_CUSTOM_PLUGINS/$plugin/$plugin.plugin.zsh ]; then
    source $MY_CUSTOM_PLUGINS/$plugin/$plugin.plugin.zsh
  fi
done

# Autosuggestions bindkey for ctrl-space
bindkey '^ ' autosuggest-accept
