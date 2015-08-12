# shell

#!/bin/bash
##################################################
# Name: port-check.sh
# Description: Checks specified port(s),can restart service(s)
# Script Maintainer: Jacob Amey
#
# Last Updated: July 22th 2013
##################################################
# Set Variables
#
IP=`hostname -I`
HOSTNAME=`hostname`
SERVICE="httpd"
PORT="80"
HOST="127.0.0.1"
#
MAIL=`which mailx`
MAILTO="chenfeiyao520@163.com"
#
LOG_FILE="/var/log/port-check.log"
#
function message {
echo "
------------: Sys Info :---------------
              
Hostname : $HOSTNAME 
IP : $IP
Date-Time : `date`
---------------------------------------                
Port $PORT is not responding. 
Restarting the $SERVICE service.
"
}
##################################################
#
nc -z $HOST $PORT;

if [ $? != 0 ]; then #I am down restarting and telling you about it.
	message | $MAIL -s "$SERVICE is not responding on $HOSTNAME" "$MAILTO"
	service $SERVICE restart
	touch $LOG_FILE
	message >> $LOG_FILE
else # Im fine doing nothing.
	echo "port $PORT on server $HOSTNAME is up at $(date)" >> /dev/null
fi
# EOF
