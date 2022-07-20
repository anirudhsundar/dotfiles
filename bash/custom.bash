#!/bin/bash

# Enable z.lua
# eval "$(lua z.lua --init bash enhanced once fzf)"
shopt -s autocd

export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL=erasedups

function pathunique(){
  p="$1"
  echo ${p}=$(printf "%s" "${!p}" | awk -v RS=':' '!a[$1]++ { if (NR > 1) printf RS; printf $1 }')
  export ${p}=$(printf "%s" "${!p}" | awk -v RS=':' '!a[$1]++ { if (NR > 1) printf RS; printf $1 }')
}
