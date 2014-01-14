DOTFILES = $(PWD)
all:: vim emacs bin zsh bash tmux xmonad xorg gtk mpv conkeror

vim::
	@ln -fs $(DOTFILES)/vim/vimrc					${HOME}/.vimrc
	@ln -fns $(DOTFILES)/vim							${HOME}/.vim
	@echo Vim is symlinked.

emacs::
	@ln -fs $(DOTFILES)/emacs/emacs.el		${HOME}/.emacs
	@ln -fns $(DOTFILES)/emacs						${HOME}/.emacs.d
	@echo Emacs is symlinked.

bin::
	@ln -fns $(DOTFILES)/bin							${HOME}/bin
	@echo bin files are linked to homedir.

zsh::
	@ln -fs $(DOTFILES)/zsh/zshrc					${HOME}/.zshrc
	@ln -fs $(DOTFILES)/zsh/zshalias			${HOME}/.zshalias
	@ln -fs $(DOTFILES)/zsh/zshenv				${HOME}/.zshenv
	@ln -fns $(DOTFILES)/zsh/oh-my-zsh		${HOME}/.oh-my-zsh
	@echo ZSH is symlinked.

bash::
	@ln -fs $(DOTFILES)/bash/bash_profile	${HOME}/.bash_profile
	@ln -fs $(DOTFILES)/bash/bashrc	${HOME}/.bashrc
	@echo Bash is symlinked.

fish::
	@ln -fns $(DOTFILES)/fish							${HOME}/.config/fish
	@echo Fish is symlinked.

tmux::
	@ln -fs $(DOTFILES)/tmux/tmux.conf 		${HOME}/.tmux.conf
	@echo tmux is symlinked.

i3::
	@mkdir -p															${HOME}/.i3
	@ln -fs $(DOTFILES)/i3/config					${HOME}/.i3/config
	@ln -fs $(DOTFILES)/i3/i3status.conf  ${HOME}/.i3status.conf
	@echo i3 is symlinked

xmonad::
	@mkdir -p															${HOME}/.xmonad
	@ln -fs $(DOTFILES)/xmonad/xmobarrc		${HOME}/.xmobarrc
	@ln -fns $(DOTFILES)/xmonad/xmonad.hs ${HOME}/.xmonad/xmonad.hs
	@echo XMonad is symlinked.

xorg::
	@ln -fs $(DOTFILES)/xorg/Xdefaults		${HOME}/.Xdefaults
	@ln -fs $(DOTFILES)/xorg/Xresources		${HOME}/.Xresources
	@ln -fs $(DOTFILES)/xorg/xinitrc		  ${HOME}/.xinitrc
	@ln -fs $(DOTFILES)/xorg/urxvt-perls  ${HOME}/.urxvt-perls
	@ln -fns $(DOTFILES)/xorg/fonts.conf	${HOME}/.fonts.conf
	@echo Xorg is symlinked.

gtk::  
	@ln -fs $(DOTFILES)/gtk/gtkrc-2.0 		${HOME}/.gtkrc-2.0
	@ln -fs $(DOTFILES)/gtk/gtkrc.mine 		${HOME}/.gtkrc.mine
	@ln -fns $(DOTFILES)/gtk/themes 		  ${HOME}/.themes
	@echo GTK is symlinked.

mpv::
	@mkdir -p ${HOME}/.mpv
	@ln -fns $(DOTFILES)/mpv/config 			${HOME}/.mpv/config
	@echo MPV is symlinked.

conkeror::
	@ln -fs $(DOTFILES)/conkeror/conkerorrc.js ${HOME}/.conkerorrc
	@echo Conkeror is symlinked.
