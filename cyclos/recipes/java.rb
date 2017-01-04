#
# Cookbook:: .
# Recipe:: java
#
# Copyright:: 2016, The Authors, All Rights Reserved.

execute 'apt-get update' do
  command 'apt-get update'
end

#remote_file '/opt/java/' do
 # source 'http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-linux-x64.tar.gz'
  #owner 'root'
  #group 'root'
  #mode '0755'
  #checksum '187eda2235f812ddb35c352b5f9aa6c5b184d611c2c9d0393afb8031d8198974'
  #action :create
#end
