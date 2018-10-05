#!/bin/bash

INITIALISED=0

PATH=$PATH

DIRCOUNT=`locate -b -c "\BPL-node"`

if [[ ! ${DIRCOUNT} -eq 1 ]];
then
    echo "--> more than once BPL-node folder found - aborting"
    exit 1
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

BPLDIR=`locate -b "\BPL-node"`
BLOCKHEIGHTFILE=/tmp/blockheight.txt
LOGFILE=$BPLDIR/logs/auto-restart.log
CONFIGFILE=$HOME/.forever/configs/bplnode.json
SCRIPTFILE=$DIR/$BASH_SOURCE

PORT=9030
NET=mainnet

if [[ ${INITIALISED} -eq 0 ]];
then
    NODEBIN=$(which node)
    NODEPATH=${NODEBIN%/*}
    
    sed -i "1,/\(.*PATH\=\)/s#\(.*PATH\=\)\(.*\)#\1"$NODEPATH:/usr/local/bin:$PATH"#" $SCRIPTFILE

    mkdir -p $HOME/.forever/configs/ && touch $CONFIGFILE && touch $LOGFILE
    echo -e "[ {\"uid\":\"bplnode\", \"append\":true, \"watch\":false, \"command\":\"node\", \"script\":\"app.js\", \"args\": [\"-c\", \"config."$NET".json\", \"-g\", \"genesisBlock."$NET".json\"], \"sourceDir\":\""$BPLDIR"/\", \"workingDir\":\""$BPLDIR"/\"} ]" > $CONFIGFILE
    sed -i "1,/\(.*INITIALISED\=\)/s#\(.*INITIALISED\=\)\(.*\)#\1"\1"#" $SCRIPTFILE

    echo "--> BPL-node found at: "$BPLDIR
    echo "--> node binary found at: "$NODEPATH
    echo "--> created configuration file at: "$CONFIGFILE
else
    STATUS=$(curl -s http://$(hostname):$PORT/api/loader/status/ping)

    if [ $STATUS = '{"success":true}' ];
    then
        echo "$(date) UP"
    else
        echo "$(date) DOWN"
        BLOCKHEIGHT=$(curl -s http://$(hostname):$PORT/api/blocks/getHeight | jq -r '.height')
        echo "--> Height: $BLOCKHEIGHT" 
        if [ -f $BLOCKHEIGHTFILE ] ### check if we have stored block height before
            then
            OLDHEIGHT=$(cat $BLOCKHEIGHTFILE)
            echo "--> Prev height: $OLDHEIGHT" >> $LOGFILE
            if [ $BLOCKHEIGHT -le $OLDHEIGHT ]; ### If blockheight has not increased
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
    fi
fi
