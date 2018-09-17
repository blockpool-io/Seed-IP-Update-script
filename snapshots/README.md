# BPL Snapshot Script

## Instructions

Edit crontab by typing `sudo nano /etc/crontab`

Put the following line at the end of the file to create a snapshot every 15 minutes

```bash
*/15 * * * * user /path/to/snapshots.sh
```

Replace the `user` with your username and path at the end with your real script path.

Save the file with Ctrl+x and Y when you're done
