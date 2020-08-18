#wget https://install.direct/go.sh 
# #. go.sh 
# yum makecache
# yum install curl
wget https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh
echo -e "y\n" | . install-release.sh
echo '{
  "inbounds": [
    {
      "port": 3001, 
      "protocol": "vmess",    
      "settings": {
        "clients": [
          {
            "id": "b831381d-6324-4d53-ad4f-8cda48b30811",  
            "alterId": 64
          }
        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom", 
      "settings": {}
    }
  ]
}

'  > /etc/v2ray/config.json
systemctl start v2ray 
systemctl stop v2ray 
systemctl start v2ray 
systemctl stop firewalld
