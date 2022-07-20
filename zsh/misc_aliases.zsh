# Suffix aliases
alias -s zip='unzip -l'

# Global aliases
alias -g L='|& less'
alias -g C='| wc -l'
alias -g TL='| tail -20'
alias -g T='| tail'
alias -g NS='| sort -n'

function pathunique(){
  p="$1"
  echo ${p}=$(printf "%s" "${(P)p}" | awk -v RS=':' '!a[$1]++ { if (NR > 1) printf RS; printf $1 }')
  export ${p}=$(printf "%s" "${(P)p}" | awk -v RS=':' '!a[$1]++ { if (NR > 1) printf RS; printf $1 }')
}
