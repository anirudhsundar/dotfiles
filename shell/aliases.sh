alias ls='ls --color=auto'
alias l='ls -lrtha --color=auto'
alias grep='grep --color=auto'
alias ta='tmux a'
alias minivim='vim -u ~/.minivimrc'
alias cdr='cd $(git rev-parse --show-toplevel)'
alias rf='readlink -f'
function cdf() {
  filepath=$(readlink -f $1)
  dir=$(dirname $filepath)
  cd $dir
}

function cd_up() {
  cd $(printf "%0.s../" $(seq 1 $1 ));
}
alias 'cd..'='cd_up'

alias tw='task +work'
alias th='task +home'
alias te='task +extra'

alias le='exa -lga --icons --group-directories-first'
alias ex='exa --icons --group-directories-first'

source $HOME/.bin/lfcd.sh
