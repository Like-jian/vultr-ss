#yum -y install epel-release
yum -y install vim
yum -y install python-pip
yum -y install ntpdate
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


echo '[Unit]
Description=shadowsocks
After=auditd.service systemd-user-sessions.service time-sync.target network.target

[Service]
Type=forking
ExecStart=/usr/bin/ssserver -c /etc/shadowsocks.json -d start
ExecReload=/usr/bin/ssserver -d reload
ExecStop=/usr/bin/ssserver -d stop

[Install]
WantedBy=multi-user.target
' > /usr/lib/systemd/system/ssserver.service

systemctl enable ssserver.service
echo 'shadowscocks加入开机自启'
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock -w
timedatectl set-timezone Asia/Shanghai
echo '
1 3 * * * root reboot' >> /etc/crontab
echo '每天凌晨3点重启服务器
当前时间是：'
date
