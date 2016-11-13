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
class fedora_repository::uninstall (
  $artifact_id = $fedora_repository::params::artifact_id,
  $stage_dir   = $fedora_repository::params::stage_dir,
  $version     = $fedora_repository::params::version,
) inherits fedora_repository::params {

  class { fedora_repository :
    installed => absent,
  }

  #file { "${stage_dir}/install.properties remove" :
  #  ensure => absent,
  #  path   => "${stage_dir}/install.properties",
  #}

  #file { "${stage_dir}/${artifact_id}-${version}.jar remove" :
  #  ensure => absent,
  #  path   => "${stage_dir}/${artifact_id}-${version}.jar",
  #}

  #file { '/etc/init.d/fedora_tomcat remove' :
  #  ensure => absent,
  #  path   => '/etc/init.d/fedora_tomcat',
  #}

}
