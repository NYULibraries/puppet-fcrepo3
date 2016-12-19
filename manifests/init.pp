# == Class: fedora_repository
#
#
# To install
#
# include fedora_repository
#
# To uninstall,
#   
#   class { fedora_repository :
#     installed => absent,
#   }
#
#
# === Authors
#
# Flannon Jackson, flannon@nyu.edu
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class fcrepo3 (
  $installed    = $fedora_repository::params::installed,
  $nexus_server = $fedora_repository::params::nexus_server,
  $nexus_port   = $fedora_repository::params::nexus_port,
  $user         = $fedora_repository::params::user,
  $version      = $fedora_repository::params::version,
) inherits fedora_repository::params {

  class { 'fedora_repository::install' :
    group_id     => $group_id,
    artifact_id  => $artifact_id,
    version      => $version,
    nexus_server => $nexus_server,
    nexus_port   => $nexus_port,
  }
  #class { 'fedora_repository::service' :
  #  user => $user,
  #}

}
