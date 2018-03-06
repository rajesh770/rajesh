#
# Cookbook Name:: cloudera-hadoop
# Recipe:: cdh5-network-settings
#
# Copyright 2016, EBATES
#
# All rights reserved - Do Not Redistribute
#
#

#  Install cloudera-cdh5
#
################################################################################
#  Update network/NIC settings and various SYSCTL params
################################################################################
node.default['sysctl']['params']['vm']['swappiness'] = ['0']

cookbook_file "/etc/sysctl.d/99-ipv4-tuning.conf" do
   mode "0644"
   source "99-ipv4-tuning.conf"
end

execute "grubby" do
   command 'grubby --update-kernel=ALL --args="elevator=cfq"'
   action :run
end

execute "grubby" do
   command 'grubby --update-kernel=ALL --args="ipv6.disable=1"'
   action :run
end
