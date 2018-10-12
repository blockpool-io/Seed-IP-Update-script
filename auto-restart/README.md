# BPL Automatic Restart Script

## Instructions

### 1. Get the script

```bash
wget https://raw.githubusercontent.com/blockpool-io/utility-scripts/master/auto-restart/auto-restart.sh
```

### 2. Make it executable

```bash
chmod +x ~/auto-restart.sh
```

### 3. Execute the script manually

> This steps correctly sets up all necessary paths for the script to function

```bash
bash auto-restart.sh
```

### 4. Move the script

```bash
sudo mv ~/auto-restart.sh /usr/local/bin/
```

### 5. Add cronjob

Edit crontab by typing `crontab -e`.

Put the following line at the end of the file to execute the restart checker every 5 minutes: 

```bash
*/5 * * * * /usr/local/bin/auto-restart.sh
```

Be sure to add a linebreak at the end of this file.

### 6. Start the node using the new forever config

> If your node is running -> first find out the process uid with `forever list`. You can then stop the BPL-node process with `forever stop <uid>`, where `<uid>` is the respective process number. Alternatively you can stop all running forever processes by typing `forever stopall`.

```bash
forever start ~/.forever/configs/bplnode.json
```
