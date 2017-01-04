#
# Cookbook:: cyclos
# Recipe:: default
#
# Copyright:: 2016, The Authors, All Rights Reserved.

include_recipe 'cyclos::java'
include_recipe 'cyclos::apache2'
include_recipe 'cyclos::tomcat'
include_recipe 'cyclos::mysql'
include_recipe 'cyclos::cyclos'


