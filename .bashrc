# ==============================================================================
# Sample .bashrc
# Last modified: Sun, Feb 09, 2014 10:59:52 AM
# <cuz@sdf.org>
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# ==============================================================================

## Source global definitions
#[ -f /etc/bashrc ] && source /etc/bashrc

# Set env vars
export history=1000
export savehist=10000
export HISTTIMEFORMAT="%H:%M "
HISTCONTROL=ignoredups:ignorespace # don't put duplicate lines in the history.
export HISTIGNORE="pwd:ls:ls -ltr:history"
shopt -s histappend # append to the history file, don't overwrite it
#export PAGER=less
#export LESSEDIT="%E +%lm %f"
export EDITOR=/usr/bin/vim
#export PRINTER=castpsvr
#export TMP=/tmp
#export TEMP=/tmp
#export INPUTRC=~/.inputrc
#export BLOCKSIZE=1k
#export CC=gcc
#if [ -z $LOGNAME ]; then LOGNAME=`id -un` ; fi
#export MAKE_MODE=UNIX
#export NNTPSERVER=localhost
#umask 077
export CDPATH='.:~:/usr/src/packages'
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export HISTSIZE=5000
export HISTFILESIZE=10000
<<<<<<< HEAD
=======

>>>>>>> 9162798327b6bd143fab480cea17ac3353dbdc4e

# prompt
#export PS1='\e[1;34m[\t][\u@\h \!:\j:$?]\e[m \e[1;33m\w\e[m \n$ '	# on gnome-terminal Gray on black recommended
export PS1='\e[1;34m[\t][\u@\e[1;31m\h\e[1;34m \!:\j:$?]\e[m \e[1;33m\w\e[m \n$ ' # hostname in red
# export PS1='\e[1;34m[\t][\u@\e[1;97m\e[1;45m\h\e[1;34m\e[1;49m \!:\j:$?]\e[m \e[1;33m\w\e[m \n$ ' # white in pink
# export PS1='\e[0;32m[\t][\u@\h \!:\j:$?] \w\e[m \n$ '	# dark green
# export PS1='[\u@\h]$ '	# mono
export PS2='> '
export PS3="Please select one of the options: "
export PS4="+ $0:$LINENO "
#Bash Color Codes
#Black 0;30	Dark Gray 1;30
#Blue 0;34	Light Blue 1;34
#Green 0;32	Light Green 1;32
#Cyan 0;36	Light Cyan 1;36
#Red 0;31	Light Red 1;31
#Purple 0;35	Light Purple 1;35
#Brown 0;33	Yellow 1;33
#Light Gray 0;37	White 1;37

if [ -x /usr/bin/fortune ] || [ -x /usr/games/fortune ]; then 
	if [ -f ~/lib/fortune/*.dat ]; then 
		fortune ~/lib/fortune
	else
		fortune -s ; # Short apothegms only.
#		fortune -s | pv -qL 10 ; # To read carefully
	fi
fi

ulimit -c 0 # Don't want any coredumps.
# option (see the list with set -o)
set -o noclobber # not allow overwrite by >
set -o vi # vi mode
set -o ignoreeof # prohibit logout using CTRL-D
set -o notify # notifies background job completions. 
#echo -e '\e[10;50]\e[11;0000]' # no beep

# ------------------------------------------------------------------------------
# aliases
# ------------------------------------------------------------------------------

alias rm='rm -i'
alias cp='cp -i'
alias grep='grep --color'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias hh='history'
alias h="history | sed 's/^[ ]*[0-9]\+[ ]*[0-9]\+:[0-9]\+[ ]*//'"
#alias h='history | cut -c 8-'
alias j='jobs -l'
#alias which='type -a'
alias ..='cd ..'
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias du='du -kh'
alias df='df -akTh'
alias mount='mount | column -t'

case `uname` in
Linux)
	function ls() { command ls -hCF --color=tty $@ ; } ;;
CYGWIN*)
	function ls() { command ls --show-control-chars -hCF --color=tty $@ ; } ;
	export PS1='\e[1;34m[\t][\u@\e[0;32m\h\e[1;34m \!:\j:$?]\e[m \e[1;33m\w\e[m \n$ ';;# hostname in darkgreen
SunOS*)
	alias ls='ls -F' ;;
*)
	alias ls='ls --color=auto' ;;
esac

alias	ll="ls -l --group-directories-first"
alias	lsdotfiles='dir -a1F | grep "^\." | grep -v /$'
alias	l='ls -m' 
alias	la='ls -Al'          # show hidden files
alias	lx='ls -lXB'         # sort by extension
alias	lk='ls -lSr'         # sort by size, biggest last
alias	lc='ls -ltcr'        # sort by and show change time, most recent last
alias	lu='ls -ltur'        # sort by and show access time, most recent last
alias	lt='ls -ltr'         # sort by date, most recent last
alias	lm='ls -al |more'    # pipe through 'more'
alias	lr='ls -lR'          # recursive ls
alias	tree='tree -Csu'     # nice alternative to 'recursive ls'
alias   clean="mv -f *~ .*~ \"#\"*\"#\" ${HOME}/.trash"

# pastebins
alias ix="curl -F 'f:1=<-' http://ix.io"
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"

test -s ~/.alias && . ~/.alias || true

# ------------------------------------------------------------------------------
# functions
# declare -F # list of functions
# declare -f # see the function
# ------------------------------------------------------------------------------

# find files with a keyword.
# Usage: $FUNCNAME <keyword> <directory>
function ff() { find ${2:-.} -type f -iname '*'$1'*' -ls; }

# find files larger than $size
# usage: $FUNCNAME <size N[bcwkMG]>
function ffsize() { find ${2:-.} -type f -size +${1:-100M}; }

# find files updated in $min
# usage: $FUNCNAME $min
function ffmin() { find ${2:-.} -mmin -${1:-5}; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe() { find . -type f -iname '*'${1:-}'*' -exec ${2:-file} {} \;  ; }

# Find files and change permission to $1 in directory $2
function ffperm() { find ${2:-.} -print0 | xargs -0 chmod $1 ; }

# move filenames to lowercase 
function lowercase() {
	for file ; do
		filename=${file##*/}
		case "$filename" in
		*/*) dirname==${file%/*} ;;
		*) dirname=.;;
		esac
		nf=$(echo $filename | tr A-Z a-z)
		newname="${dirname}/${nf}"
		if [ "$nf" != "$filename" ]; then
			mv "$file" "$newname"
			echo "lowercase: $file --> $newname"
		else
			echo "lowercase: $file not changed."
		fi
	done
}

# usage: checkos target
function checkos() { sudo nmap -sT -O ${1:-localhost} ; }

# Lists all listening ports together with the PID of the associated process
function lslistenports() { sudo netstat -tlnp ; }

# make a backup copy in ~/.bak/
function bak() { for i in $*; do cp $i ~/.bak/`basename $i`.`date '+%Y%m%d%H%M'` ; done ; }
function bak2() { sed -i.`date '+%Y%m%d%H%M'` '' $* ; } # same dir

# count blank lines
function cbl() {
	awk ' /^$/ { ++x }
	END { print x } ' $1
}

# remove blank lines
# $FUNCNAME $filename
function rbl() { grep . $1 ; }

# usage: cutfile filename startline endline
function cutfile() {
	local FILE=$1
	local usage='Usage: cutfile filename startline endline'
	case $# in
	0|1|2)  echo "$usage" ;;
	*)      awk '
		{ ++x if ( ( b <= x ) && ( x <= e ) ) print $0 }
		' b=$2 e=$3 $FILE ;;
	esac
}

# delete file by inode
# usage: ls -il; then $FUNCNAME <inode>"
function rmbyinode() { find -inum $1 -exec rm -i {} \; ; }
#function rmbyinode() { find -inum $1 -delete ; } # without -i
#function rmbyinode() { find . -inum $1 -print0 | xargs -0 rm -i ; } # -i doesnot work

# cat file and copy to the clipboard
# usage: $FUNCNAME <filename>"
#function f2clipboard() { cat $1 | xsel --clipboard ; }
function f2clip() { nkf $1 | xsel --clipboard ; }
function clip2stdout() { xsel --clipboard ; }

# look up a word online
function dict() { curl dict://dict.org/d:$1; }

# Query wikipedia over DNS
# http://www.commandlinefu.com/
wiki() { local IFS=_; dig +short txt "${*^}".wp.dg.cx; }

# Google search from the command line
function googlesearch() {
	value="$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$*")"
	lynx -dump "http://www.google.com/search?q=$value" 
}

# Google translate from the command line
# http://www.commandlinefu.com/
function googletranslate() {
	local usage="Usage: $FUNCNAME <phrase> <source-language> <output-language>"
	case $# in
	0) echo -e "$usage" ;;
	*) wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=${2:-en}|${3:-en}" | sed -E -n 's/[[:alnum:]": {}]+"translatedText":"([^"]+)".*/\1/p';
		echo ''
		return 0;
	esac
}

# Google text-to-speech in mp3 format
# usage: $FUNCNAME <keyword>(<100chars) <lang>
function googletexttospeach() {
  mplayer "http://translate.google.com/translate_tts?ie=UTF-8&tl=${2:-en}&q=$1"
}

# google doc
# Common options:
# format: Force docs to use the extension you provide.
# folder: Specify a folder on Docs to search in or upload to.
# Tasks:
# delete: Delete docs. delete --title "Evidence"
# edit: Edit or view a document. edit --title "Shopping list" --editor vim
# get: Download docs. get --title "Homework [0-9]*"
# list: List documents. list title,url-direct --delimiter ": "
# upload: Upload documents. upload the_bobs.csv ~/work/docs_to_share
# Edit a google doc with vim
# usage: $FUNCNAME <title>
# http://code.google.com/p/googlecl/wiki/Manual#Docs
function editgoogledocs() { google docs edit --title "$1" --editor vim ; }

function lsgooglecontacs() { google contacts list --fields name,email,address,website,birthday,organization,phone,notes --title ".*${1:-linux}.*" ; }

# google's reverse geocode service
# usage: $FUNCNAME latitude longitude
#function findnearest() { lynx -dump "http://maps.google.com/maps/geo?output=csv&oe=utf-8&ll=$1,$2" ; }

# find geographical location of an ip address
function ipaddr2geo() { lynx -dump http://www.ip-adress.com/ip_tracer/?QRY=$1|grep address|egrep 'city|state|country'|awk '{print $3,$4,$5,$6,$7,$8}'|sed 's\ip address flag \\'|sed 's\My\\' ; }

# Google URL shortener
function googl() { curl https://www.googleapis.com/urlshortener/v1/url -H 'Content-Type: application/json' -d '{"longUrl": "'$1'"}'| egrep -o 'http://goo.gl/[^"]*' ; }

# recursively convert the character code(to UTF-8)
# usage: $FUNCNAME <directory>
function 2utf() { echo "find $1 -type f | egrep '/.*\.(txt|text)$' | xargs -d '\n' nkf -w --overwrite" ; }

# sync files with remote server
function syncfileswithremote() {
	local usage="Usage: sync files with remote server."
	local file_source='~/public_html'
	local remote_user='user'
	local remote_host='freeshell.org'
	local destination_file='~/public_html'
	local command="rsync --partial --progress --rsh=ssh $file_source $remote_user@$remote_host:$destination_file"
	case $# in
	*) echo "$command" ;
		$command ;;
	esac
}

# backup .bashrc to remote
# usage: $FUNCNAME $user $addr
function backupbashrc() { scp ~/.bashrc "$1"@${2:-freeshell.org}:~/html/etc/skel/ ; }

# find all active IP addresses in a network
function findactiveipaddresses() { arp -a ; }
#function findactiveipaddresses() { arp-scan -l ; }

# mkdir and cd into it
# $FUNCNAME <directory>
function mkdircd() { mkdir $1 && cd $_ ; }

# mount a .iso/.img file
# usage: $FUNCNAME $isofile
function mountiso() { sudo mount -o loop $1 /mnt ; }
#function mountiso() { sudo mount -t cd9660 -o loop $1 /mnt ; }
#function mountiso() { sudo mount -t ext3 -o loop $1 /mnt ; }

# list all files opened by a command
# usage: $FUNCNAME $cmd
function cmd2listfiles() { lsof -c $1 ; }

# Given process ID print its environment variables. # usage: $FUNCNAME $pid
function pid2env() { sudo sed 's/\o0/\n/g' /proc/$1/environ ; }
# ps ewwo command $PID | tr ' ' '\n' | grep \=

# simple password generator $FUNCNAME $num_of_char
function genpassword() { < /dev/urandom tr -dc A-Za-z0-9_ | head -c${1:-8} ; }
function genpassword2() { egrep -oam1 '[A-Za-z0-9]{8}' /dev/urandom ; }

# createSsltunnel $remoteaddr # you -> localhost:2001 -> remote2:80
function createssltunnel() { ssh -N -L2001:localhost:80 $1 ; }

# man2txt $name # save man pages as plain text
function man2txt() { (export PAGER=cat ; man $1 | col -b ;) }

# create BackDoor
# $ nc $addr $port # to connect from remote
function createbackDoor() { netcat -lp $1 -e /bin/bash ; } 

# insert timestamp to the file -> use function! LastModified() in .vimrc
# $FUNCNAME $filename
function instimestamp() { sed -i.`date '+%Y%m%d%H%M%S'` -e "s/^\(# Time-stamp: \).*/\1`date`/" $1 ; }

# show how to use function
# usage: $FUNCNAME <function>"
function usagefunction() { <~/.bashrc grep -B3 "$1" ; }

# Capture video of a desktop
# usage: $FUNCNAME file.mpg
function videodesktop() { ffmpeg -f x11grab -s wxga -r 25 -i :0.0 -sameq ${1:-o.mpg} ; }

# copy and watch its progress
function cp2() { pv $1 > $2 ; }	

# Terminal Calculator
function calc { echo "${1}"|bc -l; }

# wget, be safe
function wgetslow() { wget -c --limit-rate=200k -c --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.3) Gecko/2008092416 Firefox/3.0.3" $@ ; }

# burn iso image
# usage: $FUNCNAME filename.iso
function burncd() {
    local dev='/dev/sg1' # must check by 'cdrecord --devices'
    cdrecord -v -dev=$dev $1; eject $dev
}

# find usb stick
function findusbstick() { grep -Ff <(/usr/sbin/hwinfo --disk --short) <(/usr/sbin/hwinfo --usb --short) ; }

# create a live usb from iso
#function iso2usb() {
#    isohybrid openSUSE-11.4-DVD-x86_64.iso
#    umount /dev/sdXY
#    dd_rescue openSUSE-11.4-KDE-LiveCD-x86_64.iso /dev/sdX
#}

# MAC changer
function macch {
    local interface=${1:-wlan0}
#    local mac=`ruby -e 'print ("%02x"%((rand 64).to_i*4|2))+(0..4).inject(""){|s,x|s+":%02x"%(rand 256).to_i} + "\n"'`
    echo "$interface $mac"
    sudo /sbin/ifconfig $interface down
#    sudo /sbin/ifconfig $interface hw ether $mac
    sudo macchanger -A $interface
    sudo /sbin/ifconfig $interface up
#    sudo /etc/init.d/network restart # reset MAC
}

# Play music from youtube without download
#function mp3online { wget -q -O - `youtube-dl -g $1`| ffmpeg -i - -f mp3 -vn -acodec libmp3lame -| mpg123 - ; }

function asciitable() { man ascii ; }	# ASCII TABLE
function mydate() { date '+%Y%m%d %a' ; }	# date in simple format
function memdisk() { sudo mount -t tmpfs -o size=1024m tmpfs /mnt ; } # mount a temporary ram partition
function cleargnomerecent() { cat /dev/null >| ~/.recently-used.xbel ; } # purge gnome recent items
function getstringram() { sudo dd if=/dev/mem | cat | strings ; } # string values in ram
function excuse() { echo `telnet bofh.jeffballard.us 666 2>/dev/null` |grep -o "Your excuse is:.*$" ; }
function webshare() { python -c "import SimpleHTTPServer;SimpleHTTPServer.test()" ; } # Share current tree over the web
function how2list() { lynx --dump http://www.tldp.org/HOWTO/text/ ; }
function wireframeingnome() { gconftool-2 --type bool --set /apps/metacity/general/reduced_resources true ; }

# hardware info
function infohardware() {
cat <<EOF
- /usr/sbin/dmidecode --type bios # (bios, system, baseboard, chassis, processor, memory, cache, connector, slot)
- cat /proc/partitions	# partitions
- cat /proc/meminfo	# ram
- cat /proc/cpuinfo	# cpu
- lspci -tv		# pci
- lsusb -tv		# usb
- smartctl -A /dev/sda 	# harddisk
- hdparm -i /dev/sda	# harddisk
- cat /proc/acpi/battery/BAT0/info	# laptop battery
EOF
}

# system info
function infosystem() {
cat <<EOF
- htop			# interactive process viewer
- pstree
- free -m		# remaining ram size
- last reboot		# reboot history
- uname -a		# kernel version and system architecture
  cat /proc/version
- cat /etc/issue	# OS distribution
- sudo lsof -u someuser -a +D /etc # View user activity per directory.
- set | grep $USER	Search current environment
- chkconfig -list	# services
EOF
}

# network info
function infonetwork() {
cat <<EOF
- /usr/sbin/mtr google.com	# traceroute
- /sbin/ethtool eth0 # ethernet interface status
- /usr/sbin/iwconfig wlan0 # wireless interface status
- ethtool --change eth0 autoneg off speed 100 duplex full	# manually set ethernet interface speed
- iwconfig eth1 rate 1Mb/s fixed	# manually set wireless interface speed
- /usr/sbin/iwlist wlan0 scanning	# list wireless networks
- ip link show	# list network interfaces
- ip link set dev eth0 up/down
- ip addr show	# list addresses
- ip addr add 1.2.3.4/24 brd + dev eth0	# add/del ip and mask
- ip route show	# list routing table
- ip route add default via 1.2.3.254	# set default gateway to 1.2.3.254
- netstat -tupl	# list internet services
- netstat -tup	# list active connections
- nmap -sT -p 80 -oG - 192.168.1.* # scan specific port
- lsof -Pan -i tcp -i udp # Lists all listening ports together with the pid
- ssh -t hostA ssh hostB # directly ssh to host B that is only accessible through host A
- fuser -va /home	# processes accessing /home
- fuser -n tcp 80	# who's using port 80
- lsof -i tcp:80	# What's using port 80
- while :; do cat file.txt | nc -l 80; done # share single file in LAN via netcat
- smbtree	# windows on network
- nmblookup -A 1.2.3.4	# ipaddr to netbios name
- smbclient -L windows_box	# list shares on windows
- mount -t smbfs -o fmask=666,guest //windows_box/share /mnt	# mount a windows share
EOF
}

# monitoring info
function infomonitoring() {
cat <<EOF
- tail -f /var/log/messages
- strace -c $cmd >/dev/null	# summarise/profile system calls
- strace -f -e open $cmd >/dev/null	# list system calls
- strace -f -e trace=write -e write=1,2 $cmd >/dev/null	# monitor stdout/stderr
- ltrace -f -e getenv $cmd >/dev/null	# list library calls
- lsof -p $$	# list paths that process id has open
- lsof ~	# list processes that have specified path open
- tcpdump not port 22	# network traffic except ssh
- ps -e -o pid,args --forest	# processes in a hierarchy
- ps -e -o pcpu,cpu,nice,state,cputime,args --sort pcpu | sed '/^ 0.0 /d'	# processes by % cpu usage
- ps -e -orss=,args= | sort -b -k1,1n | pr -TW$COLUMNS	# list processes by mem (KB) usage.
- ps -C firefox-bin -L -o pid,tid,pcpu,state	# list all threads for a particular process
- ps -p 1,$$ -o etime=	# list elapsed wall time for particular process IDs
- watch -n.1 'cat /proc/interrupts'	# watch changeable data continuously
- udevadm monitor	# monitor udev events to help configure rules

# disk usage, utilities
function infodisk() {
cat <<EOF
- ncdu
- FSlint # Duplicate file finder for linux
- rpm -q -a --qf '%10{SIZE}\t%{NAME}\n' | sort -k1,1n	List all packages by installed size (Bytes) on rpm distros
- dpkg-query -W -f='${Installed-Size;10}\t${Package}\n' | sort -k1,1n	List all packages by installed size (KBytes) on deb distros
EOF
}

# note etc
function noteetc() {
cat <<EOF
- cut -d"," -f5 --complement file.csv	# exclude a column
- ^foo^bar	# runs previous command but replacing arguments default to empty
- diff <(wget -q -O - URL1) <(wget -q -O - URL2)
- rm !(*.foo|*.bar|*.baz)	# delete files that don't match a extension
- :w !sudo tee %	# write with sudo
EOF
}

# how2 git
function how2git() {
cat <<EOF
Create a new repository on the command line
$ touch README.md
$ git init
$ git add README.md
$ git commit -m "first commit"
$ git remote add origin git@github.com:foresthermit/dotfiles.git
$ git push -u origin master

Push an existing repository from the command line
$ git remote add origin git@github.com:foresthermit/dotfiles.git
$ git push -u origin master

Clone
$ git clone git@github.com:foresthermit/dotfiles.git
EOF
}

# End of File ==================================================================
