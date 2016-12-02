# == Class: fcrepo3
#
# Full description of class fcrepo3 here.
#
# === Authors
#
# Flannon Jackson flannon@nyu.edu
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class fcrepo3::params {
  $artifact_id      = 'fcrepo-installer'
  $group_id         = 'org.fcrepo'
  $installed        = 'present'
  $nexus_server     = undef
  $nexus_port       = '8081'
  $stage_dir        = '/tmp'
  $timeout          = '300'
  $user             = 'fedora'
  $install_dir      = "/opt/${user}"
  $version          = '3.7.0'
}
