
#### .zshenv - Set Environment Variables ####

# NOTE: Bootstrapped by "${HOME}/.zshenv" with the following contents:
#
# ```
# export XDG_CONFIG_HOME="${HOME}/.config"
# export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
#
# if [[ -f "${ZDOTDIR}/.zshenv" ]]; then
# 	source "${ZDOTDIR}/.zshenv"
# fi
# ```

### XDG Base Directory Specification ###
# See https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

### Editor ###
if type "nvim" > /dev/null; then
	export EDITOR=nvim
elif type "vim" > /dev/null; then
	export EDITOR=vim
else
	export EDITOR=vi
fi

### Golang ###
export GOPATH="${XDG_CONFIG_HOME}/go"
export GOMODCACHE="${XDG_CACHE_HOME}/go/mod"

### Other ###
export RIPGREP_CONFIG_HOME="${XDG_CONFIG_HOME}/ripgrep/config"

export WGETRC="${XDG_CONFIG_HOME}/wgetrc"

export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
