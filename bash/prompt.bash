parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

RESET="\[\033[0m\]"
RED="\[\033[0;31m\]"
GREEN="\[\033[32m\]"
BLUE="\[\033[01;34m\]"
YELLOW="\[\033[0;33m\]"


export PS1="$YELLOW\u$BLUE@\h$GREEN:$RED\w$YELLOW\$(parse_git_branch)  \n$RED>$YELLOW>$GREEN>$RESET "
export PROMPT_DIRTRIM=3
