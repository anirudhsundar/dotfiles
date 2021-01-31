
# Setup common aliases
source $HOME/.shell/aliases.sh

# Update PATH env with auto installed packages
source $HOME/.shell/paths.sh

# Source fzf if it exists
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $HOME/.shell/fzf_aliases.sh

# Update paths for binaries inside my repo
source $HOME/.shell/common_paths.sh

#refer rg over ag
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
fi

# Source local paths if it exists
[ -f $HOME/.local_paths ] && source $HOME/.local_paths

# set 256 color in terminal
export TERM=xterm-256color

custom_plugins=(zsh-autosuggestions zsh-syntax-highlighting z.lua)

MY_CUSTOM_PLUGINS=$HOME/.zsh/plugins

for plugin ($custom_plugins); do
  if [ -f $MY_CUSTOM_PLUGINS/$plugin/$plugin.plugin.zsh ]; then
    source $MY_CUSTOM_PLUGINS/$plugin/$plugin.plugin.zsh
  fi
done

# Autosuggestions bindkey for ctrl-space
bindkey '^ ' autosuggest-accept
eval `dircolors $HOME/dotfiles/misc/dircolors-solarized/dircolors.256dark`
#source $MY_CUSTOM_PLUGINS/fzf-tab-completion/zsh/fzf-zsh-completion.sh
