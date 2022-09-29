alias ls='ls --color=auto'
alias l='ls -lrtha --color=auto'
alias grep='grep --color=auto'
alias rgc="rg --color=always"
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

# Install screen-256color terminfo using the below command
# tic /path/to/dotfiles/screen-256color.terminfo
alias tmux='env TERM=screen-256color tmux'

alias chompeof="perl -pi -e 'chomp if eof'"
alias unique="awk '!a[\$0]++'"
alias tmpd="cd \$(mktemp -d)"

source $HOME/.bin/lfcd.sh

alias vman='MANPAGER="vim -M +MANPAGER -" man'
alias tkill="for s in \$(tmux list-sessions | awk '{print \$1}' | rg ':' -r '' | fzf --multi); do tmux kill-session -t \$s; done;"
alias recent='ls -lrtha | tail -n 1 | awk "{print \$NF}"'

