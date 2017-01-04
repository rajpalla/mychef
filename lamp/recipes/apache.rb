#
# Cookbook:: .
# Recipe:: apache
#
# Copyright:: 2016, The Authors, All Rights Reserved.

package 'apache2' do
    action :install
end

service 'apache2' do
    action [ :enable, :start]
end

%w[ /var /var/www /var/www/gvkmall.com /var/www/gvkmall.com/public_html ].each do |path|
 directory path do
    owner 'root'
    group 'root'
    mode '0755'
 end
end

%w[ /var /var/www /var/www/inorbitmall.com /var/www/inorbitmall.com/public_html ].each do |path|
  directory path do
    owner 'root'
    group 'root'
    mode '0755'
  end
end

cookbook_file '/var/www/gvkmall.com/public_html/index.html' do
    source 'index.html'
    owner 'root'
    group 'root'
    mode '755'
    action :create
end

cookbook_file '/var/www/inorbitmall.com/public_html/index.html' do
    source 'index1.html'
    owner 'root'
    group 'root'
    mode '755'
    action :create
end
 
cookbook_file '/etc/apache2/sites-available/gvkmall.com.conf' do
    source 'gvkmall.com.conf'
    owner 'root'
    group 'root'
    mode '755'
    action :create
end

cookbook_file '/etc/apache2/sites-available/inorbitmall.com.conf' do
    source 'inorbitmall.com.conf'
    owner 'root'
    group 'root'
    mode '755'
    action :create
end

execute 'enable_sites & disbale_default_site' do
    command 'a2ensite gvkmall.com.conf'
    command 'a2ensite inorbitmall.com.conf'
    command 'a2dissite 000-default.conf'
    notifies :restart, :service => 'apache2'
end