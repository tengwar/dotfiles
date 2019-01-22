#!/bin/bash
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Stuff that shouldn't go on Github
private="$HOME/.bash_private"
if [ -s "$private" ]; then
	source "$private"
fi

if [ "$(uname -s)" == "Linux" ]; then
	export PS1='[\u@\h \W]\$ '

	export BROWSER=/usr/bin/firefox
	export EDITOR=/usr/bin/nvim

	# Close Steam Window, not just minimize it.
	export STEAM_FRAME_FORCE_CLOSE=1

	export PATH="$PATH:$HOME/.cargo/bin"
elif [ "$(uname -s)" == "Darwin" ]; then
	export PS1="\n$(tput setaf 2)\w$(tput sgr0)\n\u\$ "

	# Load completion scripts.
	# [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
	brew_prefix="$(brew --prefix)"
	if [ -f "$brew_prefix/etc/bash_completion" ]; then
		. "$brew_prefix/etc/bash_completion"
	fi

	# Add clang-tidy, clang-format, etc. to $PATH
	export PATH="$PATH:/usr/local/opt/llvm/bin"
fi


###  Useful aliases ###
alias wat='pwd && ls'
alias cd..='cd ..'
alias bc='bc -l'  # enable floats
alias ll='ls -alh'
alias lt='ls -halt --full-time'
alias rgr='rg --no-ignore-vcs'
alias reverse-dns="dig +noall +answer -x" # reverse DNS lookup (with most of the output cut out)
alias gs="git status"
alias gd="git diff"
alias gb="git branch"
alias gl="git log --oneline --all --graph --decorate"

alias sudo="sudo " # to allow executing "sudo <some alias>"
alias now="sudo "
alias fucking="sudo "

if [ "$(uname -s)" == "Linux" ]; then
	# Package management
	alias gimme="sudo yaourt -Sa "
	alias upd8="sudo yaourt -Syua"
	alias upgr="sudo yaourt -Syua"
	alias szukaj="yaourt -Ss "
	alias w00t="yaourt -Si " # or maybe "pacman -Qi"?
fi

# Enable human readable filesizes and colors.
if [ "$(uname -s)" == "Linux" ]; then
	alias ls='ls --color=auto -h'
elif [ "$(uname -s)" == "Darwin" ]; then
	alias ls='ls -h'
	# Enable coloring in ls.
	export CLICOLOR=1
fi
alias df='df -H'
alias du='du -ch'  # -c enables displaying a grand total size
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias pgrep='pgrep --color=auto'

# Safety first. (Use /bin/rm directly to avoid confirmations.)
alias rm='rm -i'
alias unlink='unlink -i'


### Useful functions ###
cs() {
	cd "$@" && ls
}

dsf() {
	git diff --no-index --color "$@" | diff-so-fancy;
}

gamekeys_on()
{
	MY_MSG="Keys unbound."
	xmodmap -e 'remove Control = Control_L' && xmodmap -e 'remove shift = Shift_L' && echo "$MY_MSG"
}

gamekeys_off()
{
	MY_MSG="Keys bound again."
	xmodmap -e 'add Control = Control_L' && xmodmap -e 'add shift = Shift_L' && echo "$MY_MSG"
}

update_vim_plugins() {  # Pathogen doesn't do that by itself.
	if ! curl -s --head  --request GET https://github.com | grep "200 OK" > /dev/null; then
		echo "Can't reach Github, exiting."
		exit 1
	fi
	for i in ~/.vim/bundle/*
	do
		echo "### Pulling $(basename "$i") ###"
		git -C "$i" pull
		git -C "$i" submodule update --init --recursive
		echo ""
	done

	# Recompile the binary parts of YouCompleteMe.
	if [ "$(uname -s)" == "Linux" ]; then
		completers="--rust-completer"
	elif [ "$(uname -s)" == "Darwin" ]; then
		completers="--clang-completer"
	fi
	read -r -p "Recompile YouCompleteMe? [y/N]: " rebuild
	case $rebuild in
		Y|y) echo ""
			echo "##### Building YouCompleteMe... #####"
			cd "$HOME/.vim/bundle/youcompleteme/" && ./install.py $completers || cd -
			cd -
			echo "##### Done building YouCompleteMe. #####"
			echo "";;
		N|n|"") echo " Ok, not building." ;;
		*) echo Expected Y, y, N or n. Not building. ;;
	esac
}


### Customizations ###

## Eternal bash history.
	# Undocumented feature which sets the size to "unlimited".
	# http://stackoverflow.com/questions/9457233/unlimited-bash-history
	export HISTFILESIZE=
	export HISTSIZE=
	export HISTTIMEFORMAT="[%F %T] "

	# Change the file location because certain bash sessions truncate .bash_history file upon close.
	# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
	# It seems to disable session restoring on OSX. :(
	#export HISTFILE=~/.bash_eternal_history

	# Force prompt to write history after every command.
	# http://superuser.com/questions/20900/bash-history-loss
	PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Don't save to history both commands beginning with space (ignorespace)
# and duplicate consecutive commands (ignoredups).
export HISTCONTROL=ignoreboth

# Don't save to history commands listed here.
export HISTIGNORE="ls:ll:cd:cd -:cd ..:cs:vim:nvim"

# In Bash Ctrl-R searches history backwards. Ctrl-S in turn searches the history forward.
# Bindings for XON/XOFF flow control conflict with Ctrl-S. Disable XON in interactive sessions.
[[ $- == *i* ]] && stty -ixon

# weryfikuj polecenia uzupełnione z historii
shopt -s histverify

#  autocompletion - e.g. complete -p sudo
complete -F _sudo now
complete -F _sudo fucking
####testing!#### - only for bashrc
#_gimme()
#{
#cur=`_get_cword`
#COMPREPLY=( $( apt-cache pkgnames $cur 2> /dev/null ) )
#return 0
#
#} &&
#complete -F _gimme $filenames gimme
################

# Force 256 colors in Gnome Shell Dropdown Terminal
if [ -n "$GJS_PATH" ]; then
	export TERM=xterm-256color
fi

# Powerline
if command -v powerline-daemon >/dev/null 2>&1; then
	powerline-daemon -q
	POWERLINE_BASH_CONTINUATION=1
	POWERLINE_BASH_SELECT=1
	. /usr/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh
fi

# vim: set noexpandtab ts=4 sw=4 sts=4:
