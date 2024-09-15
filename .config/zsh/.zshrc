# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation.
export ZSH="${ZDOTDIR}/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

bindkey -v

HISTFILE="${ZDOTDIR}/.zsh_history"
# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time
autoload -Uz compinit
compinit

# TODO: dive into autocompletion. Look at built-in but possibly
# look into https://github.com/marlonrichert/zsh-autocomplete
plugins=(
	git
	zsh-syntax-highlighting
	zsh-autosuggestions
	zsh-vi-mode
	# zsh-history-substring-search
)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
