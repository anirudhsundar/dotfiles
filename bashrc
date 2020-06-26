export SHELL=$(which bash)

# Setup multiline prompt with git branch info
source $HOME/.bash/prompt.bash

# Setup common aliases
source $HOME/.bash/aliases.bash

# Update PATH env with auto installed packages
source $HOME/.bash/paths.bash

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
[ -f $HOME/.local_bash_paths ] && source $HOME/.local_bash_paths

# Expand directories for variables
# Disable with 
# shopt -u direxpand
shopt -s direxpand # enable
