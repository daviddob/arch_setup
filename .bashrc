#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
BROWSER=/usr/bin/google-chrome-stable
EDITOR=vim
PATH=/opt/android-sdk/tools/:$PATH
ANDROID_HOME=/opt/android-sdk/
source ~/.bash_profile
