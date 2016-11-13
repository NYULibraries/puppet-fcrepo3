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
class fedora_repository::uninstall {

  class { fedora_repository :
    installed => absent,
  }

}
