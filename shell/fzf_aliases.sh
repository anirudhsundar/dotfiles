#!/bin/bash
export FZF_CTRL_T_OPTS="--height 80% --bind '?:toggle-preview' --preview '(highlight -O ansi -l {} 2> /dev/null || bat --style=numbers --color=always --line-range :500 {} || tree -C {}) 2> /dev/null | head -200'"
# cdf - cd into the directory of the selected file
cdfz() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}
