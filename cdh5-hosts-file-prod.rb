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
