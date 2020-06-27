
# Setup common aliases
source $HOME/.shell/aliases.sh

# Update PATH env with auto installed packages
source $HOME/.shell/paths.sh

# Source fzf if it exists
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source local paths if it exists
[ -f $HOME/.local_paths ] && source $HOME/.local_paths
