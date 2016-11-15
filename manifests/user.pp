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
    ensure      => $installed,
    comment     => 'Fedora system user',
    home        => $install_dir,
    #managehome => true,
  }

  #file { $install_dir :
  #  ensure => directory,
  #  owner  => $user,
  #  group  => $user,
  #  mode   => '0755',
  #}

}
