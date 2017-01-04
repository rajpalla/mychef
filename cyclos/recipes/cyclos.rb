#
# Cookbook:: .
# Recipe:: cyclos
#
# Copyright:: 2016, The Authors, All Rights Reserved.

apt_package [ 'zip', 'unzip' ]

remote_file node['cyclos']['cyclos']['cyclosfilepath'] do
  source node['cyclos']['cyclos']['cyclosfileloaction']
  mode '0775'
  action :create
  not_if { File.exist?(node['cyclos']['cyclos']['cyclosfilepath']) }
end

execute 'extract_cyclos_zip' do
  command 'unzip cyclos_3.7.3.zip'
  cwd '/home/ubuntu/'
  not_if { File.exist?(node['cyclos']['cyclos']['cyclosunzippath']) }
end

execute 'cyclos_web_webapps' do
  command 'mv /home/ubuntu/cyclos_3.7.3/web /opt/tomcat/webapps/cyclos'
  group 'root'
  not_if { File.exist?(node['cyclos']['cyclos']['webcopiedtocyclos']) }
end

execute 'chown_bin' do
  command 'sudo chown -R tomcat:tomcat /opt/tomcat/webapps/cyclos /opt/tomcat/webapps/cyclos/*'
  action :run
end

ruby_block 'edit_cyclos_db_properties' do
  block do
    file = Chef::Util::FileEdit.new(node['cyclos']['cyclos']['cyclospropertiespath'])
    file.search_file_replace_line('hibernate\\.connection\\.username\\s+=\\s+root', 'hibernate.connection.username = cyclos')
    file.search_file_replace_line('hibernate\\.connection\\.password\\s+=', 'hibernate.connection.password = cyclos1234')
    file.write_file
  end
end



