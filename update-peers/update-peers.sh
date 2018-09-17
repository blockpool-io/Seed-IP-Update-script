# Please stop the node first, then run this, then start it again.

# Install the jq tool

sudo apt install -y jq

# First, we define an up-to-date list of peers, in a temporary json file

cat <<EOT > /tmp/peerslist.json
[
      {
        "ip": "13.56.163.57",
        "port": 9030
      },
      {
        "ip": "54.183.132.15",
        "port": 9030
      },
      {
        "ip": "54.183.69.30",
        "port": 9030
      },
      {
        "ip": "54.183.152.67",
        "port": 9030
      },
      {
        "ip": "54.183.22.145",
        "port": 9030
      },
      {
        "ip": "54.183.209.94",
        "port": 9030
      },
      {
        "ip": "54.153.89.97",
        "port": 9030
      },
      {
        "ip": "54.153.120.24",
        "port": 9030
      },
      {
        "ip": "54.67.117.224",
        "port": 9030
      },
      {
        "ip": "54.241.156.232",
        "port": 9030
      },
      {
        "ip": "54.193.61.26",
        "port": 9030
      },
      {
        "ip": "54.67.92.59",
        "port": 9030
      },
      {
        "ip": "54.67.7.8",
        "port": 9030
      },
      {
        "ip": "54.193.96.185",
        "port": 9030
      },
      {
        "ip": "54.193.74.250",
        "port": 9030
      },
      {
        "ip": "52.8.241.48",
        "port": 9030
      },
      {
        "ip": "52.8.9.104",
        "port": 9030
      },
      {
        "ip": "54.176.247.176",
        "port": 9030
      },
      {
        "ip": "54.153.79.95",
        "port": 9030
      },
      {
        "ip": "54.219.93.204",
        "port": 9030
      },
      {
        "ip": "34.213.166.148",
        "port": 9030
      },
      {
        "ip": "34.214.174.88",
        "port": 9030
      },
      {
        "ip": "52.88.128.228",
        "port": 9030
      },
      {
        "ip": "54.213.226.185",
        "port": 9030
      },
      {
        "ip": "54.245.199.209",
        "port": 9030
      },
      {
        "ip": "34.217.64.119",
        "port": 9030
      },
      {
        "ip": "54.200.202.163",
        "port": 9030
      },
      {
        "ip": "34.216.191.160",
        "port": 9030
      },
      {
        "ip": "34.211.242.52",
        "port": 9030
      },
      {
        "ip": "54.245.199.151",
        "port": 9030
      },
      {
        "ip": "35.167.94.49",
        "port": 9030
      },
      {
        "ip": "54.201.94.49",
        "port": 9030
      },
      {
        "ip": "54.213.142.230",
        "port": 9030
      },
      {
        "ip": "34.210.228.114",
        "port": 9030
      },
      {
        "ip": "52.39.139.106",
        "port": 9030
      },
      {
        "ip": "52.34.9.183",
        "port": 9030
      },
      {
        "ip": "34.215.115.113",
        "port": 9030
      },
      {
        "ip": "34.213.244.197",
        "port": 9030
      },
      {
        "ip": "34.208.243.17",
        "port": 9030
      }      
]
EOT

# Backup the current mainnet json file:

export CONFIG_BACKUP=config.mainnet.json.bak-`date '+%s'`
cp config.mainnet.json ${CONFIG_BACKUP}

cat ${CONFIG_BACKUP}  | jq ".peers.list=$(cat /tmp/peerslist.json)" > config.mainnet.json

echo "Done."