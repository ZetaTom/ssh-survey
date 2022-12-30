#!/bin/sh
set +m
homedir=$1
deadline=$2
test ! -z ${deadline} && test $(date +%s) -gt $deadline && \
	echo "Unfortunately, the evaluation period has expired." && \
	echo "This session will terminate now. Goodbye!" && exit
uuid=$(uuidgen -t)
test -f ${homedir}/template && cp ${homedir}/template ${homedir}/${uuid}
rnano -RalmMW$ -T4 ${homedir}/${uuid}
echo "Thank you for participating. Have a nice day!"
