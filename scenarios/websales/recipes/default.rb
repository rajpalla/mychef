#
# Cookbook:: websales
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

user 'webapp' do
  comment 'A user named webapp'
  uid '1234'
  gid '1234'
  home '/home/webapp'
  shell '/bin/bash'
  password 'password'
  action :create
end

group 'application' do
  members 'webapp'
  action :create
end

directory '/opt/app/webapp' do
  owner 'webapp'
  group 'application'
  mode '0755'
  action :create
end

