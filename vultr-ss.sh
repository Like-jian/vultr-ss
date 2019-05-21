# 备份原yum源
mv CentOS-Base.repo CentOS-Base.repo.bak
mv epel.repo epel.repo.bak
echo '[epel]
name=Extra Packages for Enterprise Linux 7 - $basearch
baseurl=http://download.fedoraproject.org/pub/epel/7/$basearch
#metalink=https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch
failovermethod=priority
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7

[epel-debuginfo]
name=Extra Packages for Enterprise Linux 7 - $basearch - Debug
baseurl=http://download.fedoraproject.org/pub/epel/7/$basearch/debug
#metalink=https://mirrors.fedoraproject.org/metalink?repo=epel-debug-7&arch=$basearch
failovermethod=priority
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
gpgcheck=1

[epel-source]
name=Extra Packages for Enterprise Linux 7 - $basearch - Source
baseurl=http://download.fedoraproject.org/pub/epel/7/SRPMS
#metalink=https://mirrors.fedoraproject.org/metalink?repo=epel-source-7&arch=$basearch
failovermethod=priority
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
gpgcheck=1' > /etc/yum.repos.d/epel.repo
# 更换为网易yum源
echo '[base]
name=CentOS-$releasever - Base - 163.com
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os
baseurl=http://mirrors.163.com/centos/$releasever/os/$basearch/
gpgcheck=1
gpgkey=http://mirrors.163.com/centos/RPM-GPG-KEY-CentOS-7

#released updates
[updates]
name=CentOS-$releasever - Updates - 163.com
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates
baseurl=http://mirrors.163.com/centos/$releasever/updates/$basearch/
gpgcheck=1
gpgkey=http://mirrors.163.com/centos/RPM-GPG-KEY-CentOS-7

#additional packages that may be useful
[extras]
name=CentOS-$releasever - Extras - 163.com
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras
baseurl=http://mirrors.163.com/centos/$releasever/extras/$basearch/
gpgcheck=1
gpgkey=http://mirrors.163.com/centos/RPM-GPG-KEY-CentOS-7

#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-$releasever - Plus - 163.com
baseurl=http://mirrors.163.com/centos/$releasever/centosplus/$basearch/
gpgcheck=1
enabled=0
gpgkey=http://mirrors.163.com/centos/RPM-GPG-KEY-CentOS-7' > /etc/yum.repos.d/CentOS-Base.repo 
wget -O /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 https://archive.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7

# 清除yum缓存
yum clean all
yum -y install epel-release
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
# 防火墙开放指定端口 防止没有firewall-cmd命令
iptables -A INPUT -p tcp --dport 30001 -j ACCEPT


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
# 显示当前时间
hwclock -w
timedatectl set-timezone Asia/Shanghai
echo '
1 3 * * * root reboot' >> /etc/crontab
echo '每天凌晨3点重启服务器
当前时间是：'
date
