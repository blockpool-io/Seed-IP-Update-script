PATH=/usr/local/bin:$PATH
BLOCKHEIGHTFILE=/tmp/blockheight.txt
LOGFILE=/var/log/bplAutoRestart.log
STATUS=$(curl -s http://$(hostname):9030/api/loader/status/ping)
if [ "$STATUS" = '{"success":true}' ]
then
    echo "$(date) UP" >> $LOGFILE
    rm -f $BLOCKHEIGHTFILE ### reset the stored old blockheight
elif [ "$STATUS" = '{"success":false}' ]      
then
    echo "$(date) DOWN" >> $LOGFILE 
    BLOCKHEIGHT=$(curl -s http://$(hostname):9030/api/blocks/getHeight | jq -r '.height')
    echo "--> Height: $BLOCKHEIGHT" >> $LOGFILE
    if [ -f $BLOCKHEIGHTFILE ] ### check if we have stored block height before
    then
	OLDHEIGHT=$(cat $BLOCKHEIGHTFILE)
	echo "--> Prev height: $OLDHEIGHT" >> $LOGFILE
	if [ $BLOCKHEIGHT -le $OLDHEIGHT ] ### If blockheight has not increased
	then
	    echo "--> Height has not increased over last period. Restarting." >> $LOGFILE
	    forever restart bplnode
	   rm $BLOCKHEIGHTFILE ### reset stored old blockheight
	else
	    echo "--> Height is increasing. Recording new height" >>$LOGFILE
	    echo $BLOCKHEIGHT > $BLOCKHEIGHTFILE
	fi
    else
	echo "--> Recording new blockheight file" >> $LOGFILE
	echo $BLOCKHEIGHT > $BLOCKHEIGHTFILE
    fi
else
    echo "$(date) NOT RUNNING" >> $LOGFILE    
fi
