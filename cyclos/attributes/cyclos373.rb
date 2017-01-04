#attirbutes for Java recipe.

#attributes for Tomcat recipe.
default['cyclos']['tomcat']['useradd'] = 'tomcat'
default['cyclos']['tomcat']['groupadd'] = 'tomcat'
default['cyclos']['tomcat']['remote_file_path'] = '/home/ubuntu/apache-tomcat-8.5.9.tar.gz'
default['cyclos']['tomcat']['remote_file_location'] = 'http://www-eu.apache.org/dist/tomcat/tomcat-8/v8.5.9/bin/apache-tomcat-8.5.9.tar.gz'
default['cyclos']['tomcat']['tomcatusersxml'] = '/opt/tomcat/conf/tomcat-users.xml'
default['cyclos']['tomcat']['hostmanagercontext'] = '/opt/tomcat/webapps/host-manager/META-INF/context.xml'
default['cyclos']['tomcat']['managercontext'] = '/opt/tomcat/webapps/manager/META-INF/context.xml'
default['cyclos']['tomcat']['webxmlpath'] = '/opt/tomcat/webapps/manager/WEB-INF/web.xml'
default['cyclos']['tomcat']['tomcatservicefile'] = '/etc/systemd/system/tomcat.service'
default['cyclos']['tomcat']['tomcatextarctedpath'] = '/home/ubuntu/apache-tomcat-8.5.9'
default['cyclos']['tomcat']['tomcatinsatlledpath'] = '/opt/tomcat/'

#Attributes for Mysql recipe.
default['cyclos']['mysql']['admin_username'] = 'cyclos'
default['cyclos']['mysql']['admin_password'] = 'cyclos1234'
default['cyclos']['mysql']['root_username'] = 'root'
default['cyclos']['mysql']['root_password'] = 'cyclos1234'
default['cyclos']['mysql']['databasename'] = 'cyclos3'
default['cyclos']['mysql']['host'] = '127.0.0.1'
default['cyclos']['mysql']['port'] = '3306'
default['cyclos']['mysql']['bind_address'] = '0.0.0.0'

# Attributes for Cyclos recipe.
default['cyclos']['cyclos']['cyclosfilepath'] = '/home/ubuntu/cyclos_3.7.3.zip'
default['cyclos']['cyclos']['cyclosfileloaction'] = 'http://excellmedia.dl.sourceforge.net/project/cyclos/Cyclos3/3.7.3/cyclos_3.7.3.zip'
default['cyclos']['cyclos']['cyclosunzippath'] = '/home/ubuntu/cyclos_3.7.3'
default['cyclos']['cyclos']['webcopiedtocyclos'] = '/opt/tomcat/webapps/cyclos/'
default['cyclos']['cyclos']['cyclospropertiespath'] = '/opt/tomcat/webapps/cyclos/WEB-INF/classes/cyclos.properties'
