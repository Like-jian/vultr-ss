wget https://bootstrap.pypa.io/get-pip.py -o get-pip.py 
python get-pip.py.1 
python3 get-pip.py.1
apt install python-pip
yum install -y epel-release
yum install -y python-pip
pip install shadowsocks
echo ' { 
    "server_port":30001,
    "password":"jmt123!@#",
    "timeout":300,
    "method":"aes-256-cfb"
}' > /etc/shadowsocks.json
ssserver -c /etc/shadowsocks.json -d start
firewall-cmd --zone=public --add-port=30001/tcp --permanent
firewall-cmd --reload
firewall-cmd --list-all
# 防火墙开放指定端口 防止没有firewall-cmd命令
iptables -A INPUT -p tcp --dport 30001 -j ACCEPT

# 显示当前时间
hwclock -w
timedatectl set-timezone Asia/Shanghai

echo '当前时间是：'
date
