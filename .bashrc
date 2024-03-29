# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
# case $- in
#     *i*) ;;
#       *) return;;
# esac

# Source global definitions
if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

################################################################################
# Command History
################################################################################

# Add Date and Timestamp to Bash History
export HISTTIMEFORMAT='%F, %T '

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# Ignore specific commands
export HISTIGNORE="history:ls:pwd:clear:"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

################################################################################
# Prompt
################################################################################

# Fix terminal color, specially for vim
export TERM="xterm-256color"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PROMPT_DIRTRIM=2
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]pm@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[00;32m\]$(git_branch)\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

################################################################################
# Vi Mode
################################################################################
# set -o vi

################################################################################

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

################################################################################
# Aliases
################################################################################

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# enable color support of ls and also add handy aliases

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Dotfiles bare repository alias
alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

################################################################################
# Environment Variables
################################################################################
# Use ibus as input method for all programs
GTK_IM_MODULE=ibus
QT_IM_MODULE=ibus
XCOMPOSEFILE=$HOME/.XCompose
XMODIFIERS=@im=ibus

# enable GUI access to Ubuntu - for WLS2
# source: https://medium.com/@japheth.yates/the-complete-wsl2-gui-setup-2582828f4577
#export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
#export LIBGL_ALWAYS_INDIRECT=1

# load environment variables based on current directory
# requires direnv
if command -v direnv &> /dev/null; then
    eval "$(direnv hook bash)"
fi

################################################################################
# Local Bash Configurations (not synchronized to dotfiles)
################################################################################

# source the .bash_local file if exists
if [ -f $HOME/.bash_local ]; then
	source $HOME/.bash_local
fi

################################################################################
# Custom Tools
################################################################################

# Pyenv (manage multiple python versions)
export PYENV_ROOT="$HOME/opt/pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

################################################################################
# Custom Shell Functions
################################################################################

# Activate python virtual environment
# ve [no args]: try default venv paths
# ve [arg1]: source virtual environment in [arg1]
function ve() {
    default_venvs=(".venv" "venv" ".env" "env")
    if [ $# -eq 0 ]; then
        for vdir in "${default_venvs[@]}"; do
            if [ -d "$vdir" ]; then
                source $vdir/bin/activate
                return
            fi
        done
    elif [ "$1" = "iob" ]; then
        source $HOME/Documents/Work/.venv/bin/activate
    else
        source $1/bin/activate
    fi
}
export -f ve

git_branch() {
    git branch 2> /dev/null | grep "*" | sed -r 's/.* (.*)/(\1)/'
}
