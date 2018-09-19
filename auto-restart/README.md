# BPL Snapshot Script

## Instructions

Edit crontab by typing `crontab -e`. This will allow you to edit the crontab in your default / chosen edito.

Put the following line at the end of the file to execute the restart checker every 5 minutes

```bash
*/5 * * * * /usr/local/bin/bplAutoRestart.sh
```

Be sure to add a linebreak at the end of this line.

Replace the example path above with the real location of the backup script.

Save the file and exit the editor. Do `crontab -l` to verify that the new line is now in your crontab.

Make sure that the bplAutoRestart.sh script is in the location referenced by the crontab. For example, `/usr/local/bin`.

Now, save the forever.json file in your chosen location - for example, `/etc/forever.json`.

You may want to edit the `forever.json` file to point to the location where your `BPL-node` folder is. Verify that the rest of the parameters in `forever.json` match what you are expecting.

Now, you can stop your bpl-node process. First verify what forever processes are running with `forever list`. Once you have checked what is running, you can stop all processes with `forever stopall`.

Finally, you can run the bplnode process, using the parameters specified in the `forever.json` file, simply with this command

```bash
forever start /etc/forever.json
```

The restart script will run every 5 minutes and check the blockheight of your node. It logs its activity to a log file, which by default is /var/log/bplAutoRestart.log



