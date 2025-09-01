if [[ $- != *i* ]] ; then
	return
fi

# source /usr/share/bash-completion/completions/fzf
# source /usr/share/fzf/key-bindings.bash

alias ls="ls -a --color"
alias comp="make && doas make install && make clean && pkill dwm"
alias update_world="doas emerge --ask --update --newuse --deep @world"
alias env="sh /home/andrew/dotfiles/env.sh"
