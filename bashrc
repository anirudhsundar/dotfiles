export SHELL=$(which bash)

/local/mnt/workspace/anirudh/tools/home_backup

# Setup multiline prompt with git branch info
source bash/prompt.bash

# Setup common aliases
source bash/aliases.bash

# Update PATH env with auto installed packages
source bash/paths.bash

# Ignore and erase duplicates and 
# ignore commands that start with space
# (sets ignorespace, ignoredups and erasedups)
export HISTCONTROL=ignoreboth:erasedups

# Temp settings
#export SSH_AUTH_SOCK=/tmp/ssh-y4jUISdYfREO/agent.31604
#export SSH_AGENT_PID=31605
