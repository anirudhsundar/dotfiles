## Personal setup

This is a personal repo to setup my dotfiles across different machines.

I'm using [**dotbot**](https://github.com/anishathalye/dotbot) to install the dotfiles.

### Installation

Just clone the repository and run `./install` inside the dotfiles directory to setup the dotfiles. If you have [powerline](https://github.com/powerline/fonts) installed and would like to use a fancier setup, clone the `powerline_supported` branch of this repo and then run the `./install` command inside that.

> Note: `dotbot` requires python and bash to be available. see [dotbot](https://github.com/anishathalye/dotbot) for more info


#### Some info about the different tools/plugins installed by this repo

**Vim**

 vimrc uses [vim-plug](https://github.com/junegunn/vim-plug) to setup the plugins
 - [coc.nvim](https://github.com/neoclide/coc.nvim) is used for autocompletion
> Note: some of the plugins used in vimrc requires >= vim8 to work properly

**Shell**

There are some very minimal settings for cshrc, but it switches to `zshrc` or `bashrc` in that order if either are available

Automatically installs the following shell tools
 - [fzf](https://github.com/junegunn/fzf)
 - [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
 - [forgit](https://github.com/wfxr/forgit)
 - [node](https://nodejs.org/en/)
 - [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh) if `zsh` is available
 - [tpm](https://github.com/tmux-plugins/tpm) if `tmux` is available
