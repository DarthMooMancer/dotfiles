if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

export PATH="/usr/lib/llvm/20/bin:$PATH"

alias ls="ls -a --color"
alias comp="sudo rm -rf config.h && make && sudo make install && pkill dwm"
alias edit="sh /home/andrew/.config/suckless/dwm/scripts/edit-suckless.sh"
alias update_world="sudo emerge --ask --update --newuse --deep @world"
