# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Include git completion bashrc fragments
source ~/.git-completion

# Setup file creation permissions default as 644
umask=006

##################################################
# Ansible Environment Vars
export ANSIBLE_VAULT_PASSWORD_FILE=~/.vault_pass.txt
##################################################

##################################################
# General Unix-y environment setup
export EDITOR=vi
export MANPATH=/usr/man:/usr/local/man
export MPAGE='-b letter'
export MANPATH=/usr/share/man
##################################################

# append to the history file, don't overwrite it
shopt -s histappend

#################################################
# Path control
export PATH=/bin:/usr/bin:/usr/X11R6/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/bin/mh
#################################################

#################################################
# Mess with tab completion
# Tab completion to only show directories when using cd
complete -d cd

# Don't show files ending in ~ using tab completion (.o:~ would do .o's too).
export FIGNORE=\~
#################################################

####################################################
# Control "history" command behavior
# If I run same command back to back don't put in history
export HISTCONTROL=ignoredups

# in memory readline history size (default is 500)
export HISTSIZE=5000

# disk backed readline history size (default is 500)
export HISTFILESIZE=5000
####################################################

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

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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
    PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias h='history'
alias which='type -path'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

####################################################
# Utility functions

# Purpose: Convert a Unix time_t to a human readable date
#        e.g.: x 1234567890.0 returns: 2009-02-13 18:31:30
# Usage  : x TIME_T value
function x () {
   date -d"1970-01-01 UTC $1 seconds" +"%Y-%m-%d %H:%M:%S";
}

# Purpose: Show all process running as you
# Usage  : z
function z () {
   pstree -ap $USER
}

# Purpose: Function to do a ps with a search
# Usage  : pss SOMESTRING
function pss () {
    ps -aefl | grep "$1"
}

# Purpose: Function to do a filename search
# Usage  : ff FILENAMEPATTERN
function ff () {
    find . -name "$1" -print
}

# Purpose: Function to find files and perform a search
# Usage  : ffs FILENAMEPATTERN SOMESTRING
function ffs () {
    ff "$1" | xargs grep "$2"
}

# Purpose: Function to find .py files in the current directory and search for a string in them
# Usage  : fpy SOMESTRING
function fpy () {
    ffs '*.py' "$1"
}

# Purpose: Function to find files and perform a search case insensitively
# Usage  : ffs FILENAMEPATTERN SOMESTRING
function ffsi () {
    ff "$1" | xargs grep -i "$2"
}

# Purpose: Function to find .sql files in the current directory and search for a string in them
# Usage  : fsql SOMESTRING
function fsql () {
    ffs '*.sql' "$1"
}

# Purpose: Function to find .xml files in the current directory and search for a string in them
# Usage  : fxml SOMESTRING
function fxml () {
    ffs '*.xml' "$1"
}

# Purpose: Function to find .yml or .yaml files in the current directory and search for a string in them
# Usage  : fyml SOMESTRING
function fyml () {
    ffs '*.y*ml' "$1"
}

# Purpose: Function to find .js files in the current directory and search for a string in them
# Usage  : fjs SOMESTRING
function fjs () {
    ffs '*.js' "$1"
}

# Purpose: Function to find .css files in the current directory and search for a string in them
# Usage  : fcss SOMESTRING
function fcss () {
    ffs '*.css' "$1"
}

# Purpose: Function to find all .pyc files and remove them
# Usage  : rmpyc 
function rmpyc () {
    ff '*.pyc' | xargs rm
}

####################################################


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/abonaparte/.sdkman"
[[ -s "/home/abonaparte/.sdkman/bin/sdkman-init.sh" ]] && source "/home/abonaparte/.sdkman/bin/sdkman-init.sh"
