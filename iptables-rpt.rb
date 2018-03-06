#
# Cookbook Name:: cloudera-hadoop
# Recipe:: iptable-rpt
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

#  Setup the iptables
#

################################################################################
#  Update iptables
################################################################################i

### iptable roles for RPT cluster
yum_package 'iptables-services' do
    action [:install, :upgrade]
end
# Adding the roles to iptables config file
file '/etc/sysconfig/iptables' do
  content "
# Generated by iptables-save v1.4.21 on Mon Jan 22 10:06:46 2018
*filter
:INPUT DROP [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT DROP [0:0]
:LOGINPUT - [0:0]
:LOGOUTPUT - [0:0]
-A INPUT -s 10.10.12.0/24 -p tcp -m multiport --sports 21000,21050,8888,10002,8088,19886,18088 -j ACCEPT
-A INPUT -s 127.0.0.1/32 -j ACCEPT
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -s 10.10.121.0/24 -j ACCEPT
-A INPUT -s 10.10.12.0/24 -j ACCEPT
-A INPUT -s 10.10.19.0/24 -j ACCEPT
-A INPUT -s 10.10.10.0/24 -j ACCEPT
-A INPUT -s 10.11.19.0/24 -j ACCEPT
-A INPUT -s 10.140.0.0/16 -j ACCEPT
-A INPUT -s 10.60.24.0/23 -j ACCEPT
-A INPUT -s 10.60.32.0/24 -j ACCEPT
-A INPUT -s 10.60.0.0/25 -j ACCEPT
-A INPUT -j LOGINPUT
-A OUTPUT -o lo -j ACCEPT
-A OUTPUT -d 10.140.0.0/16 -j ACCEPT
-A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A OUTPUT -p icmp -m icmp --icmp-type 0 -j ACCEPT
-A OUTPUT -p tcp -m tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
-A OUTPUT -p tcp -m tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
-A OUTPUT -p tcp -m tcp --dport 25 -m state --state NEW -j ACCEPT
-A OUTPUT -d 10.140.0.0/16 -j ACCEPT
-A OUTPUT -d 10.60.24.0/23 -j ACCEPT
-A OUTPUT -d 10.10.121.0/24 -j ACCEPT
-A OUTPUT -d 10.10.19.0/24 -j ACCEPT
-A OUTPUT -d 10.10.10.0/24 -j ACCEPT
-A OUTPUT -d 10.10.12.0/24 -j ACCEPT
-A OUTPUT -d 10.60.0.0/25 -j ACCEPT
-A OUTPUT -d 10.60.32.0/24 -j ACCEPT
-A OUTPUT -d 10.11.19.0/24 -j ACCEPT
-A OUTPUT -d 10.10.18.0/24 -p tcp -m multiport --dports 50010,50020,8020,7180 -j ACCEPT
-A OUTPUT -j LOGOUTPUT
-A LOGINPUT -m limit --limit 1/min -j LOG --log-prefix \"INPUT DROP: \" --log-level 7
-A LOGOUTPUT -m limit --limit 1/min -j LOG --log-prefix \"OUTPUT DROP: \" --log-level 7
COMMIT
"
end
# Adding rotate file
file '/etc/logrotate.d/iptables' do
  content '/var/log/iptables {
    rotate 10
    size 500k
    postrotate
        # before using this, run the command yourself to make sure
        # it is right... the daemon name may vary
        /usr/bin/killall -HUP rsyslogd
    endscript
}'
mode '644'
owner 'root'
group 'root'
action :create_if_missing
end
# setuping in rsyslog file
file '/etc/rsyslog.d/iptables.conf' do
  content 'kern.debug /var/log/iptables
# File access file:
$ModLoad imfile
$InputFileName /var/log/iptables
$InputFileTag iptables
$InputFileStateFile iptables
$InputFileSeverity info
$InputRunFileMonitor
$InputFilePersistStateInterval 2000
:syslogtag, contains, "iptables" @@sf1-bigdata-syslog.ebates.int:514
:syslogtag, contains, "iptables" stop'
mode '644'
owner 'root'
group 'root'
action :create_if_missing
end
# restarting ryslog service
service 'rsyslog' do
  action :restart
end

service 'iptables' do
  action [:enable, :start, :reload]
end

execute 'iptables saving' do
  command 'service iptables save'
end
