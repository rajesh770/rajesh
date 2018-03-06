#
# Cookbook Name:: cloudera-hadoop
# Recipe:: cdh5-all
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

#  Install cloudera-cdh5
#

################################################################################
#  Update sysctl.conf params
################################################################################

node.default['sysctl']['params']['vm']['swappiness'] = 0
include_recipe 'sysctl::apply'

##################################################
#
# Add in standard Hadoop users
#
##################################################

group 'hadoop' do
  action :create
  gid    494
  append true
end

users_manage "flume" do
  data_bag "hadoop"
  group_id 603
  action [ :remove, :create ]
end
users_manage "hdfs" do
  data_bag "hadoop"
  group_id 600
  action [ :remove, :create ]
end
users_manage "hive" do
  data_bag "hadoop"
  group_id 605
  action [ :remove, :create ]
end
users_manage "hue" do
  data_bag "hadoop"
  group_id 608
  action [ :remove, :create ]
end
users_manage "mapred" do
  data_bag "hadoop"
  group_id 602
  action [ :remove, :create ]
end
users_manage "oozie" do
  data_bag "hadoop"
  group_id 609
  action [ :remove, :create ]
end
users_manage "sentry" do
  data_bag "hadoop"
  group_id 604
  action [ :remove, :create ]
end
users_manage "solr" do
  data_bag "hadoop"
  group_id 611
  action [ :remove, :create ]
end
users_manage "spark" do
  data_bag "hadoop"
  group_id 607
  action [ :remove, :create ]
end
users_manage "sqoop2" do
  data_bag "hadoop"
  group_id 606
  action [ :remove, :create ]
end
users_manage "yarn" do
  data_bag "hadoop"
  group_id 601
  action [ :remove, :create ]
end
users_manage "hdpprod" do
  data_bag "hadoop"
  group_id 2001
  action [  :create ]
end

################################################################################
#  Install Custom Repositories and Packages
################################################################################

directory "/usr/local/nagios" do
   owner "nagios"
   group "nagios"
   mode "0755"
   recursive true
   action :create
end

cookbook_file "/etc/init.d/hadoop-cfg" do
   mode "0755"
   source "hadoop-cfg"
end

cookbook_file "/etc/rc.local" do
   mode "0755"
   source "rc.local"
end

execute "grubby" do
   command 'grubby --update-kernel=ALL --args="elevator=cfq"'
   action :run
end

execute "chkconfig" do
   command "/sbin/chkconfig --add hadoop-cfg"
   action :run
end

cookbook_file "/etc/pki/rpm-gpg/RPM-GPG-KEY-cloudera" do
   mode "0644"
   source "RPM-GPG-KEY-cloudera"
end

cookbook_file "/etc/ntp.conf" do
   mode "0644"
   source "ntp.conf"
end

cookbook_file "/root/python-dateutil-2.4.2.tar.gz" do
   mode "0644"
   source "python-dateutil-2.4.2.tar.gz"
end

cookbook_file "/root/mssql.sh" do
   mode "0755"
   source "mssql.sh"
end

cookbook_file "/root/stomp.py-4.0.14.tar.gz" do
   mode "0644"
   source "stomp.py-4.0.14.tar.gz"
end

cookbook_file "/root/kafka-python-master.zip" do
   mode "0644"
   source "kafka-python-master.zip"
end

cookbook_file "/root/IP2Location-Python-master.zip" do
   mode "0644"
   source "IP2Location-Python-master.zip"
end

cookbook_file "/etc/yum.conf" do
   mode "0644"
   source "yum.conf"
end

cookbook_file "/etc/security/limits.conf" do
   mode "0644"
   source "limits.conf"
end

cookbook_file "/etc/sysctl.d/100-hdp.conf" do
   mode "0644"
   source "100-hdp.conf"
end

cookbook_file "/usr/bin/prd" do
   mode "0755"
   source "prd.sh"
end

#cookbook_file "/etc/sysctl.d/99-ipv4-tuning.conf" do
#   mode "0644"
#   source "99-ipv4-tuning.conf"
#end

yum_repository "cloudera-cdh5" do
  description "Cloudera's Distribution for Hadoop, Version 5"
  url "http://archive.cloudera.com/cdh5/redhat/$releasever/$basearch/cdh/5/"
  enabled true
  make_cache false
  gpgkey "http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera"
  action :add
end

#  Install RPMS via YUM
%w{ epel-release htop cpan readline-devel libtermcap-devel zlib-devel gcc perl-ExtUtils-Embed freetds freetds-devel postgresql-devel postgresql-libs libevent-devel python-devel python-virtualenv gcc-c++ unixODBC-devel python-pip libxml2-devel libxslt-devel python-devel libffi-devel git cyrus-sasl-devel openssl-devel sqlite-devel sshpass }.each do |rpm|
   yum_package "#{rpm}" do
      action [:upgrade, :install]
   end
end

execute "pip_install" do
   command '/usr/bin/pip install -U setuptools'
   action :run
end

#  Install Python packages via PIP
%w{ pip pyasn1 pyasn1-modules pymssql psycopg2 iso8601 pytz circus circus-web chaussette pyyaml ua-parser user-agents cffi requests[security] pyopenssl ndg-httpsclient kafka-python impyla python-dateutil numpy googleads statsmodels discovery http pysftp google-api-python-client }.each do |pkg|
#   python_pip "#{pkg}" do
	python_package "#{pkg}" do
      action [:upgrade, :install]
   end
end



#  Install MS-SQL Drivers
#cookbook_file "/tmp/mssql.sh" do
#   mode "0644"
#   source "mssql.sh"
#end
#execute "/tmp/mssql-sh" do
#   command "/tmp/mssql.sh"
#   creates ""
#   action :run
#end

#  Install IP2Location
#cookbook_file "/tmp/ip2location.sh" do
#   mode "0755"
#   source "ip2location.sh"
#end

#execute "/tmp/ip2location.sh" do
#  command "/tmp/ip2location.sh"
#  creates ""
#  action :run
#end

# Create the directory for the ip2location data file to be rsynced to.
directory "/home/hdpprod/bigdata/data" do
   owner "hdpprod"
   group "hdpprod"
   mode "0755"
   recursive true
   action :create
end

#  Install the cron to clean up Impala core dumps.
cron "Delete_Impala_Daemon_Core_Dumps" do
   minute 0
   hour 3
   command "/usr/bin/rm -rf /var/log/impalad/core.*  > /dev/null 2>&1"
   user "root"
end

################################################################################
#  Install PROD/RPT/QA Hadoop cluster /etc/hosts file
################################################################################
case node.name
when /^sf1-hadoop/, /^sf1-cab1/
   cookbook_file "/etc/hosts" do
   mode "0644"
   source "hosts"
end
when /^sf1-rpt/, /^sf1-cab20/
   cookbook_file "/etc/hosts" do
   mode "0644"
   source "hosts-rpt"
end
when /^qa1-/
   cookbook_file "/etc/hosts" do
   mode "0644"
   source "hosts-qa"
end
end

#  Add the known hosts entry for all Hadoop nodes.
ssh_known_hosts_entry 'sf1-hadoopmgr1.ebates.int'
ssh_known_hosts_entry 'sf1-hadoopnn1.ebates.int'
ssh_known_hosts_entry 'sf1-hadoopnn2.ebates.int'
ssh_known_hosts_entry 'sf1-cab203dn1.ebates.int'
ssh_known_hosts_entry 'sf1-cab203dn2.ebates.int'
ssh_known_hosts_entry 'sf1-cab203dn3.ebates.int'
ssh_known_hosts_entry 'sf1-cab203dn4.ebates.int'
ssh_known_hosts_entry 'sf1-cab203dn5.ebates.int'
ssh_known_hosts_entry 'sf1-cab203dn6.ebates.int'
ssh_known_hosts_entry 'sf1-cab203dn7.ebates.int'
ssh_known_hosts_entry 'sf1-cab203dn8.ebates.int'
ssh_known_hosts_entry 'sf1-cab203dn9.ebates.int'
ssh_known_hosts_entry 'sf1-cab204dn1.ebates.int'
ssh_known_hosts_entry 'sf1-cab204dn2.ebates.int'
ssh_known_hosts_entry 'sf1-cab204dn3.ebates.int'
ssh_known_hosts_entry 'sf1-cab204dn4.ebates.int'
ssh_known_hosts_entry 'sf1-cab204dn5.ebates.int'
ssh_known_hosts_entry 'sf1-cab204dn6.ebates.int'
ssh_known_hosts_entry 'sf1-cab204dn7.ebates.int'
ssh_known_hosts_entry 'sf1-cab204dn8.ebates.int'
ssh_known_hosts_entry 'sf1-cab204dn9.ebates.int'
ssh_known_hosts_entry 'sf1-cab204dn10.ebates.int'
# QA Hadoop
ssh_known_hosts_entry 'qa1-hadoopmgr1.ebates.int'
ssh_known_hosts_entry 'qa1-hadoophue1.ebates.int'
ssh_known_hosts_entry 'qa1-hadoophue2.ebates.int'
ssh_known_hosts_entry 'qa1-hadoopnn1.ebates.int'
ssh_known_hosts_entry 'qa1-hadoopnn2.ebates.int'
ssh_known_hosts_entry 'qa1-cab201dn1.ebates.int'
ssh_known_hosts_entry 'qa1-cab201dn2.ebates.int'
ssh_known_hosts_entry 'qa1-cab201dn3.ebates.int'
ssh_known_hosts_entry 'qa1-cab201dn4.ebates.int'
ssh_known_hosts_entry 'qa1-cab201dn5.ebates.int'
ssh_known_hosts_entry 'qa1-cab201dn6.ebates.int'
ssh_known_hosts_entry 'qa1-cab201dn7.ebates.int'
ssh_known_hosts_entry 'qa1-cab201dn8.ebates.int'
ssh_known_hosts_entry 'qa1-cab202dn1.ebates.int'
ssh_known_hosts_entry 'qa1-cab202dn2.ebates.int'
ssh_known_hosts_entry 'qa1-cab202dn3.ebates.int'
ssh_known_hosts_entry 'qa1-cab202dn4.ebates.int'
ssh_known_hosts_entry 'qa1-cab202dn5.ebates.int'
