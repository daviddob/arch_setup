#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
export PS1="\[\033[1;32m\][\u@\h\W]\[\033[1;34m\]\$ \[\033[0m\]"
BROWSER=/usr/bin/google-chrome-stable
EDITOR=vim
ANDROID_HOME=/home/iceman/Android/Sdk
PATH=$ANDROID_HOME/platform-tools/:$ANDROID_HOME/tools/:$PATH
source ~/.bash_profile
