#
# Cookbook Name:: cloudera-hadoop
# Recipe:: cdh5-hosts-file-prod
#
# Copyright 2016, EBATES
#
# All rights reserved - Do Not Redistribute
#
#

################################################################################
#  Install QA Hadoop cluster /etc/hosts file
################################################################################

cookbook_file "/etc/hosts" do
   mode "0644"
   source "hosts-qa"
end
