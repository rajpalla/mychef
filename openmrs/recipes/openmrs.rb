#
# Cookbook:: .
# Recipe:: openmrs
#
# Copyright:: 2017, The Authors, All Rights Reserved.

cookbook_file node['openmrs']['openmrs']['openmrsfilepath'] do
  source 'openmrs.war'
  owner 'tomcat'
  group 'tomcat'
  mode '0775'
  action :create
end

directory node['openmrs']['openmrs']['openmrssetuppath'] do
  owner 'root'
  group 'root'
  mode '0775'
  action :create
end

#file node['openmrs']['openmrs']['runtimepropertiesfilepath'] do
 # owner 'tomcat'
  #group 'tomcat'
  #mode '0775'
  #action :create
#end

#cookbook_file node['openmrs']['openmrs']['runtimepropertiesfilepath'] do
 # source 'openmrs-runtime.properties'
  #owner 'tomcat'
  #group 'tomcat'
  #mode '0775'
  #action :create
#end

#directory "#{node['openmrs']['webapp']['.openmrspathpermissions']}/.openmrs" do
 # owner 'tomcat'
  #group 'tomcat'
  #mode '0775'
  #action :create
#end

service 'tomcat' do
  supports :status => true, :restart => true, :reload => true, :stop => true
  action [:enable, :restart]
end