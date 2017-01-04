#
# Cookbook:: .
# Recipe:: mysql
#
# Copyright:: 2016, The Authors, All Rights Reserved.

mysql_client 'default' do
  action :create
end

mysql_service 'default' do
  port node['openmrs']['mysql']['port']
  bind_address node['openmrs']['mysql']['bind-address']
  initial_root_password node['openmrs']['mysql']['root_password']
  action [:create, :start]
end

mysql2_chef_gem 'default' do
  action :install
end

mysql_collection_info = {
  :host  =>  node['openmrs']['mysql']['host'],
  :username  =>  node['openmrs']['mysql']['root_username'],
  :password  =>  node['openmrs']['mysql']['root_password'],
}

mysql_database node['openmrs']['mysql']['databasename'] do
  connection mysql_collection_info
  action :create
end

mysql_database_user node['openmrs']['mysql']['admin_username'] do
  connection mysql_collection_info
  password node['openmrs']['mysql']['admin_password']
  database_name node['openmrs']['mysql']['databasename']
  host '%'
  action [:create, :grant]
end

mysql_database node['openmrs']['mysql']['databasename'] do
  connection mysql_collection_info
  sql 'flush privileges'
  action :query
end
