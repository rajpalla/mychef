case node['platform']
when 'ubuntu', 'debian'
    case node['platform_version']
    when '16.04'
        default['tomcatallinone']['testapp'] = 'apache2'
        default['tomcatallinone']['mainapp'] = 'tomcat8'
        default['tomcatallinone']['extraapps'] = ['default-jdk', 'maven', 'tomcat8-docs', 'tomcat8-admin', 'tomcat8-examples']
        default['mainapp']['usersxmlfle'] = '/etc/tomcat8/tomcat-users.xml'
        default['mainapp']['jenkinswarfile'] = '/var/lib/tomcat8/webapps/jenkins.war'
        default['mainapp']['testwar'] = '/var/lib/tomcat8/webapps/benefits.war'
        default['mainapp']['.jenkinspathpermissions'] = '/usr/share/tomcat8'
        default['mainapp']['ownerpermission'] = 'tomcat8'
        default['mainapp']['grouppermission'] = 'tomcat8'
    when '14.04'
        default['tomcatallinone']['testapp'] = 'apache2'
        default['tomcatallinone']['mainapp'] = 'tomcat7'
        default['tomcatallinone']['extraapps'] = [ 'default-jdk', 'apache2', 'maven', 'tomcat7-docs', 'tomcat7-admin', 'tomcat7-examples']
        default['mainapp']['usersxmlfle'] = '/etc/tomcat7/tomcat-users.xml'
        default['mainapp']['jenkinswarfile'] = '/var/lib/tomcat7/webapps/jenkins.war'
        default['mainapp']['testwar'] = '/var/lib/tomcat7/webapps/benefits.war'
        default['mainapp']['.jenkinspathpermissions'] = '/usr/share/tomcat7'
        default['mainapp']['ownerpermission'] = 'tomcat7'
        default['mainapp']['grouppermission'] = 'tomcat7'
     end
when 'centos', 'rhel'
    default['tomcatallinone']['testapp'] = 'httpd'
    default['tomcatallinone']['mainapp'] = 'tomcat'
    default['tomcatallinone']['extraapps'] = ['maven', 'tomcat-webapps', 'tomcat-admin-webapps', 'tomcat-docs-webapp', 'tomcat-javadoc']
    default['mainapp']['usersxmlfle'] = '/usr/share/tomcat/conf/tomcat-users.xml'
    default['mainapp']['jenkinswarfile'] = '/usr/local/bin/jenkins.war'
    default['mainapp']['testwar'] = '/usr/local/bin/benefits.war'
    default['mainapp']['.jenkinspathpermissions'] = '/usr/share/tomcat'
    default['mainapp']['ownerpermission'] = 'tomcat'
    default['mainapp']['grouppermission'] = 'tomcat'
end

default['testapp']['customhtml'] = 'var/www/html/index.html'
default['mainapp']['remotewarloaction'] = 'http://mirrors.jenkins-ci.org/war/latest/jenkins.war'

default['mainapp']['username'] = 'admin'
default['mainapp']['password'] = 'password'
default['mainapp']['roles'] = 'manager-gui','admin-gui'

