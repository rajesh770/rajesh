#
# Cookbook Name:: cloudera-hadoop
# Recipe:: sysctl.conf
#
# Copyright 2016, EBATES
#
# All rights reserved - Do Not Redistribute
#
#

################################################################################
#  Update sysctl.conf params
################################################################################

node.default['sysctl']['params']['vm']['swappiness'] = 0

cookbook_file "/etc/security/limits.conf" do
   mode "0644"
   source "limits.conf"
end

cookbook_file "/etc/sysctl.d/100-hdp.conf" do
   mode "0644"
   source "100-hdp.conf"
end

include_recipe 'sysctl::apply'
