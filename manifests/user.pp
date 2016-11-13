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
class fedora_repository::user (
  $install_dir   = $fedora_repository::params::install_dir,
  $user          = $fedora_repository::params::user,
  $installed   = $fedora_repository::params::installed,
) inherits fedora_repository::params {

  user { $user :
    ensure     => $installed,
    home       => $install_dir,
    managehome => true,
  }

  file { $install_dir :
    mode => '0755',
  }

}
