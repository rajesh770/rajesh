################################################################################
#  Create all necessary groups
################################################################################

users_manage "flume" do
  group_id 603
  action [ :remove, :create ]
end

users_manage "hdfs" do
  group_id 600
  action [ :remove, :create ]
end

users_manage "hive" do
  group_id 605
  action [ :remove, :create ]
end

users_manage "hue" do
  group_id 608
  action [ :remove, :create ]
end

users_manage "mapred" do
  group_id 602
  action [ :remove, :create ]
end

users_manage "oozie" do
  group_id 609
  action [ :remove, :create ]
end

users_manage "sentry" do
  group_id 604
  action [ :remove, :create ]
end

users_manage "solr" do
  group_id 611
  action [ :remove, :create ]
end

users_manage "spark" do
  group_id 607
  action [ :remove, :create ]
end

users_manage "sqoop2" do
  group_id 606
  action [ :remove, :create ]
end

users_manage "yarn" do
  group_id 601
  action [ :remove, :create ]
end
