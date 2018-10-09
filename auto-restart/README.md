# BPL Automatic Restart Script

## Instructions

### 1. Get the script

```bash
wget https://raw.githubusercontent.com/blockpool-io/utility-scripts/master/auto-restart/auto-restart.sh -O /usr/local/bin/auto-restart.sh
```

### 2. Make it executable

```bash
chmod +x /usr/local/bin/auto-restart.sh
```

### 3. Execute the script manually

```bash
bash /usr/local/bin/auto-restart.sh
```

> This steps correctly sets up all necessary paths for the script to function

### 4. Add cronjob

Edit crontab by typing `crontab -e`.

Put the following line at the end of the file to execute the restart checker every 5 minutes: 

```bash
*/5 * * * * /usr/local/bin/auto-restart.sh
```

Be sure to add a linebreak at the end of this file.

### 5. Start the node using the new forever config

```bash
forever start ~/.forever/configs/bplnode.json
```

> If your node is running -> first find out the process uid with `forever list`. You can then stop the BPL-node process with `forever stop <uid>`, where `<uid>` is the respective process number. Alternatively you can stop all running forever processes by typing `forever stopall`.
