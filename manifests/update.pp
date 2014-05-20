class supervisor::update {
  exec { 'supervisor::update':
    command     => '/usr/bin/supervisorctl update || sleep 5',
    logoutput   => true,
    refreshonly => true,
    require     => Service[$supervisor::params::system_service],
  }
}
