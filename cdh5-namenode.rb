#
# Cookbook Name:: cloudera-hadoop
# Recipe:: cdh5-namenode
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

cookbook_file "/etc/yum.conf" do
   mode "0644"
   source "yum.conf"
end

cookbook_file "/etc/sysctl.d/99-ipv4-tuning.conf" do
   mode "0644"
   source "99-ipv4-tuning.conf"
end

yum_repository "cloudera-cdh5" do
  description "Cloudera's Distribution for Hadoop, Version 5"
  url "http://archive.cloudera.com/cdh5/redhat/$releasever/$basearch/cdh/5/"
  enabled true
  make_cache false
  gpgkey "http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera"
  action :add
end

#  Install RPMS via YUM
%w{ htop cpan readline-devel libtermcap-devel zlib-devel gcc perl-ExtUtils-Embed freetds freetds-devel postgresql-devel postgresql-libs libevent-devel python-devel python-virtualenv gcc-c++ unixODBC-devel python-pip libxml2-devel libxslt-devel python-devel libffi-devel git cyrus-sasl-devel openssl-devel sqlite-devel }.each do |rpm|
   yum_package "#{rpm}" do
      action [:upgrade, :install]
   end
end
