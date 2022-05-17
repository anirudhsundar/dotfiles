#!/bin/bash
export FZF_CTRL_T_OPTS="--height 80% --bind '?:toggle-preview' --preview '(highlight -O ansi -l {} 2> /dev/null || bat --style=numbers --color=always --line-range :500 {} || tree -C {}) 2> /dev/null | head -200'"
# cdf - cd into the directory of the selected file
cdfz() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

function man(){
	MAN="/usr/bin/man"
	if [ -n "$1" ]; then
		$MAN "$@"
		return $?
	else
		$MAN -k . | fzf --reverse --preview="echo {1,2} | sed 's/ (/./' | sed -E 's/\)\s*$//' | xargs $MAN" | awk '{print $1 "." $2}' | tr -d '()' | xargs -r $MAN
		return $?
	fi
}

function cppsymbol(){
  READELF="$(which readelf)"
  BASE_CMD="$READELF -sW "
	FILTER_CMD="awk '{print \$NF}'| c++filt"
	if [ -n "$2" ]; then
    echo "command to be run: $BASE_CMD $1 | $FILTER_CMD | grep $2"
		eval "$BASE_CMD $1 | $FILTER_CMD | grep $2"
    return $?
	else
    echo "command to be run: $BASE_CMD $1 | $FILTER_CMD | fzf"
		eval "$BASE_CMD $1 | $FILTER_CMD | fzf"
		return $?
	fi
}
