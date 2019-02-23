pkill -9 ssserver 
echo -e ' {\n    "server_port":30001,\n    "password":"jmt123!@#",\n    "timeout":300,\n    "method":"aes-256-cfb"\n}' > /etc/shadowsocks.json 
ssserver -c /etc/shadowsocks.json -d start
firewall-cmd --zone=public --add-port=30001/tcp --permanent
firewall-cmd --reload
firewall-cmd --list-all
 
