# To the extent possible under law, the author(s) have dedicated all 
# copyright and related and neighboring rights to this software to the 
# public domain worldwide. This software is distributed without any warranty. 
# You should have received a copy of the CC0 Public Domain Dedication along 
# with this software. 
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>. 

# base-files version 4.2-3

# ~/.bashrc: executed by bash(1) for interactive shells.

# The latest version as installed by the Cygwin Setup program can
# always be found at /etc/defaults/etc/skel/.bashrc

# Modifying /etc/skel/.bashrc directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bashrc) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .bashrc file

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# Shell Options
#
# See man bash for more options...
#
# Don't wait for job termination notification
# set -o notify
#
# Don't use ^D to exit
# set -o ignoreeof
#
# Use case-insensitive filename globbing
# shopt -s nocaseglob
#
# Make bash append rather than overwrite the history on disk
# shopt -s histappend
#
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
# shopt -s cdspell

# Completion options
#
# These completion tuning parameters change the default behavior of bash_completion:
#
# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1
#
# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1
#
# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1
#
# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
# [[ -f /etc/bash_completion ]] && . /etc/bash_completion

# History Options
#
# Don't put duplicate lines in the history.
# export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
 export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
 export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
#
# Whenever displaying the prompt, write the previous line to disk
 export PROMPT_COMMAND="history -a"

# Aliases
#
# Some people use a different file for aliases
 if [ -f "${HOME}/.bash_aliases" ]; then
   source "${HOME}/.bash_aliases"
 fi

# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.
#
# Interactive operation...
 alias rm='rm -i'
 alias cp='cp -i'
 alias mv='mv -i'
#
# Default to human readable figures
 alias df='df -h'
 alias du='du -h'
#
# Misc :)
 alias less='less -r'                          # raw control characters
 alias whence='type -a'                        # where, of a sort
 alias grep='grep --color'                     # show differences in colour
 alias egrep='egrep --color=auto'              # show differences in colour
 alias fgrep='fgrep --color=auto'              # show differences in colour
#
# Some shortcuts for different directory listings
 alias dir='ls --color=auto --format=vertical'
 alias vdir='ls --color=auto --format=long'
 alias ll='ls -l'                              # long list
 alias la='ls -A'                              # all but . and ..
 alias l='ls -CF'                              #

# Umask
#
# /etc/profile sets 022, removing write perms to group + others.
# Set a more restrictive umask: i.e. no exec perms for others:
# umask 027
# Paranoid: neither group nor others have any perms:
# umask 077

# Functions
#
# Some people use a different file for functions
 if [ -f "${HOME}/.bash_functions" ]; then
   source "${HOME}/.bash_functions"
 fi
#
# Some example functions:
#
# a) function settitle
 settitle () 
 { 
   echo -ne "\e]2;$@\a\e]1;$@\a"; 
 }
# 
# b) function cd_func
# This function defines a 'cd' replacement function capable of keeping, 
# displaying and accessing history of visited directories, up to 10 entries.
# To use it, uncomment it, source this file and try 'cd --'.
# acd_func 1.0.5, 10-nov-2004
# Petar Marinov, http:/geocities.com/h2428, this is public domain
 cd_func ()
 {
   local x2 the_new_dir adir index
   local -i cnt
 
   if [[ $1 ==  "--" ]]; then
     dirs -v
     return 0
   fi
 
   the_new_dir=$1
   [[ -z $1 ]] && the_new_dir=$HOME
 
   if [[ ${the_new_dir:0:1} == '-' ]]; then
     #
     # Extract dir N from dirs
     index=${the_new_dir:1}
     [[ -z $index ]] && index=1
     adir=$(dirs +$index)
     [[ -z $adir ]] && return 1
     the_new_dir=$adir
   fi
 
   #
   # '~' has to be substituted by ${HOME}
   [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"
 
   #
   # Now change to the new dir and add to the top of the stack
   pushd "${the_new_dir}" > /dev/null
   [[ $? -ne 0 ]] && return 1
   the_new_dir=$(pwd)
 
   #
   # Trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null
 
   #
   # Remove any other occurence of this dir, skipping the top of the stack
   for ((cnt=1; cnt <= 10; cnt++)); do
     x2=$(dirs +${cnt} 2>/dev/null)
     [[ $? -ne 0 ]] && return 0
     [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
     if [[ "${x2}" == "${the_new_dir}" ]]; then
       popd -n +$cnt 2>/dev/null 1>/dev/null
       cnt=cnt-1
     fi
   done
 
   return 0
 }
 
 alias cd=cd_func

#================
# WHERE MINE STARTS
#================


#---------------
# Terminal Title
#---------------
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
MANDWCPAZ7763=148.181.22.149
alias clear='printf "\033c"'
#------------------
# Colored man pages
#------------------
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#-------------------
# 10k not blown away
#-------------------
export HISTFILESIZE=20000
export HISTSIZE=10000
shopt -s histappend
# Combine multiline commands into one in history
shopt -s cmdhist
# Ignore duplicates, ls without options and builtin commands
HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit"

export DISPLAY=:0
_mintvm="148.181.22.95"
_cdn="148.181.103.217"
_cdn2="148.181.104.252"
_cdn2root="148.181.104.252"
_adare="adare"
_sxdev64="148.181.103.144"
_csi="148.181.104.251"
_malt="148.181.104.223"

#========
# Folders
#========

#-------------
# SMSC Project
#-------------
alias smsc="cd /home/cpaz/workspace/SMSC/trunk"
alias motif="gnome-open motif_programmers_ref.pdf"

#-----------------------
# Edit and Source bashrc
#-----------------------
alias brc='. ~/.bashrc'

alias bashrc='np $HOME/.bashrc; brc'

#---------------
# Access Profile
#---------------
alias profile='vim ~/.profile; source ~/.profile'

#----------------
# Handy Shortcuts
#----------------
alias a="alias|grepc "	# Search on ~/.bashrc aliases
alias b="dog ~/.bashrc|grepc " # Same as above, but with comments :D
alias h="history|grepc "	# Search command line history
alias f="find . |grepc " # Search files in current dir and subdir
alias o="gnome-open "	# Open like double-clicking
alias n="nemo"
alias ff="find / -type f -name" # From root (e.g. ff *.png)
alias f.="find . -type f -name" # From current (e.g. f. *.png)
alias dirs='ls -d */' 		# Dirs in current (e.g. dirs)
alias ..="cd .."
alias p="ps aux |grepc " # Search Running Processes
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e" 		# Search Processes
alias ldr="sudo du -h / | grep '^\s*[0-9\.]\+G' 2>/dev/null"	# List all file' sizes

#========================
# Shell Color and details
#========================

# Ticking shell
alias tshell="PS1='\[\033[01;37m\]\$? \$(if [[ \$? == 0 ]]; then echo \"\[\033[01;32m\]\342\234\223\"; else echo \"\[\033[01;31m\]\342\234\227\"; fi) $(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;32m\]\u@\h'; fi)\[\033[01;34m\] \w \$\[\033[00m\] '"

# SSH and Shell level details
alias sshell="PS1='\n\[\e[1;32m\][$$:$PPID - \j:\!\[\e[1;32m\]]\[\e[0;36m\] \t \[\e[1;30m\][\[\e[1;34m\]\u@\H\[\e[1;30m\]:\[\e[0;37m\]${SSH_TTY:-o} \[\e[0;32m\]+${SHLVL}\[\e[1;30m\]] \[\e[1;37m\]\w\[\e[0;37m\] \n\$ '"

# Normal Shell
alias nshell="PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '"

#---------------
# Gnome-terminal
#---------------
alias gt='gnome-terminal'

#--------------------
# Extracts IP address
#--------------------
alias ip=" ipconfig | grep -i 'IPv4 Address'  | cut -b40- | grep '148.*'"
alias vbip=" ipconfig | grep -i 'IPv4 Address'  | cut -b40- | grep '192.*'"

#---------------
# Remote Servers
#---------------
alias adare7="ssh -X -t adare '. ~/.profile && PS1="\H" && . ~/.bashrc && . ~/sh/loadview7.sh && . /net/sun4/public/env/.env.sh && . /view/prepaid-7.0.0.1dev/vobs/tools/make/set_env'"
alias adare="ssh -X -t adare '. ~/.profile && PS1="\H" && . ~/.bashrc && . ~/sh/loadview.sh && . /net/sun4/public/env/.env.sh && . /view/prepaid-linux-dev/vobs/tools/make/set_env'"

 #------------------------------
# Remote Files with Local Tools
#------------------------------
# hosts are defined in "~/.ssh/config"
alias Adare="nemo ssh://adare/home/alan"
alias Debitadmin="nemo ssh://adare/view/prepaid-linux-dev/vobs/prepaid/oam/src/debitadmin"
alias Prepaid="nemo ssh://adare/view/prepaid-linux-dev/vobs/prepaid"

alias Sxdev="nemo ssh://sxdev64/home/alan"
alias Windows="nemo smb://$MANDWCPAZ7763/c$/Users/cpaz7763"
alias Malt="nemo ssh://malt/home/alan"

# Go to directories mounted by nemo
alias rservers="cd /run/user/1000/gvfs/; ls -lrt"

#-------------------------
# Pygmentize 'cat' command
#-------------------------
alias dog='pygmentize -g'

#--------------
# Starting work
#--------------
alias s='./s.sh'

#--------------
# Running pkgs.
#--------------
alias dacdn='s alan adare debitadmin'
alias debitparams='s alan adare debitparams'
alias pceftadmin='s alan adare pceftadmin'

#--------------
# Running rpms.
#--------------
#TODO
alias dacdn2='s alan sxdev64 debitadmin1'

#---------------------------------------------------------
# Cleaning, Making, Packing, Copying and Running - Solaris
#---------------------------------------------------------
alias builddebitadmin="ssh -X adare 'bash --noprofile < ~/sh/debitadmin.sh; hostname closing'"
alias buildparams="ssh -X adare 'bash --noprofile < ~/sh/debitparams.sh'"
alias buildpce="ssh -X adare 'bash --noprofile < ~/sh/pceftadmin.sh'"

#-------------
# SMSC Project
#-------------
alias gsmsc="gksu nemo /home/cpaz/workspace/SMSC/trunk"


#----------------------------------------
# Setting prompt differently if tunneling
#----------------------------------------
__setprompt() {
  local SSH_IP=`echo $SSH_CLIENT | awk '{ print $1 }'`
  local SSH2_IP=`echo $SSH2_CLIENT | awk '{ print $1 }'`
  if [ $SSH2_IP ] || [ $SSH_IP ] ; then
    local SSH_FLAG=":ssh"
  fi
  # SSH Shell
  PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h$SSH_FLAG\[\033[01;34m\] \w \$\[\033[00m\] "
}
__setprompt

#---------------------------------------------------
#netinfo - shows network information for your system
#---------------------------------------------------
netinfo ()
{
  echo "--------------- Network Information ---------------"
  /sbin/ifconfig | awk /'inet addr/ {print $2}'
  /sbin/ifconfig | awk /'Bcast/ {print $3}'
  /sbin/ifconfig | awk /'inet addr/ {print $4}'
  /sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
  myip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' `
  echo "${myip}"
  echo "---------------------------------------------------"
}

#---------------------
# Up in directory tree
# usage: up 4
#---------------------
up(){
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
  do
    d=$d/..
  done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}

#--------------------------------------------------------------------------------------------------------------
# extract() - This combines a lot of utilities to allow you to decompress just about any compressed file format
#--------------------------------------------------------------------------------------------------------------
extract()
{
  if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
  else
    if [ -f $1 ] ; then
      # NAME=${1%.*}
      # mkdir $NAME && cd $NAME
      case $1 in
        *.tar.bz2)   tar xvjf ../$1    ;;
        *.tar.gz)    tar xvzf ../$1    ;;
        *.tar.xz)    tar xvJf ../$1    ;;
        *.lzma)      unlzma ../$1      ;;
        *.bz2)       bunzip2 ../$1     ;;
        *.rar)       unrar x -ad ../$1 ;;
        *.gz)        gunzip ../$1      ;;
        *.tar)       tar xvf ../$1     ;;
        *.tbz2)      tar xvjf ../$1    ;;
        *.tgz)       tar xvzf ../$1    ;;
        *.zip)       unzip ../$1       ;;
        *.Z)         uncompress ../$1  ;;
        *.7z)        7z x ../$1        ;;
        *.xz)        unxz ../$1        ;;
        *.exe)       cabextract ../$1  ;;
        *)           echo "extract: '$1' - unknown archive method" ;;
      esac
    else
      echo "$1 - file does not exist"
    fi
  fi
}

#---------------------------------
# grepc() - Searches for a pattern
#---------------------------------
function grepc ()
{
  pattern="$1"			# Assign pattern
  grep -n --color "$pattern" 	# Grep in color
}

#---------------
# Search Engines
#---------------
function encode() { echo -n $@ | perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg'; }
#function google() { firefox http://www.google.com/search?hl=en#q= "`encode $@`" ;}
function yahoo() { firefox http://search.yahoo.com/search?p="`encode $@`" ;}
function bing() { firefox http://www.bing.com/search?q="`encode $@`" ;}
function amazon() { firefox http://www.amazon.com/s/ref=nb_ss?field-keywords="`encode $@`" ;}
function wiki() { firefox http://en.wikipedia.org/w/index.php?search="`encode $@`" ;}

#---------------------
# SSH bookmark creator
#---------------------
sbm(){
  if [ $# -lt 2 ]; then
    echo " SSH bookmark creator
   Usage: sbm <short> [<user>@]<hostname>
    ex: sbm  foo foobar@123.123.123.123" >&2
    return 1
  fi
  
  short=$1
  arg=$2
  
  if $(echo "$arg" | grep '@' >/dev/null); then
    user=$(echo "$arg"|sed -e 's/@.*$//')
  fi
  
  host=$(echo "$arg"|sed -e 's/^.*@//')
  
  if $(grep -i "host $short" "$HOME/.ssh/config" > /dev/null); then
    echo "Alias '$short' already exists" >&2
    return 1
  fi
  
  if [ -z "$host" ]; then
    echo "No hostname found" >&2
    return 1
  fi
  
  echo >> "$HOME/.ssh/config"
  echo "Host $short" >> "$HOME/.ssh/config"
  echo "  HostName $host" >> "$HOME/.ssh/config"
  [ ! -z "$user" ] && echo "  User $user" >> "$HOME/.ssh/config"
  echo "  GSSAPIAuthentication no" >> "$HOME/.ssh/config"
  echo "  ForwardX11 yes" >> "$HOME/.ssh/config"
  echo "  ForwardX11Trusted yes" >> "$HOME/.ssh/config"
  add_alias $short ssh $short
  dog "$HOME/.ssh/config"
  ssh-copy-id -i ~/.ssh/id_rsa.pub $short
}

#------------------------------------------------
# Comparing Debitadmin files on adare and sxdev64
#------------------------------------------------
compare(){
  file=$1 	# region_groups.c
  view=$2	# new
  folder=$3	# debitadmin
  comp=$4	# not implemented yet
  
  
  if [ "$#" -lt 3 ]; then
    echo "Usage: compare <filename> <new|old> <debitadmin|debitparams>"
  elif [ "$#" -gt 4 ]; then
    echo "Usage: compare <filename> <new|old> <debitadmin|debitparams>"
  else 
    if [ "$view" == "new" ]; then
      d_adare=/view/prepaid-linux-dev/vobs/prepaid/oam/src/$folder #debitadmin
    elif [ "$view" == "old" ]; then
      d_adare=/view/prepaid-7.0.0.1.dev/vobs/prepaid/oam/src/$folder #debitadmin
    else
      echo "new or old?"
    fi
  
    d_sxdev64=\~/src/man/SMSC/trunk/prepaid/oam/src/$folder #debitadmin
    f_adare=$(ssh alan@adare cat $d_adare/$file)
    f_sxdev64=$(ssh sxdev64 cat $d_sxdev64/$file)
  
    colordiff <(echo "$f_adare") <(echo "$f_sxdev64")
  echo " > add to adare
 < add to sxdev64"
   fi
}

#-------------------------------------
# Extracts functions from a C/C++ file
#-------------------------------------
extractfunctions(){
  filename=$1
  filepath=/run/user/1000/gvfs/sftp:host=adare/view/prepaid-linux-dev/vobs/prepaid/oam/src/debitadmin/$filename
  o_file=$(pwd)/output.txt
  f_dbxrc=/run/user/1000/gvfs/sftp:host=cdn/home/ivbbuild/.dbxrc
  
  # Get all functions from file and store in temporary file
  grep -Po '(?<=void |void| int | int).*(?= \(|\()' $filepath >> $o_file
  sed -i 's/^/trace in/g' $o_file
  
  #Append to .dbxrc
  sed -i "/strace[(][)]/ r $o_file" $f_dbxrc
  sed -i '/strace\(\)/a '"$filename"'' $f_dbxrc
  sed -e '/'"$filename"'/ s/^#*/#/' -i $f_dbxrc
  
  cat output.txt
  # Remove temporary file
  rm output.txt
}
alias ef='extractfunctions '
# end of extractfunctions()

#-----------------
# 
#-----------------
if [ "$USER" = "cpaz" ]; then
   echo "Welcome back Alan!" 1>&2
fi

#TODO Function to add functions to bashrc file

#-------------------------------------
# TODO Room to improve - add_alias()
# Add new aliases to this .bashrc file
#-------------------------------------
add_alias(){
#TODO Create option to add comment
  n_alias=${1}
  shift
  n_command="$@"         # ${@:1:$(($#-1)) }
                       # n=$#
                       # n_comment=${!n}
  replacing=$( alias $n_alias 2>/dev/null|wc -l )

  if [[ "$replacing" = "1" ]]; 
  then
      b $n_alias # cat|grep .bashrc in color
      read -p "Do you wish to overwrite this(these) alias(es)? [y/n]" yn
	case $yn in
	  [Yy]* ) sed -i '/alias '"$n_alias"'/d' $HOME/.bashrc;
      		  sed -i ':a;$!{N;ba};s,\(auto-generated code\),\1\nalias '"$n_alias"'="'"$n_command"'",4' $HOME/.bashrc;    
      		  source ~/.bashrc;
      		  echo "alias $n_alias modified in ~/.bashrc";;
	  [Nn]* ) echo "Operation canceled";;
	  * ) echo "Please answer yes or no.";;
	esac
  else
    sed -i ':a;$!{N;ba};s,\(auto-generated code\),\1\nalias '"$n_alias"'="'"$n_command"'",4' $HOME/.bashrc    
    source ~/.bashrc
    echo "alias $n_alias added to ~/.bashrc"
#		    while getopts ":c" Option
#		    do
#		      case $Option in
#			c ) sed ':a;$!{N;ba};s,\(auto-generated code\),\1\nalias '"$n_alias"'='"'$n_command'"' #'"$n_comment"',4' $HOME/.bashrc ;;
#			* ) ;;
#		      esac
#		    done
  fi
}
alias aa='add_alias'
# end of add_alias()

#example on how to include options in functions
test_getopt(){
  echo "begin test"
  while getopts ":a" Option
    do
      case $Option in
        a ) echo "Inside option a" ;;
        * ) ;;
      esac
    done
  echo "end test"
}  

#--------------------------------
# Returns function from ~/.bashrc
#--------------------------------
getfunc(){
  function_name=$1
  
  sed -n -e '/'"$function_name"'(){/,/^}/ p' ~/.bashrc
}

#---------------------------------
# Lists functions inside ~/.bashrc
#---------------------------------
listfunc(){
  function_name=$1
  
  grep -v '^ ' ~/.bashrc | sed -n -e '/^.*'"$function_name"'(){/ p' -e '/^.*'"$function_name"'() {/ p'
}

mounted(){
  host=$1
  user=$2
  if [[ "$host" = "cpaz" ]];
  then
    host=$MANDWCPAZ7763
    cd $XDG_RUNTIME_DIR/gvfs/smb-share:server=$host,share=c$/Users/cpaz7763/Documents/
    tree -d 
  else
    cd $XDG_RUNTIME_DIR/gvfs/sftp:host=$host/home
    ls -lrt
    if [ $# -eq 2 ];
    then
      tree -d ./home/$user
    fi
    
  fi
}

np(){
  /cygdrive/c/Program\ Files/Notepad++/notepad++.exe $* &
}

# auto-generated code
alias vb="cd /cygdrive/c/Program\ Files/Oracle/VirtualBox/; ./VirtualBox.exe"
alias ls="ls -a"
alias apt-get="apt-cyg"
alias br="brackets"
alias open="cygstart"
alias cs="cygstart"
alias pf="C; cd Program\ Files"
alias pfx="C; cd Program\ Files\ \(x86\)" 
alias cheatsheets="cd /cygdrive/c/Users/cpaz7763/Documents/Cheatsheets/; ls"
alias documents="cd /cygdrive/c/Users/cpaz7763/Documents/; ls"
alias C="cd /cygdrive/c; ls"
alias mo="mounted"
alias mtd="mounted"
alias gvfs="cd /run/user/1000/gvfs"
alias alancosta="cd /home/cpaz/Documents/website/alancosta.me.pn; ls -lrt"
alias c="clear"
alias cls="clear"
alias gf="getfunc"
alias home='cd /home/cpaz7763'
alias workspace='cd /home/cpaz/workspace'
alias desktop='cd /home/cpaz/Desktop'
alias scripts='cd /home/cpaz/Scripts'
alias -- -='cd -'
alias cdn2root='ssh -X root@_cdn2root'
alias valdaxml="cdn2 'rm /home/ivbbuild/alan/valgrind-debitadmin.xml; valgrind \
--track-origins=yes \
--leak-check=yes \
--read-var-info=yes \
--xml=yes \
--xml-file=/home/ivbbuild/alan/valgrind-debitadmin.xml \
--tool=memcheck debitadmin \
'; valk"
alias valdaout="cdn2 'valgrind --vgdb=yes --log-file=/home/ivbbuild/alan/valgrind-debitadmin.out --track-origins=yes --leak-check=yes --tool=memcheck debitadmin'"
alias valk="cdn2 'cd /home/ivbbuild/alan/valkyrie-2.0.0/bin/ && ./valkyrie --view-log=/home/ivbbuild/alan/valgrind-debitadmin.xml'"
alias downloads='cd /home/cpaz/Downloads'
alias cdn='ssh -X ivbbuild@$_cdn'
alias cdn2='ssh -X ivbbuild@$_cdn2'
alias sxdev64="ssh -X alan@$_sxdev64"
alias csi="ssh -X ivbbuild@$_csi"
alias malt="ssh -X alan@$_malt"
#alias valkache="cdn2 'valgrind --tool=callgrind debitadmin; kcachegrind $(ls -rt callgrind.out.*| tail -n 1); rm $(ls -rt callgrind.out.* | tail -n 1)'"












