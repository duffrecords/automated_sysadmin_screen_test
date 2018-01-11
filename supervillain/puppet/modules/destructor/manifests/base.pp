# destructor::base
class destructor::base {
  package { 'unzip':
    ensure => installed,
  }

  file { '/litmus':
    ensure => 'directory',
    mode   => '0750',
  }

  file { '/challenges':
    ensure => 'directory',
    mode   => '0750',
  }

  file{'run_litmus_test.sh':
    ensure  => present,
    path    => '/litmus/run_litmus_test.sh',
    require => [File['/litmus']],
    mode    => '0755',
    source  => 'puppet:///modules/destructor/run_litmus_test.sh',
  }


  file { '/etc/motd':
    content => "

               _   _              _   _            _
              | | | |            | | | |          | |
              | |_| | ___ _   _  | |_| | __ _  ___| | _____ _ __
              |  _  |/ _ \ | | | |  _  |/ _` |/ __| |/ / _ \ '__|
              | | | |  __/ |_| | | | | | (_| | (__|   <  __/ |
              \_| |_/\___|\__, | \_| |_/\__,_|\___|_|\_\___|_|
                           __/ |
                          |___/
               You can find the problems in /challenges directory
               You have full power on this machine, you are sudoer
                             Good luck :)

",
  }
}
