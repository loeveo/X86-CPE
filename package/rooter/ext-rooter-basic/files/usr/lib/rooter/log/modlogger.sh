#!/bin/sh

ROOTER=/usr/lib/rooter

TEXT=$1
DATE=$(date +%c)

modlog="/tmp/modlog.log"
tmplog="/tmp/tmodlog"

echo "$DATE : $TEXT" >> $modlog
lua $ROOTER/log/mrotate.lua $modlog $tmplog
mv $tmplog $modlog

exit 0

wc -l $modlog > /tmp/linecnt
read lcnt fle < /tmp/linecnt
rm -f /tmp/linecnt
if [ $lcnt -ge 200 ]; then
	start=$((lcnt-1))
	tail +$start modlog > $tmplog
	mv $tmplog $modlog
fi

echo "$DATE : $TEXT" >> $modlog
