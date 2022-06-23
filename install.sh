#!/usr/bin/env bash

rm -rf ~/.config/nvim/

mkdir -p ~/.config/nvim/plugin/lsp
mkdir -p ~/.config/nvim/after/plugin/lsp
mkdir -p ~/.config/nvim/lua 

rm -rf $HOME/.config/nvim/lua/turts

#remake the dirs
mkdir -p $HOME/.config/nvim/lua/turts

for f in `find . -regex ".*\.vim$\|.*\.lua$" | sed 's|^./||'`; do
	echo "Removing: $f"
	rm -rf $HOME/.config/$f
	echo "Linking $f"
	ln -s $PWD/$f $HOME/.config/nvim/$f
done
