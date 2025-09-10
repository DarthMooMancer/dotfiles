#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

DOTFILES_HOME="/home/andrew/personal/dotfiles/"
DOTFILES_CONFIG="${DOTFILES_HOME}.config/"
DOTFILES_LOCAL="${DOTFILES_HOME}.local/"

PERSONAL_HOME="/home/andrew/"
CONFIG="${PERSONAL_HOME}.config/"
LOCAL="${PERSONAL_HOME}.local/"

ORIGINAL_DOTS=(
	"${DOTFILES_CONFIG}suckless/"
	"${DOTFILES_CONFIG}nvim/"
	"${DOTFILES_CONFIG}dunst/"
	"${DOTFILES_CONFIG}picom.conf"
	"${DOTFILES_LOCAL}bin/"
	"${DOTFILES_LOCAL}share/fonts/"
	"${DOTFILES_HOME}.xinitrc"
	"${DOTFILES_HOME}.bashrc"
) 
COPY_DOTS=(
	"${CONFIG}suckless/"
	"${CONFIG}nvim/"
	"${CONFIG}dunst/"
	"${CONFIG}picom.conf"
	"${LOCAL}bin/"
	"${LOCAL}share/fonts/"
	"${PERSONAL_HOME}.xinitrc"
	"${PERSONAL_HOME}.bashrc"
)

for x in "${!ORIGINAL_DOTS[@]}"; do
	src="${ORIGINAL_DOTS[$x]}"
	dst="${COPY_DOTS[$x]}"

	if [[ -d "$src" ]]; then
		echo -e "Syncing directory: ${GREEN}${src}${RESET} -> ${YELLOW}${dst}${RESET}"
		rsync -avh --delete "$src" "$dst"
	elif [[ -f "$src" ]]; then
		echo -e "Syncing file: ${GREEN}${src}${RESET} -> ${YELLOW}${dst}${RESET}"
		rsync -avh "$src" "$dst"
	else
		echo -e "${RED}Missing: ${src}${RESET}"
	fi
done

echo -e "${GREEN}Rebuilding Suckless Software${RESET}"
for x in "${CONFIG}suckless"/*/; do
	[[ -d "${x}" ]] || continue
	cd "${x}" && make && doas make install && make clean && pkill dwm
done

echo -e "${GREEN}Re-caching fonts${RESET}"
fc-cache -f
