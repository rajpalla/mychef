#
# Cookbook:: .
# Recipe:: webapp
#
# Copyright:: 2016, The Authors, All Rights Reserved.

package 'default-jdk' do
  action :install
  options '--force-yes'
end

user node['openmrs']['webapp']['useradd'] do
  comment 'A tomcat user'
  home '/home/ubuntu'
  shell '/bin/bash'
end

group node['openmrs']['webapp']['groupadd'] do
  action :create
  members 'tomcat'
  append true
end

remote_file node['openmrs']['webapp']['remote_file_path'] do
  source node['openmrs']['webapp']['remote_file_location']
  mode '0775'
  action :create
  not_if { File.exist?(node['openmrs']['webapp']['remote_file_path']) }
end

execute 'extract_tomcat_tar' do
  command 'tar xzvf apache-tomcat-8.5.9.tar.gz'
  cwd '/home/ubuntu/'
  not_if { File.exist?(node['openmrs']['webapp']['tomcatextarctedpath']) }
end

execute 'copy_tomcat_files' do
  command 'mv /home/ubuntu/apache-tomcat-8.5.9 /opt/tomcat/'
  group 'root'
  not_if { File.exist?(node['openmrs']['webapp']['tomcatinsatlledpath']) }
end

%w[ /opt /opt/tomcat /opt/tomcat/bin/ /opt/tomcat/conf/ /opt/tomcat/work/ /opt/tomcat/webapps/ /opt/tomcat/logs/ /opt/tomcat/lib/ /opt/tomcat/temp/ ].each do |path|
  directory path do
    owner 'tomcat'
    group 'tomcat'
    mode '0775'
    action :create
  end
end

execute 'chown_bin' do
  command 'sudo chown -R tomcat:tomcat /opt/tomcat/*'
  action :run
end

cookbook_file node['openmrs']['webapp']['tomcatservicefile'] do
  source 'tomcat.service'
  owner 'tomcat'
  group 'tomcat'
  mode '0775'
  action :create_if_missing
end

execute 'restart_deamon' do
  command 'systemctl daemon-reload'
end

service 'tomcat' do
  supports :status => true, :restart => true, :reload => true, :stop => true
  action [:enable, :restart]
end

cookbook_file node['openmrs']['webapp']['tomcatusersxml'] do
  source 'tomcat-users.xml'
  mode '0775'
  owner 'tomcat'
  group 'tomcat'
  action :create
end

cookbook_file node['openmrs']['webapp']['hostmanagercontext'] do
  source 'context.xml'
  owner 'tomcat'
  group 'tomcat'
  mode '0775'
  action :create
end

cookbook_file node['openmrs']['webapp']['managercontext'] do
  source 'context.xml'
  owner 'tomcat'
  group 'tomcat'
  mode '0775'
  action :create
end

ruby_block 'filesizelimit' do
  block do
    file = Chef::Util::FileEdit.new(node['openmrs']['webapp']['webxmlpath'])
    file.search_file_replace_line('<max-file-size>52428800<\\/max-file-size>','<max-file-size>104857600</max-file-size>')
    file.search_file_replace_line('<max-request-size>52428800<\\/max-request-size>','<max-request-size>104857600</max-request-size>')
    file.write_file
  end
end

