#!/usr/bin/bash

# Get current dir (so run this script from anywhere)

export DOTFILES_DIR
DOTFILES_DIR="$( builtin cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Update dotfiles itself first

[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" \
--git-dir="$DOTFILES_DIR/.git" pull origin master

# Package managers & packages

. "$DOTFILES_DIR/packages/apt.sh"
. "$DOTFILES_DIR/packages/npm.sh"
. "$DOTFILES_DIR/packages/gems.sh"
. "$DOTFILES_DIR/packages/apm.sh"

# Settings

. "$DOTFILES_DIR/settings.sh"

# Dotfiles to symlink

dotfiles=(
  ".atom"
  ".bashrc"
  ".bash_aliases"
  ".vimrc"
  ".tmux.conf"
  ".gitconfig"
)

# Make the symlinks

for dotfile in ${dotfiles[@]}; do
  ln -sfv "$DOTFILES_DIR/dotfiles/$dotfile" ~
done

# More symlinks

sudo ln -sf "$(which nodejs)" /usr/bin/node
