export SHELL=$(which bash)

# Setup multiline prompt with git branch info
# source $HOME/.bash/prompt.bash

# Update PATH env with auto installed packages
source $HOME/.shell/paths.sh

# Bash specific custom setup
source $HOME/.bash/custom.bash

# Update paths for binaries inside my repo
source $HOME/.shell/common_paths.sh

# Git completion
source $HOME/.bash/git-completion.bash

# Ignore and erase duplicates and
# ignore commands that start with space
# (sets ignorespace, ignoredups and erasedups)
export HISTCONTROL=ignoreboth:erasedups

# set 256 color in terminal
export TERM=xterm-256color

# Temp settings
#export SSH_AUTH_SOCK=/tmp/ssh-y4jUISdYfREO/agent.31604
#export SSH_AGENT_PID=31605

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f $HOME/.local_paths ] && source $HOME/.local_paths

# Setup common aliases
source $HOME/.shell/aliases.sh

# Expand directories for variables
# Disable with
# shopt -u direxpand
shopt -s direxpand # enable

eval "$(zoxide init bash)"

source $HOME/.shell/fzf_aliases.sh
eval "$(starship init bash)"
