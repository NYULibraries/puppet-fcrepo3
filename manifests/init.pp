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
class fedora_repository (
  $installed = $fedora_repository::params::installed,
  $nexus_server = $fedora_repository::params::nexus_server,
) inherits fedora_repository::params {

  class { fedora_repository::user :
    installed => $installed,
  }
  include fedora_repository::user
  include fedora_repository::install
  include fedora_repository::service

}
