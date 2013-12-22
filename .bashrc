# .bashrc
# 28-feb-2006
#

# Shell is non-interactive?
[[ $- != *i* ]] && return

red='\e[0;31m'
RED='\e[1;31m'
blue='\e[0;34m'
BLUE='\e[1;34m'
cyan='\e[0;36m'
CYAN='\e[1;36m'
NC='\e[0m'

# Personal aliases
alias path='echo -e ${PATH//:/\\n}'
alias df='df -kTh'
alias du='du -kh'
alias ls="ls -F -h --color=auto"
alias cp='cp -v'
alias mv='mv -v'
alias vi='vim'
alias xterm="xterm -bg black -fg gray -fs 11 -fa vera -geometry 80x50"

# enable color grep if color is supported
( echo chk | grep --color=auto chk &> /dev/null ) && export GREP_OPTIONS="--color=auto"

# uncomment for single line prompt
#export PS1="\\u@\\H:\\w\\076"
export PS1=$'\\[\\033m\\033[32m\\]\\u@\\h \\[\\033[33m\\w\\033[0m\\]\n$ '
# Make root prompt to be red
[ "$HOME" == "/root" ] && export PS1=$'\\[\\033m\\033[31m\\]\\u@\\h \\[\\033[33m\\w\\033[0m\\]\n# '
export PS2='> '

# Source CD history code
source acd_func.sh

# Arrow-up/-down search history based on a mask, one entry at a time
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward
bind Space:magic-space

# alt+r -- search history based on a mask (augments Arrow up):
# method 1
#cmd_mhist="\"\C-k\C-ahistory | grep '^ *[0-9]* *\C-e.'\C-m\""
# method 2
cmd_mhist="\"\C-k\C-uhistory | grep \\\"^ *[0-9]* *\C-y\\\" \C-m\""
bind '"\M-r"':"$cmd_mhist"

# alt+k -- paste current command line into history and begin new line
cmd_hist="\"\C-ahistory -s '\C-e'\C-m\""
bind '"\M-k"':"$cmd_hist"

# ctrl+xPgUp: show last 25 entries of the history
# (erase the line first)
bind '"\C-x\e[5~"':"\"\C-k\C-uhistory | tail -25\C-m\""

# ctrl+t -- new terminal
bind '"\C-t"':"\"\C-a\C-kxterm&\C-m\""

# Now map xterm's alternative keybindings to existing functionality
# Some are simple translations to correspontend M- combinations
# ctrl+left/right arrows:
bind '"\e\x5b\x31\x3b\x35\x44"':backward-word
bind '"\e\x5b\x31\x3b\x35\x43"':forward-word
# alt+b/f: the usual word navigation but in xterm terms
bind '"\xe2"':backward-word
bind '"\xe6"':forward-word
# atl+backspace:
bind '"\xff"':backward-kill-word
# alt+'.':
bind '"\xae"':yank-last-arg
# alt+k:
bind '"\xeb"':"$cmd_hist"
# alt+r:
bind '"\xf2"':"$cmd_mhist"

unset cmd_hist cmd_mhist

# Don't use ^D to exit
set -o ignoreeof

# Don't put duplicate lines in the history.
export HISTCONTROL=ignoredups

# Don't put 'history' commands themselves in the history
export HISTIGNORE='history*'

# Kepp no more than 1000 lines
export HISTFILESIZE=1000
export HISTSIZE=1000

# Append, don't overwrite history
shopt -s histappend

# Check window size after each command to avoid annoying effects of resizing
shopt -s checkwinsize

# Write history before accepting a new command
# Then read back the merged list
export PROMPT_COMMAND='_xtitle; history -a; history -c; history -r'

# Show directories bold, everything else is normal
export LS_COLORS="no=00:fi=00:di=01:ln=00:pi=00:so=00:bd=00:cd=00:or=00:ex=00"

# disable XON/XOFF flow control (^s/^q)
stty -ixon

# This is more objective than the builtin $SHLVL
if [[ -z $BASH_NEST ]]; then
  export BASH_NEST=0
else
  (( BASH_NEST++ ))
fi

# print
echo -e "${cyan}This is BASH ${red}${BASH_VERSION%.*}${cyan}"\
  "- DISPLAY on ${red}$DISPLAY${cyan} - nest level ${red}${BASH_NEST}${NC}"

# Activate bash_completions if appropriate
bash=${BASH_VERSION%.*}; bmajor=${bash%.*}; bminor=${bash#*.}
if [ "$PS1" ] && [ $bmajor -eq 2 ] && [ $bminor '>' 04 ] \
   && [ -f /etc/bash_completion ]; then # interactive shell
       # Source completion code
       . /etc/bash_completion
fi
unset bash bmajor bminor

# _xtitle: sets title
# no arguments (and no $MANUAL_TITLE) sets the title to current dir
function _xtitle ()
{
  a="$1"
  if [[ -n $MANUAL_TITLE ]]; then
    a="$MANUAL_TITLE"
  else
    # auto is current directory, replace $HOME with ~
    [[ -z $a ]] && a="${PWD/$HOME/~}"
  fi
  case "$TERM" in
    *term | rxvt | cygwin)
      echo -n -e "\033]0;$a\007" ;;
    screen)
      # add [screen] to the window title & change term name in screen's list
      echo -n -e "\033]0;$a[screen]\007"
      echo -n -e "\033k$a\033\134"
      ;;
    *)
      ;;
  esac
}


# by default no manual title block
unset MANUAL_TITLE

# xtitle: for manual set of title, this block _xtitle from
# doing auto set
# call with no parameters to reset to auto
function xtitle()
{
  a="$1"
  if [[ -z "$a" ]]; then
    unset MANUAL_TITLE
  else
    MANUAL_TITLE="$a"
    _xtitle
  fi
}

# changes window title to the command that is executed
# could be used as a wrap for execution of any command
function title_cmd()
{
  s=$MANUAL_TITLE
  unset MANUAL_TITLE
  xtitle "$*"
  $*
  MANUAL_TITLE=$s
}

# for programs that involve user interaction (like doc browsing)
# or take longer time (like compilations) it is good to
# supply a more informative title
# ADD here commands for which you wish to supply better title
alias pinfo="title_cmd pinfo"
alias info="title_cmd info"
alias man="title_cmd man"
alias make="title_cmd make"
alias less="title_cmd less"
alias more="title_cmd more"
alias find="title_cmd find"
alias ping="title_cmd ping"
alias vim="title_cmd vim"
# notice that vi becomes vim
alias vi="title_cmd vim"
alias ftp="title_cmd ftp"
alias ncftp="title_cmd ncftp"
alias wget="title_cmd wget"

# path_once: Adds a new path to $PATH, moves it to the end if it already
# exists
function path_once()
{
  [ -z "$1" ] && return
  pa="$PATH:"        # add end marker (one ':')
  pa="${pa//$1:/}"   # remove any occurrance of $1:
  pa="${pa//::/:}"   # remove any empty entry, replace :: with :
  PATH="$pa$1"       # add $1 at the end (we already have the delimiter)
}

# show a fortune
function fo()
{
wget -q -O -  "http://anduin.eldar.org/cgi-bin/fortune.pl?max_lines=2&text_format=yes"
}

# continue with other settings
if [ -f ~/.bashrc2 ]; then . ~/.bashrc2; fi

# the content of this file is public domain
# for updates: http://geocities.com/h2428/petar/bashrc.htm

