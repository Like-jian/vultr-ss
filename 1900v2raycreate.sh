wget https://install.direct/go.sh 
. go.sh 
echo '{
  "inbounds": [
    {
      "port": 1900, 
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
