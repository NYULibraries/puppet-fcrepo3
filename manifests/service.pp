#
class fedora_repository::service (
  $user = $fedora_repository::params::user,
) inherits fedora_repository::params {

  # install the service script
  file { "/etc/init.d/${user}_tomcat" :
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("${module_name}/fedora_tomcat.erb"),
    require => Class["${module_name}::install"],
  }

  service { "${user}_tomcat" :
    ensure     => 'running',
    enable     => true,
    hasstatus  => false,
    hasrestart => false,
    provider   => 'redhat',
    require    => [Class["${module_name}::install"],
                  File["/etc/init.d/${user}_tomcat"]],
    #require    => [File['/etc/init.d/tomcat'],
    #    File["${install_dir}/.setup-database.complete"]],
  }

}
