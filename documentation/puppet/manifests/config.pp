# mydocker/manifests/config.pp
class mydocker::config {
  # enable a non-root user to use Docker

  # configure Docker group
  group { 'docker':
    ensure => present,
  }

  # ensure that the user account exists, is configured, and added to docker group
  user { 'ashley':
    ensure   => present,
    home     => '/home/ashley',
    password => 'myp@ssw0rd',
  }
}
