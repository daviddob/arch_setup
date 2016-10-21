#
# ~/.bash_profile
#

#[[ -f ~/.bashrc ]] && . ~/.bashrc
source /usr/lib/z.sh

alias l='ls'
alias ll='ls -la'
alias la='ls -a'
alias rm='rm -i'
alias mv='mv -i'
alias du='du -h'
alias cd..='cd ..'
alias mkdir='mkdir -pv'
alias h='history'
alias j='jobs -l'
alias psme='ps aux | grep daviddob'
alias nocomment='grep -Ev '\''^(#|$)'\'''
alias back='cd -'
alias topme='top -u iceman'
alias ..='cd ..'
alias cls='clear'
alias pacman='sudo pacman'
alias reboot='sudo reboot'
alias shutdown='sudo shutdown now'
