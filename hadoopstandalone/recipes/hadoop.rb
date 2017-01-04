#
# Cookbook:: hadoopstandalone
# Recipe:: hadoop
#
# Copyright:: 2016, The Authors, All Rights Reserved.

package "default-jdk" do
   action :install
   options '--force-yes'
end

remote_file "/home/ubuntu/hadoop-2.7.3.tar.gz" do
   source "http://www-eu.apache.org/dist/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz"
   mode "0755"
   action :create
end

execute "extract_hadoop_tar" do
   command "tar xzvf hadoop-2.7.3.tar.gz"
   cwd "/home/ubuntu/"
   not_if { File.exists?("/home/ubuntu/hadoop") }
end

execute "copy_hadoop_files" do
   command "mv /home/ubuntu/hadoop-2.7.3 /usr/local/hadoop/"
   group "root"
   not_if { File.exists?("/usr/local/hadoop") }
end

ruby_block "hadoop-env.sh" do
   block do
    file = Chef::Util::FileEdit.new("/usr/local/hadoop/etc/hadoop/hadoop-env.sh")
#    file.search_file_replace_line("export\\s+JAVA_HOME=\\$\\{JAVA_HOME\\}","export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")")
    file.search_file_replace_line("export\\s+JAVA_HOME=\\$\\{JAVA_HOME\\}","export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/")
    file.write_file
   end
end

execute "hadoop_Running" do
   command "/usr/local/hadoop/bin/hadoop"
end

%w[ /testhadoop /testhadoop/input ].each do |path|
   directory path do
   owner 'root'
   group 'root'
   mode '0755'
  end
end

execute "copy xml files" do
   command "cp /usr/local/hadoop/etc/hadoop/*.xml /testhadoop/input/"
   group "root"
   not_if { File.exists?("/testhadoop/input/*.xml") }
end

execute "hadoop_input" do
   command "/usr/local/hadoop/bin/hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar grep /testhadoop/input ~/grep_example 'principal[.]*'"
end

execute "hadoop_output" do
   command "cat ~/grep_example/*"
end