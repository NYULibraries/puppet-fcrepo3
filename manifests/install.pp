# == Class: fedora_repository
#
# Full description of class fedora_repository here.
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
#
# command to download from nexus
# wget "http://172.28.128.11:8081/nexus/service/local/artifact/maven/content?r=central&g=org.fcrepo&a=fcrepo-installer&v=3.7.1" --content-disposition
#
class fedora_repository::install (
  $comment          = $fedora_repository::params::comment,
  $group_id         = $fedora_repository::params::group_id,
  $artifact_id      = $fedora_repository::params::artifact_id,
  $version          = $fedora_repository::params::version,
  $nexus_server     = $fedora_repository::params::nexus_server,
  $nexus_port       = $fedora_repository::params::nexus_port,
  $install_dir      = $fedora_repository::params::install_dir,
  $stage_dir        = $fedora_repository::params::stage_dir,
  $timeout          = $fedora_repository::params::timeout,
  $user             = $fedora_repository::params::user,
  $user_ensure      = $fedora_repository::params::user_ensure,
) inherits fedora_repository::params {

  # add the user
  user { $user :
    ensure  => $installed,
    comment => $comment,
    home    => $install_dir,
  }

  #file { $install_dir :
  #  #ensure  => directory,
  #  #owner => $user,
  #  #group => $user,
  #  owner => 'root',
  #  group => 'root',
  #}


  ## Download the artifact
  ##
  #   If $nexus_server is defined get the artifact from the local
  #   nexus mirror, otherwise get it from maven central
  ##
  if $::nexue_server == undef {
    $remote_location = "http://central.maven.org/maven2/org/fcrepo/${artifact_id}/${version}/${artifact_id}-${version}.jar"
    #$remote_location = "http://central.maven.org/maven2/org/fcrepo/fcrepo-installer/3.7.1/fcrepo-installer-3.7.1.jar"
    }
    else {
      $remote_location = "http://${nexus_server}:${nexus_port}/nexus/service/local/artifact/maven/redirect?r=central&g=${group_id}&a=${artifact_id}&v=${version}"
    }

  remote_artifact{ "${stage_dir}/${artifact_id}-${version}.jar" :
    artifact_id     => $artifact_id,
    group_id        => $group_id,
    nexus_server    => $nexus_server,
    nexus_port      => $nexus_port,
    timeout         => $timeout,
    version         => $version,
    remote_location => $remote_location,
  }

  #  load the config file
  file { "${stage_dir}/install.properties" :
    ensure => present,
    owner  => $user,
    group  => $user,
    mode   => '0600',
    source => "puppet:///modules/${module_name}/install.properties.3.7.1",
  }

  # Install fedora
  exec { "${artifact_id}-${version}" :
    #cwd        => $stage_dir,
    cwd         => '/tmp',
    command     => "/etc/alternatives/java -jar ${stage_dir}/${artifact_id}-${version}.jar ${stage_dir}/install.properties",
    #command     => "/usr/lib/jvm/jre-1.7.0-openjdk.x86_64/bin/java -jar ${stage_dir}/${artifact_id}-${version}.jar ${stage_dir}/install.properties",
    #command     => "/etc/alternatives/java -jar /tmp/fcrepo-installer-3.7.1.jar /tmp/install.properties",
    creates     => "${install_dir}/tomcat",
    environment => ['JAVA_HOME=/etc/alternatives/java', "FEDORA_HOME=${install_dir}","CATALINA_HOME=${install_dir}/tomcat"],
    timeout     => '300',
    tries       => '3',
    try_sleep   => '5',
    #user       => $user,
    user        => 'root',
    logoutput   => true,
    #require    => [ Class['java'], File["${install_dir}"] ],
    require     => Class['java'],
    #require     => Java::Oracle['jfk8'],
  }

  # chown the installation to $user
  #file { $install_dir :
  #  owner   => $user,
  #  group   => $user,
  #  recurse => true,
  #  require => Exec["${artifact_id}-${version}"],
  #}

}
