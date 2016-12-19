#
define fcrepo3::remote_artifact (
  $artifact_id=undef,
  $group_id=undef,
  $nexus_server=undef,
  $mode='0644',
  $nexus_port=undef,
  $remote_location=undef,
  $timeout=undef,
  $version=undef,
  ){
  exec{"retrieve_${title}":
    command => "/usr/bin/wget -q \"${remote_location}\" -O ${title} -T ${timeout}",
    creates => $title,
  }
  file {$title:
    mode    => $mode,
    require => Exec["retrieve_${title}"],
  }
}

