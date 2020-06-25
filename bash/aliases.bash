alias ls='ls --color=auto'
alias l='ls -lrtha --color=auto'
alias grep='grep --color=auto'
alias ta='tmux a'

function cd_up() {
  cd $(printf "%0.s../" $(seq 1 $1 ));
}
alias 'cd..'='cd_up'
