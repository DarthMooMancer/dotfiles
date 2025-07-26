if [[ $- != *i* ]] ; then
	return
fi

alias ls="ls -a --color"
alias comp="make && doas make install"
alias edit="sh /home/andrew/.config/suckless/dwm/scripts/edit-suckless.sh"
alias update_world="doas emerge --ask --update --newuse --deep @world"
alias env="sh /home/andrew/dotfiles/env.sh"
