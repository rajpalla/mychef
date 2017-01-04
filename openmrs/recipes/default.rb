#
# Cookbook:: openmrs
# Recipe:: default
#
# Copyright:: 2016, The Authors, All Rights Reserved.

include_recipe 'apt::default'
include_recipe 'openmrs::webapp'
include_recipe 'openmrs::mysql'
include_recipe 'openmrs::openmrs'
