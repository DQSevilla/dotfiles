#### .zshenv - Bootstrap XDG Config for Zsh ####

export XDG_CONFIG_HOME="${HOME}/.config"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

if [[ -f "${ZDOTDIR}/.zshenv" ]]; then
	source "${ZDOTDIR}/.zshenv"
fi
