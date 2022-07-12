#!/bin/sh
date=$(date +%FT%H%M%S)
homedir=/home/survey/${date}
passwd=$(tr -cd '[:alnum:]' < /dev/random | fold -w 12 | head -n 1)
echo "survey:${passwd}"
echo "survey:${passwd}" | chpasswd
mkdir -p ${homedir}
test -f /opt/config/template && cp -v /opt/config/template ${homedir}/template
test -f /opt/config/deadline && deadline=$(cat /opt/config/deadline | tr -cd [:digit:]) && echo -n "Current deadline: " && date --date "@${deadline}"
chown survey:survey ${homedir}
if [ ! -f /opt/config/dropbear_ecdsa_host_key ]; then
	dropbearkey -t ecdsa -s 521 -f /etc/dropbear/dropbear_ecdsa_host_key
else
	ln -s /opt/config/dropbear_ecdsa_host_key /etc/dropbear/dropbear_ecdsa_host_key
fi
dropbear -F -E -w -T 2 -j -k -G survey -c "sh /opt/survey.sh ${homedir} ${deadline}" 2>&1 | tee /home/survey/${date}.log
