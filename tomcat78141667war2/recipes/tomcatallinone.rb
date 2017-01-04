#
# Cookbook:: .
# Recipe:: tomcatallinone
#
# Copyright:: 2016, The Authors, All Rights Reserved.

my_packageName = node['tomcatallinone']['testapp']
package my_packageName do
  action :install
end

tomcat_packageName = node['tomcatallinone']['mainapp']
package tomcat_packageName do
  action :install
end
   
service tomcat_packageName do
  action [:enable, :start]
end

package node['tomcatallinone']['extraapps'] do
  action :install
  notifies :restart, "service[#{tomcat_packageName}]"
end

cookbook_file node['testapp']['customhtml'] do
  source 'index.html'
  owner 'root'
  group 'root'
  mode '755'
  action :create
end

cookbook_file node['mainapp']['usersxmlfle'] do
  source 'tomcat-users.xml'
  mode '0755'
  owner 'root'
  group 'root'
  action :create
  notifies :restart, "service[#{tomcat_packageName}]"
end

remote_file node['mainapp']['jenkinswarfile'] do
  source node['mainapp']['remotewarloaction']
  owner 'root'
  group 'root'
  mode '0775'
end

cookbook_file node['mainapp']['testwar'] do
  source 'benefits.war'
  owner 'root'
  group 'root'
  mode '0775'
end

directory "#{node['mainapp']['.jenkinspathpermissions']}/.jenkins" do
    owner node['mainapp']['ownerpermission'] 
    group node['mainapp']['grouppermission']
    mode '0775'
    action :create
    notifies :restart, "service[#{tomcat_packageName}]"
end