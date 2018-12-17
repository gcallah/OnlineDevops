# mydocker/manifests/init.pp
class mydocker {
  contain mydocker::install
  contain mydocker::config
  contain mydocker::service

  Class['mydocker::install'] -> Class['mydocker::config'] -> Class['mydocker::service']
}
