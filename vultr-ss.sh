yum -y install epel-release
yum -y install vim
yum -y install python-pip
pip install shadowsocks
echo ' { 
    "server_port":2018,
    "password":"jmt123!@#",
    "timeout":300,
    "method":"aes-256-cfb"
}' > /etc/shadowsocks.json
ssserver -c /etc/shadowsocks.json -d start
firewall-cmd --zone=public --add-port=2018/tcp --permanent
firewall-cmd --reload
firewall-cmd --list-all

