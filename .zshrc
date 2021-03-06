# Disable ctrl-s and ctrl-q.
stty -ixon

setopt autocd autopushd \

# Enable colors and change prompt
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}#%b "

# History in cache directory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/shhistory

# Basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)	# Include hidden files

# Enable vi mode
bindkey -v
export KEYTIMEOUT=1
# Vim bindings in tab mode
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
# Vim Cursor shape
function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] ||
		[[ $1 = 'block' ]]; then
	   	echo -ne '\e[1 q'
	elif [[ ${KEYMAP} == main ]] ||
		[[ ${KEYMAP} == viins ]] ||
		[[ ${KEYMAP} == '' ]]; then
		echo -ne '\e[5 q'
	fi
}
zle -N zle-keymap-select
zle-line-init() {
	zle -K viins
	echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q' ;}

# starts one or multiple args in background
background() {
for ((i=2;i<=$#;i++)); do
${@[1]} ${@[$i]} &> /dev/null &|
done
}

source $HOME/.config/zsh/suffixaliasrc 2>/dev/null # Load suffix aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc" # Load aliases

source $HOME/.profile 2>/dev/null # Load .profile

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

if [[ -n "$PS1" ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_CONNECTION" ]]; then
	tmux attach-session -t $USER || tmux new-session -s $USER
fi

pfetch
