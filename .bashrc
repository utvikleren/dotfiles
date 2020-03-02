# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# function to get the prefix of the git branch (up to the slash) for inclusion in the prompt
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /' -e 's/(\(.*\)\/.*)/(\1)/'
}
# define a prompt assuming that colors work: git branch prefix, user@host, and basename of working directory
PS1="\[\033[01;33m\]\$(parse_git_branch)\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[34m\]\W \[\033[00m\]\$ "

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# mount google drive (if unmounted)
if [ ! -f ~/google-drive/Database.kdbx ]; then
	echo "Mounting google-drive"
	google-drive-ocamlfuse ~/google-drive
fi

export dev_instance_id="i-039a1abb1da29b81f"
export nh_rc="RC-1.7.0"
export oh_rc="RC-1.8.0"
export ws_rc="RC-2.4.0"

export GOPATH="/home/msteen/personal/go"

export PATH="$PATH:$GOPATH/bin"
# old path:
# declare -x PATH="/home/msteen/.local/bin:/home/msteen/personal/go/bin:/snap/bin:/home/msteen/personal/go/bin:/snap/bin:/home/msteen/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"


# external files

# inputrc
if [ -f ~/.inputrc ]; then
    . ~/.inputrc
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
