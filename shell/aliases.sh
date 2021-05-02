alias ls='ls --color=auto'
alias l='ls -lrtha --color=auto'
alias grep='grep --color=auto'
alias ta='tmux a'
alias minivim='vim -u ~/.minivimrc'
alias cdr='cd $(git rev-parse --show-toplevel)'

function cd_up() {
  cd $(printf "%0.s../" $(seq 1 $1 ));
}
alias 'cd..'='cd_up'

alias tw='task +work'
alias th='task +home'

source $HOME/.bin/lfcd.sh
