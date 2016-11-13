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

  # Download the artifact
  remote_artifact{"${stage_dir}/${artifact_id}-${version}.jar":
    artifact_id     => $artifact_id,
    group_id        => $group_id,
    nexus_server    => $nexus_server,
    nexus_port      => $nexus_port,
    timeout         => $timeout,
    version         => $version,
    remote_location => "http://${nexus_server}:${nexus_port}/nexus/service/local/artifact/maven/redirect?r=central&g=${group_id}&a=${artifact_id}&v=${version}",
  }

  # Install
  exec { "${artifact_id}-${version}" :
    cwd       => $install_dir,
    command   => "/etc/alternatives/java -jar ${stage_dir}/${artifact_id}-${version}.jar ${stage_dir}/install.properties",
    creates   => "${install_dir}/tomcat",
    #environment => ["JAVA_HOME=/etc/alternatives/java", "FEDORA_HOME=${install_dir}","CATALINA_HOME=$INSTALL_DIR}/tomcat"],
    timeout   => '300',
    tries     => '5',
    try_sleep => '5',
    user      => $user,
    logoutput => true,
    require   => Class['java'],
  }
}
