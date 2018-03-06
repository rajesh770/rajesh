#
# Cookbook Name:: cloudera-hadoop
# Recipe:: cdh5-datanode
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

%w{ hadoop-yarn-nodemanager hadoop-hdfs-datanode hadoop-mapreduce }.each do |rpm|
   yum_package "#{rpm}" do
      action [:upgrade, :install]
   end
end

yum_repository "cloudera-cdh5" do
   enabled 0
   action :update
end
