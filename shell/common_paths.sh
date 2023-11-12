export PATH=$PATH:$HOME/.bin
# export MANPAGER="vim -M +MANPAGER -"
export MANPAGER=less

if command -v nvim &> /dev/null
then
  export EDITOR="nvim"
  export VISUAL="nvim"
  export GIT_EDITOR="nvim"
else
  export EDITOR="vim"
  export VISUAL="vim"
  export GIT_EDITOR="vim"
fi
# export MANPATH=$MANPATH:$HOME/.man
