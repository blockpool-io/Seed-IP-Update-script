# Vote Report

This script generates a vote report at the configured file every 10 minutes.

## Instructions

A **[BPL-node](https://github.com/blockpool-io/bpl-node)** needs to be installed and in sync.

Get the script and make it executable with the following commands:

```sh
wget https://raw.githubusercontent.com/blockpool-io/vote-report/master/vote-report.sh -O /usr/local/bin/vote-report.sh
chmod +x /usr/local/bin/vote-report.sh
```

Edit crontab by typing `crontab -e`. This will allow you to edit the crontab in your default / chosen editor.

Put the following line at the end of the file to execute the restart checker every 10 minutes:

```
*/10 * * * * /usr/local/bin/vote-report.sh
```

Be sure to add a linebreak at the end of this file.

Replace the example path above with the real location of the restart script.

Save the file and exit the editor. Do `crontab -l` to verify that the new line is now in your crontab.

### Dependencies 

#### Ubuntu
`sudo apt-get install -y wget curl sed jq bc`

#### CentOS
`sudo yum install -y wget curl sed jq bc`

## Configuration

Edit the script to customize the OutputFile variable value.

> OutputFile='/var/www/html/vote-report.txt'
