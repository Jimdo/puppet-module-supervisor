class supervisor::reread {
  exec {'supervisor::reread':
    command     => '/usr/bin/supervisorctl reread',
    logoutput   => on_failure,
    refreshonly => true,
    require     => Service[$supervisor::params::system_service],
  }
}
