#
# Cookbook Name:: cloudera-hadoop
# Recipe:: core-cleanup-cron
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#

#  
#
################################################################################
#  Install the cron to clean up Impala core dumps.
################################################################################
cron "Delete_Impala_Daemon_Core_Dumps" do
   minute 0
   hour 3
   command "/usr/bin/rm -rf /var/log/impalad/core.*  > /dev/null 2>&1"
   user "root"
end
