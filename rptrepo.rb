repo=['CentOS-Base.repo' 'cloudera-manager.repo' 'cloudera-manager.repo' 'epel.repo' 'sensu.repo']
for i in repo;
  file '/etc/yum.repo.d/$repo' do
    action :delete
end

#Add the files in yum.repo.d directory
yum_repository 'cloudera-manager' do
  description "Cloudera Manager, Version 5.12.0"
  baseurl "http://sf1-yum2.ebates.int/cloudera/cm5/redhat/x86_64/cm/5.12.0/"
  gpgcheck true
  gpgkey "https://archive.cloudera.com/redhat/cdh/RPM-GPG-KEY-cloudera"
  action [:create, :add]
end

file '/etc/yum.repos.d/CentOS-Base.repo' do
 content '[base]
name=CentOS-$releasever - Base
baseurl=http://sf1-yum2.ebates.int/centos/7.3/os/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#released updates
[updates]
name=CentOS-$releasever - Updates
baseurl=http://sf1-yum2.ebates.int/centos/7.3/updates/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that may be useful
[extras]
name=CentOS-$releasever - Extras
baseurl=http://sf1-yum2.ebates.int/centos/7.3/extras/$basearch/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-$releasever - Plus
baseurl=http://sf1-yum2.ebates.int/centos/7.3/centosplus/$basearch/
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7'
mode '644'
owner 'root'
group 'root'
action :create
end

yum_repository 'cloudera-cdh5' do
  description "Cloudera's Distribution for Hadoop, Version 5"
  baseurl "http://sf1-yum2.ebates.int/cloudera/cdh5/redhat/$basearch/cdh/5.10.0"
  gpgcheck true
  enabled true
  gpgkey "http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera"
  action [:create, :add]
end

file '/etc/yum.repos.d/epel.repo' do
 content '[epel]
name=Extra Packages for Enterprise Linux-7
baseurl=http://sf1-yum2.ebates.int/epel/7/x86_64/
failovermethod=priority
enabled=1
gpgcheck=0

[epel-debuginfo]
name=Extra Packages for Enterprise Linux 7 - x86_64 - Debug
baseurl=http://sf1-yum2.ebates.int/epel/7/x86_64/debug
failovermethod=priority
enabled=0
gpgcheck=0

[epel-source]
name=Extra Packages for Enterprise Linux 7 - x86_64 - Source
baseurl=http://sf1-yum2.ebates.int/epel/7/x86_64/SRPMS
failovermethod=priority
enabled=0
gpgcheck=0 '
mode '644'
owner 'root'
group 'root'
action :create
end

yum_repository 'sensu' do
  description "sensu monitoring"
  baseurl "http://sf1-yum2.ebates.int/sensu/yum/$releasever/$basearch/"
  gpgcheck false
  enabled true
  action [:create, :add]
end

execute 'yum clean' do
  command 'yum clean all'
end
end
