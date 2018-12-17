# mydocker/manifests/service.pp
class mydocker::service {
  service { 'docker':
    ensure => running,
    enable => true,
  }
}
