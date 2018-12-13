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

echo '# /bin/bash
ssserver -c /etc/shadowsocks.json -d start' > /etc/rc.d/init.d/shadowsocks
ls -s /etc/rc.d/init.d/shadowsocks /etc/rc.d/rc3.d/S60shadowsocks
echo 'shadowscocks加入开机自启'
