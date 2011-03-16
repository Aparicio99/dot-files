##### Options #####
export HISTFILE=~/.zhistory
export HISTSIZE=20000
export SAVEHIST=20000
export REPORTTIME=30
setopt autocd extendedglob correct nohup share_history hist_ignore_all_dups hist_ignore_space

##### External files #####
source /etc/profile
source $HOME/.alias-funcs
source $HOME/.pvt-alias

bindkey -e # Emacs mode

#source $HOME/.zkbd/$TERM-${DISPLAY:-$VENDOR-$OSTYPE}
source $HOME/.zkbd/$TERM
[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
[[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-history
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-history
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char

##### Modules #####
autoload zed # Line editor

autoload -U edit-command-line # Edit command in Vim
zle -N edit-command-line

autoload -U insert-files # On-the-fly file expansion
zle -N insert-files

autoload predict-on # Command prediction
zle -N predict-on
zle -N predict-off

autoload -U compinit # Completion
compinit

autoload colors
colors
eval $(dircolors)

##### Prompt #####
export RPROMTP=""

if [[ "$HOST" == "void" ]]; then
	COLOR="$(print '%{\033[38;5;208m%}')"
elif [[ "$HOST" == "null" ]]; then
	COLOR="%F{red}"
elif [[ "$HOST" == "nop" ]]; then
	COLOR="%F{green}"
fi

export PS1="%B$COLOR%m %B%F{blue}%1~ %(?.%F{green}%(!.=%).:%)).%F{red}%(!.=(.:())%f%b "

##### Bindings #####
#bindkey -M vicmd v edit-command-line # Esc v
bindkey '^V' edit-command-line # Ctrl+v
bindkey '^Xf' insert-files # Ctrl+x f
bindkey '^X^Z' predict-on # Ctrl+x+z
bindkey '^Z' predict-off # Ctrl+z
bindkey '^F' spell-word # Ctrl+f - Spell correction
bindkey '^H' run-help # Ctrl+h - Command help

##### Completion #####

# Completion caching
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path .zcache
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Completion Options
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate
zstyle ':completion:*' max-errors 1 numeric

# Path Expansion
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

# Completion menu
zstyle ':completion:*:*:*:default' menu select=3
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31' 

# Group matches and Describe
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
zstyle ':completion:*:processes' command 'ps -au$USER'
#zstyle ':completion:*:*:(pdf|zathura|epdfview|xpdf):*' file-patterns '*.pdf'

# Command argument completion

function complete_pk() {
	if (( CURRENT == 2 )); then
		_values 'algorithm' \
		'tbz[tar bzip2]' 'tgz[tar gzip]' 'tar[tar]' 'bz2[bzip2]' \
		'lzma[lzma]' 'gz[gzip]' 'zip[zip]' '7z[7zip]' 'lzo[lzo]'
	else
		_files
	fi
}

function complete_base() {
	num=('2[binary]' '8[octal]' '10[decimal]' '16[hexadecimal]')
	case $CURRENT in
		2) _values 'input base' "$num[@]" ;;
		3) _values 'output base' "$num[@]" ;;
	esac
}

function complete_freq() {
	_values 'available frequencies' $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies \
		| sed "s/^/{/" | sed "s/$/} \/ 1000/" | ised)
}

compdef complete_pk pk
compdef complete_base base
compdef complete_freq freq
compdef pkill=killall
compdef _services start stop restart toggle
compdef _pdf pdf zathura epdfview
compdef '_values options on off toggle' mouse
compdef '_files -g "*.aes"' dec
compdef '_files -g "*.(doc|DOC|rtf|RTF|docx|odt|abw)"' abiword oowriter
compdef '_files -g "*.(bz2|gz|rar|tar|tbz2|tgz|zip|Z|7z|lzma|lzo)"' extract
compdef '_files -F "*.o"' vim
