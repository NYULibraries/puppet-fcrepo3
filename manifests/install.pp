# == Class: fcrepo3
#
# Full description of class fcrepo3 here.
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
class fcrepo3::install (
  $comment          = $fcrepo3::params::comment,
  $group_id         = $fcrepo3::params::group_id,
  $artifact_id      = $fcrepo3::params::artifact_id,
  $version          = $fcrepo3::params::version,
  $nexus_server     = $fcrepo3::params::nexus_server,
  $nexus_port       = $fcrepo3::params::nexus_port,
  $install_dir      = $fcrepo3::params::install_dir,
  $stage_dir        = $fcrepo3::params::stage_dir,
  $timeout          = $fcrepo3::params::timeout,
  $user             = $fcrepo3::params::user,
  $user_ensure      = $fcrepo3::params::user_ensure,
) inherits fcrepo3::params {

  # add the user
  #user { $user :
  #  ensure  => $installed,
  #  comment => $comment,
  #  home    => $install_dir,
  #}

  file { $install_dir :
    #ensure  => directory,
    #owner => $user,
    #group => $user,
    owner => 'root',
    group => 'root',
  }


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
