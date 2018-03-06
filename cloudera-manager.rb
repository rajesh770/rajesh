#
# Cookbook Name:: cloudera-hadoop
# Recipe:: cdh5-resource-manager
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

#  Install cloudera-cdh5
#
################################################################################
#  Install CDH Packages
################################################################################

yum_repository "cloudera-cdh5" do
   enabled 1
   action :update
end

execute "/usr/bin/yum clean all" do 
   action :run
end

%w{ hadoop-yarn-resourcemanager hadoop-mapreduce-historyserver hadoop-yarn-proxyserver }.each do |rpm|
   yum_package "#{rpm}" do
      action [:upgrade, :install]
   end
end

yum_repository "cloudera-cdh5" do
   enabled 0
   action :update
end
