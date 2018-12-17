# mydocker/manifests/install.pp
class mydocker::install {
  if $facts['operatingsystem'] == 'windows' {
    exec { 'install docker provider':
      command  => 'Install-Module DockerMsftProvider -Force',
      unless   => 'if (Get-Module -ListAvailable | Select-String docker) { exit 0 } else { exit 1 }',
      provider => powershell,
    }

    exec { 'install docker package':
      command  => 'Install-Package Docker -ProviderName DockerMsftProvider -Force',
      unless   => 'if (Get-Package Docker) { exit 0 } else { exit 1 }',
      provider => powershell,
      require  => Exec['install docker provider'],
    }

    windowsfeature { 'Containers':
      ensure => present,
    }

    reboot { 'reboot after enabling containers feature':
      when      => pending,
      subscribe => Windowsfeature['Containers'],
    }
  }
  else {
    # Setup the repository
    if $facts['operatingsystem'] == 'CentOS' {
      package { [
        'yum-utils',
        'device-mapper-persistent-data',
        'lvm2',
      ]:
        ensure => present,
      }

      exec { 'set up stable repo':
        command     => '/usr/bin/yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo',
        refreshonly => true,
        subscribe   => Package['yum-utils'],
      }
    }
    elsif $facts['operatingsystem'] == 'Ubuntu' {
      # update the apt package index
      exec { 'update apt-get':
        command => '/usr/bin/apt-get update',
        onlyif  => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
      }

      # install a single package to allow apt to use a repository over HTTPS
      package { 'apt-transport-https':
        ensure  => present,
        require => Exec['update apt-get'],
      }

      # install a multiple packages passed as an array to a single resource to allow apt to use a repository over HTTPS
      package { [
        'ca-certificates',
        'curl',
        'software-properties-common',
      ]:
        ensure  => present,
        require => Exec['update apt-get'],
      }

      # add Docker's official GPG key
      exec { 'add docker gpg key':
        command => '/usr/bin/curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -',
        unless  => '/usr/bin/apt-key fingerprint 0EBFCD88',
        require => Exec['update apt-get'],
        notify  => Exec['setup stable repo'],
      }

      exec { 'setup stable repo':
        command     => '/usr/bin/add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"',
        refreshonly => true,
        require     => Exec['add docker gpg key'],
        notify      => Exec['update apt package index']
      }

      # Update the apt package index after repo setup
      exec { 'update apt package index':
        command     => '/usr/bin/apt-get update',
        refreshonly => true,
      }
    }
    else {
      fail('OS is not supported')
    }
    # Install Docker CE
    package { 'docker-ce':
      ensure   => present,
    }
  }
}
