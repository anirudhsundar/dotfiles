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

alias le='exa -lga --icons --group-directories-first --git --grid -snew'
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
alias recent='ls -lrth | tail -n 1 | awk "{print \$NF}"'
alias recentd='ls -lrthd */ | tail -n 1 | awk "{print \$NF}"'

padd() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    if [[ $2 == "front" ]]; then
      PATH="$1${PATH:+":$PATH"}"
    else
      PATH="${PATH:+"$PATH:"}$1"
    fi
  fi
}

ldadd() {
  if [ -d "$1" ] && [[ ":$LD_LIBRARY_PATH:" != *":$1:"* ]]; then
    if [[ $2 == "front" ]]; then
      LD_LIBRARY_PATH="$1${LD_LIBRARY_PATH:+":$LD_LIBRARY_PATH"}"
    else
      LD_LIBRARY_PATH="${LD_LIBRARY_PATH:+"$LD_LIBRARY_PATH:"}$1"
    fi
  fi
}

pypadd() {
  if [ -d "$1" ] && [[ ":$PYTHONPATH:" != *":$1:"* ]]; then
    if [[ $2 == "front" ]]; then
      PYTHONPATH="$1${PYTHONPATH:+":$PYTHONPATH"}"
    else
      PYTHONPATH="${PYTHONPATH:+"$PYTHONPATH:"}$1"
    fi
  fi
}

export HOWDOI_COLORIZE=1

if command -v thefuck >& /dev/null
then
  eval $(thefuck --alias)
  alias fk=fuck
fi

