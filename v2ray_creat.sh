wget https://install.direct/go.sh 
. go.sh 
echo '{
  "inbounds": [
    {
      "port": 3001, // 服务器监听端口
      "protocol": "vmess",    // 主传入协议
      "settings": {
        "clients": [
          {
            "id": "b831381d-6324-4d53-ad4f-8cda48b30811",  // 用户 ID，客户端与服务器必须相同
            "alterId": 64
          }
        ]
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",  // 主传出协议
      "settings": {}
    }
  ]
}

' 
systemctl start v2ray 
systemctl stop v2ray 
systemctl start v2ray 
systemctl stop firewalld