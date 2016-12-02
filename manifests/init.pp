# == Class: fcrepo3
#
#
# To install
#
# include fcrepo3
#
# To uninstall,
#   
#   class { fcrepo3 :
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
  $installed    = $fcrepo3::params::installed,
  $nexus_server = $fcrepo3::params::nexus_server,
  $nexus_port   = $fcrepo3::params::nexus_port,
  $user         = $fcrepo3::params::user,
  $version      = $fcrepo3::params::version,
) inherits fcrepo3::params {

  class { 'fcrepo3::install' :
    group_id     => $group_id,
    artifact_id  => $artifact_id,
    version      => $version,
    nexus_server => $nexus_server,
    nexus_port   => $nexus_port,
  }
  class { 'fcrepo3::service' :
    user => $user,
  }

}
