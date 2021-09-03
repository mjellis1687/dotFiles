#!/bin/bash
# check and send ip address to email

MYIP=`ip addr show dev eno1 | grep 'inet ' | awk '{print $2}' | cut -d '/' -f 1`
EMAILADDR='ellis.matt.j@gmail.com'
TIME=`date`;

LASTIPFILE=${HOME}'/.last_ip_addr';
LASTIP=`cat ${LASTIPFILE}`;

if [[ ${MYIP} != ${LASTIP} ]]
then
	echo "New IP = ${MYIP}"
	echo "Sending a notification..."
	echo -e "Hello\n\nTimestamp = ${TIME}\nIP = ${MYIP}\n\nCheers, Management" | \
		mail -s "[INFO] New IP Issued to Workstation" ${EMAILADDR};
	echo ${MYIP} > ${LASTIPFILE};
fi
