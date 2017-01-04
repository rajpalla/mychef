#
# Cookbook:: .
# Recipe:: mysql
#
# Copyright:: 2016, The Authors, All Rights Reserved.

mysql_client 'default' do
  action :create
end

mysql_service 'default' do
  port node['cyclos']['mysql']['port']
  bind_address node['cyclos']['mysql']['bind-address']
  initial_root_password node['cyclos']['mysql']['root_password']
  action [:create, :start]
end

mysql2_chef_gem 'default' do
  action :install
end

mysql_collection_info = {
  :host  =>  node['cyclos']['mysql']['host'],
  :username  =>  node['cyclos']['mysql']['root_username'],
  :password  =>  node['cyclos']['mysql']['root_password'],
}

mysql_database node['cyclos']['mysql']['databasename'] do
  connection mysql_collection_info
  action :create
end

mysql_database_user node['cyclos']['mysql']['admin_username'] do
  connection mysql_collection_info
  password node['cyclos']['mysql']['admin_password']
  database_name node['cyclos']['mysql']['databasename']
  host '%'
  action [:create, :grant]
end

mysql_database node['cyclos']['mysql']['databasename'] do
  connection mysql_collection_info
  sql 'flush privileges'
  action :query
end
