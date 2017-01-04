#
# Cookbook:: tomcat714jenkinswar
# Recipe:: tomcat714
#
# Copyright:: 2016, The Authors, All Rights Reserved.

package [ 'tree', 'apache2', 'default-jdk', 'git', 'maven', 'tomcat7', 'tomcat7-docs', 'tomcat7-admin', 'tomcat7-examples']

cookbook_file '/var/www/html/index.html' do
   source 'index.html'
   mode '755'
end

cookbook_file '/etc/tomcat7/tomcat-users.xml' do
  source 'tomcat-users.xml'
  mode '0755'
  owner 'root'
  group 'root'
  action :create
end

service 'tomcat7' do
  supports :status => true, :stop => true, :restart => true, :reload => true
  action [ :enable, :restart ]
end

# %w[ /var /var/lib /var/lib/tomcat7 /var/lib/tomcat7/webapps /var/lib/tomcat7/webapps/jenkins ].each do |path|
#  directory path do
#    owner 'tomcat7'
#    group 'tomcat7'
#    mode '0775'
#    action :create
#  end
# end

remote_file '/var/lib/tomcat7/webapps/jenkins.war' do
  source 'http://mirrors.jenkins-ci.org/war/latest/jenkins.war'
  owner 'root'
  group 'root'
  mode '0775'
end

%w[ /usr /usr/share /usr/share/tomcat7 /usr/share/tomcat7/.jenkins ].each do |path|
  directory path do
    owner 'tomcat7'
    group 'tomcat7'
    mode '0775'
    action :create
  end
end

service 'tomcat7' do
    supports :status => true, :stop => true, :restart => true, :reload => true
    action [ :enable, :start ]
end